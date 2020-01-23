#!/bin/sh

release="$1"
mirror="$2"
location="$3"

ID=$(id -u)
if [ "x$ID" != "x0" ]; then
  echo "root privileges required."
  exit 1
fi

if [ -z "$release" ] || [ -z "$mirror" ]; then
  echo "You have to define a release and mirror."
  exit 1
fi

echo "Building release $release using mirror $mirror."

cmd="/usr/sbin/debootstrap"

if [ -z "$location" ]; then
  dir="/opt/buildarea/$release"
else
  dir="$location/$release"
fi

cwd="$(dirname "$dir")"

echo "Build directory is $dir."
echo "Output directory is $cwd."

if test -x $cmd; then
  echo "$cmd is installed. Moving on."
else
  echo "$cmd not installed. Installing debootstrap."
  apt-get update
  apt-get --assume-yes install debootstrap
fi

mkdir -p "$dir"
cd "$cwd" || exit 1

# shellcheck disable=SC2163
if test -f /etc/apt/apt.conf.d/01proxy; then
  HTTPPROXY=$(grep 'Acquire::http::Proxy' /etc/apt/apt.conf.d/01proxy | sed 's/Acquire::http::Proxy /http_proxy=/g' | tr -d '";')
  export "$HTTPPROXY"
fi

if ! debootstrap --arch=amd64 --variant=minbase "$release" "$dir" "$mirror"; then
  echo "Something broke. Try running the script again. Exiting."
  exit 1
fi

hosts="
127.0.0.1 localhost
::1 localhost ip6-localhost ip6-loopback$
ff02::1 ip6-allnodes$
ff02::2 ip6-allrouters$
"

printf '%s\n' "$hosts" | sed 's/^ //g' > "$dir/etc/hosts"

policy='
#!/bin/sh
exit 101
'

printf '%s\n' "$policy" | sudo tee "$dir/usr/sbin/policy-rc.d" > /dev/null
chmod +x "$dir/usr/sbin/policy-rc.d"

chroot "$dir" dpkg-divert --local --rename --add /sbin/initctl
chroot "$dir" ln -sf /bin/true sbin/initctl

{
  echo '# https://github.com/konstruktoid/hardening/blob/master/scripts/10_aptget'
  echo '# https://github.com/tianon/docker-brew-ubuntu-core/blob/5a80061eeed1a4c395066d922bf7f1a0ea79e73c/bionic/Dockerfile#L21-L33'
  echo 'APT::Get::AutomaticRemove "true";'
  echo 'APT::Install-Recommends "false";'
  echo 'APT::Install-Suggests "false";'
  echo 'APT::Update::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };'
  echo 'Acquire::GzipIndexes "true"; Acquire::CompressionTypes::Order:: "gz";'
  echo 'Acquire::Languages "none";'
  echo 'Apt::AutoRemove::SuggestsImportant "false";'
  echo 'DPkg::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };'
  echo 'Dir::Cache::pkgcache "";'
  echo 'Dir::Cache::srcpkgcache "";'
  echo 'Unattended-Upgrade::Remove-Unused-Dependencies "true";'
} > "$dir/etc/apt/apt.conf.d/99-docker-builddeb"

chroot "$dir" apt-get update
chroot "$dir" apt-get --assume-yes upgrade

for p in curl libgssapi libgssapi* libldap* libsasl2* libssl libssl* openssl procps; do
  chroot "$dir" apt-get --assume-yes --purge remove "$p"
done

chroot "$dir" apt-get --assume-yes clean
chroot "$dir" apt-get --assume-yes autoclean
chroot "$dir" apt-get --assume-yes autoremove

grep -v -e '_apt' -e 'root' -e 'nobody' -e 'systemd' "$dir/etc/passwd" | awk -F ':' '{print $1}' | \
 while IFS= read -r userlist; do
  chroot "$dir" userdel -r "$userlist"
done

chroot "$dir" usermod -L root

rm -rf "${dir:?}/dev" "${dir:?}/proc"
mkdir -p "$dir/dev" "$dir/proc"

rm -rf "$dir/var/lib/apt/lists/*" "$dir/var/lib/dpkg/info/*"
rm -rf "$dir/usr/share/doc" "$dir/usr/share/doc-base" \
  "$dir/usr/share/man" "$dir/usr/share/locale" "$dir/usr/share/zoneinfo"

if echo "$mirror" | grep -iq ubuntu; then
  echo "deb $mirror $release main" > "$dir/etc/apt/sources.list"
elif echo "$mirror" | grep -iq debian; then
  echo "deb $mirror $release main contrib non-free" > "$dir/etc/apt/sources.list"
else
  echo "$mirror doesn't seem to include ubuntu or debian?"
fi

find "$dir" -user root -perm -2000 -exec chmod -s {} \;
find "$dir" -user root -perm -4000 -exec chmod -s {} \;

echo ".git" > .dockerignore

if ls -1 ./*.txz 2>/dev/null; then
  for t in ./*.txz; do
    echo "$t" >> .dockerignore
  done
fi

date="$(date -u +%y%m%d%H%M)"

export XZ_OPT=-9e
LC_ALL=C tar --numeric-owner -cJf "$release-$date.txz" -C "$dir" --transform='s,^./,,' .
SHA256="$(openssl sha1 -sha256 "$release-$date.txz" | awk '{print $NF}')"

dockerfile="
FROM scratch
LABEL maintainer='Thomas Sjögren <konstruktoid@users.noreply.github.com>'
ADD ./$release-$date.txz /
ENV SHA256 $SHA256

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'
"

printf '%s\n' "$dockerfile" | sed 's/^ //g' > ./Dockerfile."$release"

echo "# $release Docker image" > README.md
{
  echo
  echo "* FILE: $release-$date.txz"
  echo "* SIZE: $(du -h "$release"-"$date".txz | awk '{print $1}')"
  echo "* SHA256: $SHA256"
} >> README.md

rm -rf "$dir"
