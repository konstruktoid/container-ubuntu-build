
FROM scratch
LABEL maintainer='Thomas Sjögren <konstruktoid@users.noreply.github.com>'
ADD ./focal-2012172215.txz /
ENV SHA256 12a52a2119e412a673c558b7dc18f58faadab70f5723e70112c69d9d14352d4a

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

