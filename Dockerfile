
FROM scratch
LABEL maintainer='Thomas Sjögren <konstruktoid@users.noreply.github.com>'
ADD ./trusty-2001242353.txz /
ENV SHA256 d9aeb7aef2c478c0c5c6b743afbbda3c413595dda8bea331c78ed572ef93c0d4

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

