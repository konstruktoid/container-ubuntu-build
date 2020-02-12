
FROM scratch
LABEL maintainer='Thomas Sjögren <konstruktoid@users.noreply.github.com>'
ADD ./bionic-2002121432.txz /
ENV SHA256 556193778538f77ddeb73355eeca57039e83946175f1485c4c56cb8ce9f586bc

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

