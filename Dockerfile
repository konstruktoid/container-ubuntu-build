
FROM scratch
LABEL maintainer='Thomas Sjögren <konstruktoid@users.noreply.github.com>'
ADD ./focal-2009021556.txz /
ENV SHA256 f45f662cd6ebb7daa6b9df7d82055054ed9883d141d25288daf44a076ec950b2

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

