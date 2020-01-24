
FROM scratch
LABEL maintainer='Thomas Sjögren <konstruktoid@users.noreply.github.com>'
ADD ./eoan-2001242331.txz /
ENV SHA256 50b14c69705c5c94a7c9fadfd2c77929f5a106fa9768099e4a648dd5d1061ef1

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

