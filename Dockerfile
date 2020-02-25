
FROM scratch
LABEL maintainer='Thomas Sjögren <konstruktoid@users.noreply.github.com>'
ADD ./bionic-2002251233.txz /
ENV SHA256 2282bc4616b42aa04b0d992857505a95cc0c8d2a66092c72f63b264f3e1cfaea

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

