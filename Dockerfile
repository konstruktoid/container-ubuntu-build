
FROM scratch
LABEL maintainer='Thomas Sjögren <konstruktoid@users.noreply.github.com>'
ADD ./bionic-2001241246.txz /
ENV SHA256 6f3ac7662a30c2a5f422f9a367c4f52c125b37435c436311ce9ef2e31bfda52c

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

