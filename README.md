## Ubuntu base image generator
Run `sudo sh buildubu.sh` to generate a Ubuntu base image.
It will use `debootstrap`, create a tar-file, generate the `Dockerfile`
and add a SHA256 checksum of the created tar-file to a `ENV` in the `Dockerfile`.
`buildeb.sh` will also add `.git` and any previously generated tar-files
to `.dockerignore`.
  
The generated Ubuntu Trusty image will weigh in around 73M compared to the 
Docker hub library version which is around 212M.
  
### Build and verify  
```sh
$ sudo bash buildeb.sh  
$ docker build -t ubuntu -f Dockerfile .  
$ docker run -t -i ubuntu bash
```  

### Recommended reading  
[Security Vulnerabilities in Docker Hub Images](http://www.infoq.com/news/2015/05/Docker-Image-Vulnerabilities)  
[Before you initiate a “docker pull”](https://securityblog.redhat.com/2014/12/18/before-you-initiate-a-docker-pull/)  
[Docker Security Cheat Sheet](https://github.com/konstruktoid/Docker/blob/master/Security/CheatSheet.md)  
[what does docker.io run -it debian sh run?](https://joeyh.name/blog/entry/docker_run_debian/)  
