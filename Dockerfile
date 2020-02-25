
FROM scratch
LABEL maintainer='Thomas Sjögren <konstruktoid@users.noreply.github.com>'
ADD ./focal-2002251304.txz /
ENV SHA256 596026d4e22c12ed5765c3aa145c1f2b09f090d4bbd46def33df5dc0b291fd8c

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

