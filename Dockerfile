
FROM scratch
LABEL maintainer='Thomas Sjögren <konstruktoid@users.noreply.github.com>'
ADD ./xenial-2002131259.txz /
ENV SHA256 a9f0c1c674801837e749c39d65e0c031bf8f3c971264981af57486d85882eec8

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

