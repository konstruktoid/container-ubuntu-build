
FROM scratch
LABEL maintainer='Thomas Sjögren <konstruktoid@users.noreply.github.com>'
ADD ./eoan-2002121450.txz /
ENV SHA256 cf632f98aaca873dc04575c20dc5472e759012ae78aa496f01eccd9d810ccd90

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

