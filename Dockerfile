
FROM scratch
LABEL maintainer='Thomas Sjögren <konstruktoid@users.noreply.github.com>'
ADD ./eoan-2001270938.txz /
ENV SHA256 2175ab328dd1efff74b3b488bac1a19f258d76b84b66196b45f762fb736f468e

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

