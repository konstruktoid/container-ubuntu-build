
FROM scratch
LABEL maintainer='Thomas Sjögren <konstruktoid@users.noreply.github.com>'
ADD ./bionic-2001242243.txz /
ENV SHA256 8101965aaaa9f7275dcf04f48dceab6e1228a9eed952c0082f8491357e375bfa

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

