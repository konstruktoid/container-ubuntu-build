
FROM scratch
LABEL maintainer='Thomas Sjögren <konstruktoid@users.noreply.github.com>'
ADD ./bionic-2009291448.txz /
ENV SHA256 e746164bbf43de6f28fbe75a3a470d185c911dce2251a02c3f1719feb13a78b9

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

