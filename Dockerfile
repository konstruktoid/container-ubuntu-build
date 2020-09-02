
FROM scratch
LABEL maintainer='Thomas Sjögren <konstruktoid@users.noreply.github.com>'
ADD ./bionic-2009021546.txz /
ENV SHA256 e0cf3848c3f8e1ff9d53007f178a69126f0037919e34073469c5cd1bb1540433

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

