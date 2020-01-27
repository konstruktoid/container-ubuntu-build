
FROM scratch
LABEL maintainer='Thomas Sjögren <konstruktoid@users.noreply.github.com>'
ADD ./bionic-2001270952.txz /
ENV SHA256 54ea0ffcf6fab00c9f191d768264398c6e7d7294d4e1ecd0c8ac5ebce49c35cb

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

