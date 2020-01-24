
FROM scratch
LABEL maintainer='Thomas Sjögren <konstruktoid@users.noreply.github.com>'
ADD ./cosmic-2001242302.txz /
ENV SHA256 e9b5cb3d63b0dd425411a7c4fd1b9e02891bdf6ac268820827856d24bd3d5707

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

