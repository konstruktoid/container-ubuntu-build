
FROM scratch
ADD ./bionic-1904040952.txz /
ENV SHA256 ce2c1001cf5bd51668556af4c0352aea1296a003648d5a37e5116f477e19a885

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

