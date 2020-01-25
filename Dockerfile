
FROM scratch
LABEL maintainer='Thomas Sjögren <konstruktoid@users.noreply.github.com>'
ADD ./xenial-2001250013.txz /
ENV SHA256 5e51962415d66b9456368bb810c0bb5e4f200bcfa564e0ecd3815ae0b4c0ada4

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

