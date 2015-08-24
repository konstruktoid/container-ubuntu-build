#!/bin/sh

release="trusty"
mirror="http://se.archive.ubuntu.com/ubuntu/"

cmd="/usr/sbin/debootstrap"
dir="./$release"

ID=$(id -u)
if [ "x$ID" != "x0" ]; then
  echo "root privileges required."
  exit 1
fi

if test -x $cmd; then
  echo "$cmd is installed. Moving on."
  else
  echo "$cmd not installed. Installing debootstrap."
  apt-get update
  apt-get install debootstrap
fi

mkdir -p $dir

debootstrap --arch=amd64 --variant=minbase $release $dir $mirror

if [ "$?" -ne "0" ]; then
  echo "Something broke. Try running the script again. Exiting."
  exit 1
fi

hosts="
127.0.0.1 localhost
::1 localhost ip6-localhost ip6-loopback$
ff02::1 ip6-allnodes$
ff02::2 ip6-allrouters$
"

printf '%s\n' "$hosts" | sed 's/^ //g' > $dir/etc/hosts

policy='
#!/bin/sh
exit 101
'

printf '%s\n' "$policy" | sudo tee $dir/usr/sbin/policy-rc.d > /dev/null
chmod +x $dir/usr/sbin/policy-rc.d

chroot $dir dpkg-divert --local --rename --add /sbin/initctl
chroot $dir ln -sf /bin/true sbin/initctl

chroot $dir apt-get update
chroot $dir apt-get -y upgrade
chroot $dir apt-get clean

grep -v -e 'root' -e 'nobody' $dir/etc/passwd | awk -F ':' '{print $1}' | \
 while IFS= read -r userlist
do
  chroot $dir userdel -r "$userlist"
done

rm -rf $dir/dev $dir/proc
mkdir -p $dir/dev $dir/proc

rm -rf $dir/var/lib/apt/lists/*
rm -rf $dir/usr/share/doc $dir/usr/share/doc-base \
  $dir/usr/share/man $dir/usr/share/locale $dir/usr/share/zoneinfo

find $dir -user root -perm -2000 -exec chmod -s {} \;
find $dir -user root -perm -4000 -exec chmod -s {} \;

echo ".git" > .dockerignore

if ls -1 ./*.txz 2>/dev/null; then
  for t in ./*.txz; do
    echo "$t" >> .dockerignore
  done
fi

date="$(date +%y%m%d%H%M)"
tar --numeric-owner -caf "$release-$date.txz" -C "$dir" --transform='s,^./,,' .

SHA="$(openssl sha1 -sha256 "$release-$date.txz" | awk '{print $NF}')"

dockerfile="
FROM scratch
ADD ./$release-$date.txz /
ENV SHA $SHA
"

printf '%s\n' "$dockerfile" | sed 's/^ //g' > ./Dockerfile

rm -rf $dir
