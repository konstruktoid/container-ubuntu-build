
FROM scratch
LABEL maintainer='Thomas Sjögren <konstruktoid@users.noreply.github.com>'
ADD ./disco-2001271004.txz /
ENV SHA256 db003561114f0e99672d7fd2deb632e7155febae8c0d37b7e53bb22b00c684aa

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

