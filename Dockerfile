
FROM scratch
LABEL maintainer='Thomas Sjögren <konstruktoid@users.noreply.github.com>'
ADD ./eoan-2001231215.txz /
ENV SHA256 9ebf68bf9325f7c52e819850e4689a97304f5b92aca436268c88e580874ae39b

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

