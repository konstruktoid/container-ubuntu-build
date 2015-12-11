## Debian and Ubuntu base image generator
If you're not using Docker, run `sudo sh buildeb.sh` to generate a Debian or Ubuntu base image.  
It will use `debootstrap`, create a tar-file, generate the `Dockerfile`
and add a SHA256 checksum of the created tar-file to a `ENV` in the `Dockerfile`.
`buildeb.sh` will also add `.git` and any previously generated tar-files
to `.dockerignore`.

### Build and verify
`sudo sh buildeb.sh <release> <mirror> <directory>`  

For example:
```sh
$ sudo sh buildeb.sh wheezy ftp://ftp.se.debian.org/debian/ "$(pwd)/buildarea"
$ docker build -t debian -f Dockerfile.wheezy .
$ docker run -t -i debian cat /etc/debian_version
```

### Using Docker
Debian:  
```sh
docker build -t debianbuild -f Dockerfile .
docker run --privileged -v "$(pwd)"/buildarea:/opt/buildarea konstruktoid/debianbuild wheezy ftp://ftp.se.debian.org/debian/
```

Ubuntu:  
```sh
docker run --privileged -v "$(pwd)":/opt/buildarea konstruktoid/debianbuild trusty http://se.archive.ubuntu.com/ubuntu/
```

### Recommended reading  
[Before you initiate a “docker pull”](https://securityblog.redhat.com/2014/12/18/before-you-initiate-a-docker-pull/)  
[Docker Security Cheat Sheet](https://github.com/konstruktoid/Docker/blob/master/Security/CheatSheet.md)  
[Security Vulnerabilities in Docker Hub Images](http://www.infoq.com/news/2015/05/Docker-Image-Vulnerabilities)  
[what does docker.io run -it debian sh run?](https://joeyh.name/blog/entry/docker_run_debian/)  
