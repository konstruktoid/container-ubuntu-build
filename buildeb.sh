#!/bin/sh
# Generate a minimal Debian or Ubuntu base image tarball with debootstrap,
# together with a Dockerfile and a README describing it.
#
# Usage: buildeb.sh <release> <mirror> [directory]

set -eu

release="${1:-}"
mirror="${2:-}"
location="${3:-}"

if [ "$(id -u)" -ne 0 ]; then
  echo "root privileges required." >&2
  exit 1
fi

if [ -z "${release}" ] || [ -z "${mirror}" ]; then
  echo "Usage: $0 <release> <mirror> [directory]" >&2
  exit 1
fi

echo "Building release ${release} using mirror ${mirror}."

cmd='/usr/sbin/debootstrap'

if [ -z "${location}" ]; then
  dir="/opt/buildarea/${release}"
else
  dir="${location}/${release}"
fi

cwd="$(dirname "${dir}")"

echo "Build directory is ${dir}."
echo "Output directory is ${cwd}."

if [ -x "${cmd}" ]; then
  echo "${cmd} is installed. Moving on."
else
  echo "${cmd} not installed. Installing debootstrap."
  apt-get update
  apt-get --assume-yes install debootstrap
fi

mkdir -p "${dir}"
cd "${cwd}"

# apt inside the chroot needs a working /dev/null. On a filesystem mounted
# nodev - /tmp very often is - the device node can be created but not opened,
# and apt-key reports that as "gpgv, gpgv2 or gpgv1 required for verification,
# but neither seems installed", which sends you looking for a missing package
# that is in fact installed. Fail here with the real reason instead.
if mknod "${dir}/.devnodetest" c 1 3 2> /dev/null &&
  [ -c "${dir}/.devnodetest" ] &&
  (: < "${dir}/.devnodetest") 2> /dev/null; then
  rm -f "${dir}/.devnodetest"
else
  rm -f "${dir}/.devnodetest"
  echo "${cwd} cannot hold usable device nodes; is it on a nodev mount?" >&2
  echo "Pick a build directory on a filesystem mounted without nodev." >&2
  exit 1
fi

# Reuse an apt-cacher-ng proxy if one is configured on the host.
if [ -f /etc/apt/apt.conf.d/01proxy ]; then
  http_proxy="$(sed -n 's/.*Acquire::http::Proxy *"\([^"]*\)".*/\1/p' \
    /etc/apt/apt.conf.d/01proxy | head -1)"
  if [ -n "${http_proxy}" ]; then
    export http_proxy
    echo "Using http proxy ${http_proxy}."
  else
    unset http_proxy
  fi
fi

if ! debootstrap --arch=amd64 --variant=minbase "${release}" "${dir}" "${mirror}"; then
  echo "debootstrap failed. Exiting." >&2
  exit 1
fi

# The trailing '$' characters in earlier revisions of this heredoc ended up
# verbatim in /etc/hosts.
cat > "${dir}/etc/hosts" <<'HOSTS'
127.0.0.1 localhost
::1 localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
HOSTS

cat > "${dir}/usr/sbin/policy-rc.d" <<'POLICY'
#!/bin/sh
exit 101
POLICY
chmod 0755 "${dir}/usr/sbin/policy-rc.d"

chroot "${dir}" dpkg-divert --local --rename --add /sbin/initctl
chroot "${dir}" ln -sf /bin/true /sbin/initctl

cat > "${dir}/etc/apt/apt.conf.d/99-docker-builddeb" <<'APTCONF'
# https://github.com/konstruktoid/hardening/blob/master/scripts/10_aptget
# https://github.com/tianon/docker-brew-ubuntu-core/blob/5a80061eeed1a4c395066d922bf7f1a0ea79e73c/bionic/Dockerfile#L21-L33
APT::Get::AutomaticRemove "true";
APT::Install-Recommends "false";
APT::Install-Suggests "false";
APT::Update::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };
Acquire::GzipIndexes "true"; Acquire::CompressionTypes::Order:: "gz";
Acquire::Languages "none";
Apt::AutoRemove::SuggestsImportant "false";
DPkg::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };
Dir::Cache::pkgcache "";
Dir::Cache::srcpkgcache "";
Unattended-Upgrade::Remove-Unused-Dependencies "true";
APTCONF

