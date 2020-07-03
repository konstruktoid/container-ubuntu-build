
FROM scratch
LABEL maintainer='Thomas Sjögren <konstruktoid@users.noreply.github.com>'
ADD ./focal-2007032045.txz /
ENV SHA256 a6c250b1cd6753e4b948f2f6cf3b3d9c140f753f4eefea92718a5e98b5f83067

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

