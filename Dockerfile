
FROM scratch
LABEL maintainer='Thomas Sjögren <konstruktoid@users.noreply.github.com>'
ADD ./eoan-2002251244.txz /
ENV SHA256 6decec51bdca0bd9357c46706ddacd82a3d25c2fed4a04d83209a65327d615f2

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