# Debian moved from "<release>/updates" to "<release>-security" in bullseye.
if grep -qi 'ubuntu' "${dir}/etc/os-release"; then
  echo "deb ${mirror} ${release}-security main multiverse" \
    > "${dir}/etc/apt/sources.list.d/99-security.list"
elif grep -qi 'debian' "${dir}/etc/os-release"; then
  echo "deb http://security.debian.org/debian-security ${release}-security main contrib non-free non-free-firmware" \
    > "${dir}/etc/apt/sources.list.d/99-security.list"
else
  echo "/etc/os-release doesn't seem to include ubuntu or debian?" >&2
fi

chroot "${dir}" apt-get update
chroot "${dir}" apt-get --assume-yes \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
  --with-new-pkgs upgrade

# Trim the attack surface. Packages that are absent make apt-get exit non-zero,
# which under set -e would abort the whole build, so failures are tolerated
# individually here.
for p in curl libgssapi3-heimdal libldap-common libldap-2.5-0 libsasl2-2 \
  libsasl2-modules libsasl2-modules-db openssl procps; do
  chroot "${dir}" apt-get --assume-yes --purge remove "${p}" || \
    echo "${p} not installed or not removable, skipping."
done

chroot "${dir}" apt-get --assume-yes clean
chroot "${dir}" apt-get --assume-yes autoclean
chroot "${dir}" apt-get --assume-yes autoremove

awk -F':' '$1 !~ /^(_apt|root|nobody|systemd.*|sync|daemon|bin|sys)$/ {print $1}' \
  "${dir}/etc/passwd" | while IFS= read -r username; do
  chroot "${dir}" userdel -r "${username}" 2> /dev/null || \
    echo "Could not remove user ${username}, skipping."
done

chroot "${dir}" usermod -L root

rm -rf "${dir:?}/dev" "${dir:?}/proc"
mkdir -p "${dir}/dev" "${dir}/proc"

# The globs below have to stay unquoted; quoting them, as earlier revisions did,
# made rm look for a directory literally named "*".
rm -rf "${dir:?}"/var/lib/apt/lists/* "${dir:?}"/var/cache/apt/archives/*.deb
rm -rf "${dir:?}/usr/share/doc" "${dir:?}/usr/share/doc-base" \
  "${dir:?}/usr/share/man" "${dir:?}/usr/share/locale" "${dir:?}/usr/share/zoneinfo"

find "${dir}" -user root -perm -2000 -exec chmod -s {} \;
find "${dir}" -user root -perm -4000 -exec chmod -s {} \;

{
  echo '.git'
  for t in ./*.txz; do
    [ -e "${t}" ] || continue
    echo "${t}"
  done
} > .dockerignore

date="$(date -u +%y%m%d%H%M)"
tarball="${release}-${date}.txz"

XZ_OPT=-9e
export XZ_OPT
LC_ALL=C tar --numeric-owner -cJf "${tarball}" -C "${dir}" --transform='s,^./,,' .

# openssl sha1 -sha256 mixed two digests; sha256sum is unambiguous.
sha256="$(sha256sum "${tarball}" | awk '{print $1}')"

cat > "Dockerfile.${release}" <<DOCKERFILE
FROM scratch

LABEL org.opencontainers.image.title="${release}" \\
      org.opencontainers.image.description="Minimal ${release} base image built with debootstrap" \\
      org.opencontainers.image.authors="Thomas Sjögren <konstruktoid@users.noreply.github.com>" \\
      org.opencontainers.image.version="${date}"

ADD ./${tarball} /

ENV SHA256=${sha256}

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get --assume-yes upgrade
DOCKERFILE

{
  echo "# ${release} Docker image"
  echo
  echo "* FILE: ${tarball}"
  echo "* SIZE: $(du -h "${tarball}" | awk '{print $1}')"
  echo "* SHA256: ${sha256}"
} > README.md

rm -rf "${dir:?}"

echo "Wrote ${tarball}, Dockerfile.${release} and README.md to ${cwd}."
