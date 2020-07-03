
FROM scratch
LABEL maintainer='Thomas Sjögren <konstruktoid@users.noreply.github.com>'
ADD ./bionic-2007032053.txz /
ENV SHA256 d88dc888b7c99fd9b62f08628a87c17ac842683d4b88c8da2ce0fe58bb16b955

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

