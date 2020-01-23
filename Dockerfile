
FROM scratch
LABEL maintainer='Thomas Sjögren <konstruktoid@users.noreply.github.com>'
ADD ./disco-2001231205.txz /
ENV SHA256 2bdd40cd316d0abe9c8c72464b11411c956e2f259870b22d006e5ec5de5bd130

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

