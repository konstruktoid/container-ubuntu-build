
FROM scratch
LABEL maintainer='Thomas Sjögren <konstruktoid@users.noreply.github.com>'
ADD ./bionic-2001231153.txz /
ENV SHA256 6756fa583782fcf7c712739ab7c8853d6a33a139fec17818933c100af534899d

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

