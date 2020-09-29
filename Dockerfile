
FROM scratch
LABEL maintainer='Thomas Sjögren <konstruktoid@users.noreply.github.com>'
ADD ./focal-2009291503.txz /
ENV SHA256 3267df36b8fb5f423a6a9c98cd1e28e884fcd818d73e470cbae9cfe0136fc762

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

