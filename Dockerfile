
FROM scratch
LABEL maintainer='Thomas Sjögren <konstruktoid@users.noreply.github.com>'
ADD ./disco-2001242318.txz /
ENV SHA256 e860a17c42017425a2c92e258d4a0735183a45d531aea861e1bb72242811a546

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

