
FROM scratch
LABEL maintainer='Thomas Sjögren <konstruktoid@users.noreply.github.com>'
ADD ./focal-2004080947.txz /
ENV SHA256 d8c085f35d076ba404e718156dbb54bbbf5818d2a24be0334371a218801d2c7c

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

