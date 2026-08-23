# Ubuntu and Debian base image generator

`buildeb.sh` uses `debootstrap` to build a minimal Ubuntu or Debian root
filesystem, trims it, packs it into an xz tarball, and writes a matching
`Dockerfile.<release>` and `README.<release>.md`. The tarball's SHA256 checksum
is recorded in an `ENV` in the generated `Dockerfile`.

`buildeb.sh` also writes a `.dockerignore` listing `.git` and any previously
generated tarball, so only the tarball from the current run stays in the build
context.

## Build and verify

```sh
sudo sh buildeb.sh <release> <mirror> [directory]
```

The script needs root and checks that first: run as an ordinary user it prints
`root privileges required.` and exits 1, whatever the arguments are. Run as
root with `<release>` or `<mirror>` missing, it prints the usage above on
stderr and exits 1. `<directory>` defaults to `/opt/buildarea` and may be
relative; it is resolved before the script changes directory.

For example:

```sh
$ buildarea="$(mktemp -d)"
$ sudo sh buildeb.sh noble http://archive.ubuntu.com/ubuntu "${buildarea}"
$ docker build -t konstruktoid/ubuntu -f "${buildarea}/Dockerfile.noble" "${buildarea}"
$ docker run -t -i konstruktoid/ubuntu cat /etc/os-release
```

> [!WARNING]
> The script writes `Dockerfile.<release>`, `README.<release>.md` and
> `.dockerignore` into the *parent* of the build directory, overwriting
> whatever is already there, and removes the build directory when it is done.
>
> `.dockerignore` in particular is not release specific. Point the script at a
> scratch directory rather than at a checkout you care about.

## Using Docker

The container needs `--privileged` because `debootstrap` mounts filesystems and
chroots into the target.

The build directory also has to be on a filesystem mounted **without** `nodev`.
`apt` inside the chroot needs a working `/dev/null`, and on a `nodev` mount —
`/tmp` very often is one — the device node can be created but not opened. `apt`
reports that as `gpgv, gpgv2 or gpgv1 required for verification, but neither
seems installed`, which is misleading, since `gpgv` is present. The script
checks for this up front and stops with the real reason.

The build directory is a scratch directory, not this checkout: the script
writes `.dockerignore` and the generated files into it.

```sh
docker build --no-cache -t konstruktoid/ubuntubuild -f Dockerfile .
buildarea="$(mktemp -d)"
docker run --privileged -v "${buildarea}":/opt/buildarea \
  konstruktoid/ubuntubuild noble http://archive.ubuntu.com/ubuntu
docker build -t konstruktoid/ubuntu \
  -f "${buildarea}/Dockerfile.noble" "${buildarea}"
```

## What the script strips

* Every user account except `root`, `_apt`, `nobody`, `sync`, `daemon`,
  `bin`, `sys` and the `systemd` ones.
* `curl`, `openssl`, `procps` and the GSSAPI, LDAP and SASL libraries.
  Packages that are not installed are skipped rather than failing the build.
* setuid and setgid bits on root-owned files.
* Documentation, manual pages, locales and timezone data.

`root` is locked with `usermod -L`, `policy-rc.d` blocks service startup inside
the chroot, and `/etc/apt/apt.conf.d/99-docker-builddeb` turns off recommends,
suggests, translations and the apt caches.

A `<release>-security` source is added, matching the archive layout Debian moved
to in bullseye.

## Privileges

The image has no `USER` instruction and runs as root, on purpose. `debootstrap`
creates device nodes with `mknod`, mounts `/proc` and `chroot`s into the
target, and `buildeb.sh` refuses to start as anything but uid 0. Dropping to an
unprivileged account would leave the image unable to do the one thing it is
for.

It is a build tool that is run once and discarded, not a service. It is not
published to a registry, and the container it runs in is `--privileged`
already; there is nothing for a non-root account inside it to contain.

## Reproducibility

The base image is pinned by digest, so `FROM` always resolves to the same
layers. The packages installed on top of it are deliberately *not* version
pinned: the image exists to carry a current `debootstrap` and current archive
keyrings, and `apt-get upgrade` runs on every build.

The generated images are less reproducible still. `debootstrap` resolves
whatever the mirror is serving at the time, and the tarball name carries a UTC
timestamp. Two runs of the same command on different days produce different
tarballs. The recorded `ENV SHA256=` identifies the tarball that a particular
generated `Dockerfile` was written for; it is not a value you can predict
ahead of the run.

## Generated Dockerfile

The generated `Dockerfile.<release>` starts `FROM scratch`, adds the tarball,
records the checksum as `ENV SHA256=...`, carries OCI
`org.opencontainers.image.*` labels, and has an `ONBUILD` that updates and
upgrades when a child image is built.

## Per-release branches

Previously generated images live on their own branches: `bionic`, `cosmic`,
`disco`, `eoan`, `focal`, `trusty`, `wily`, `xenial` and `yakkety`.

## Development

`.pre-commit-config.yaml` runs gitleaks, hadolint, shellcheck, actionlint
and markdownlint:

```sh
pre-commit run --all-files
```

## Recommended reading

* [Before you initiate a "docker pull"](https://www.redhat.com/en/blog/you-initiate-docker-pull)
* [Security Vulnerabilities in Docker Hub Images](https://www.infoq.com/news/2015/05/Docker-Image-Vulnerabilities)
* [what does docker.io run -it debian sh run?](https://joeyh.name/blog/entry/docker_run_debian/)
