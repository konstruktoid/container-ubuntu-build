
FROM scratch
LABEL maintainer='Thomas Sjögren <konstruktoid@users.noreply.github.com>'
ADD ./eoan-2001271132.txz /
ENV SHA256 3bd202018294aec25fe2ca7ff4a6b9ae262ccca8215602150678ef122f4a8308

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

