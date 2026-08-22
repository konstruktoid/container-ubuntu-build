# Ubuntu and Debian base image generator

`buildeb.sh` uses `debootstrap` to build a minimal Ubuntu or Debian root
filesystem, trims it, packs it into an xz tarball, and writes a matching
`Dockerfile` and `README.md`. The tarball's SHA256 checksum is recorded in an
`ENV` in the generated `Dockerfile`.

`buildeb.sh` also adds `.git` and any previously generated tarballs to
`.dockerignore`.

## Build and verify

```sh
sudo sh buildeb.sh <release> <mirror> [directory]
```

Run without arguments it prints that usage on stderr and exits 1. `<directory>`
defaults to `/opt/buildarea`.

For example:

```sh
$ sudo sh buildeb.sh noble http://archive.ubuntu.com/ubuntu "$(pwd)/buildarea"
$ docker build -t konstruktoid/ubuntu -f Dockerfile.noble .
$ docker run -t -i konstruktoid/ubuntu cat /etc/os-release
```

> [!WARNING]
> The script writes `Dockerfile.<release>`, `README.md` and `.dockerignore` into
> the *parent* of the build directory, overwriting whatever is already there, and
> removes the build directory when it is done.
>
> Note that `README.md` is this repository's own README. Running the script with
> the checkout as the output directory, as the `docker run -v "$(pwd)":...` line
> below would, overwrites it. Point it at a scratch directory instead.

## Using Docker

The container needs `--privileged` because `debootstrap` mounts filesystems and
chroots into the target.

The build directory also has to be on a filesystem mounted **without** `nodev`.
`apt` inside the chroot needs a working `/dev/null`, and on a `nodev` mount —
`/tmp` very often is one — the device node can be created but not opened. `apt`
reports that as `gpgv, gpgv2 or gpgv1 required for verification, but neither
seems installed`, which is misleading, since `gpgv` is present. The script
checks for this up front and stops with the real reason.

```sh
docker build --no-cache -t konstruktoid/ubuntubuild -f Dockerfile .
docker run --privileged -v "$(pwd)":/opt/buildarea konstruktoid/ubuntubuild \
  noble http://archive.ubuntu.com/ubuntu
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
* [Security Vulnerabilities in Docker Hub Images](http://www.infoq.com/news/2015/05/Docker-Image-Vulnerabilities)
* [what does docker.io run -it debian sh run?](https://joeyh.name/blog/entry/docker_run_debian/)
