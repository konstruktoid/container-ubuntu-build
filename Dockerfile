
FROM scratch
ADD ./bionic-1809031848.txz /
ENV SHA256 1bcf3ed142813ed07c2e2bdaf3c39a327b1416b841c262dde862d585ed5f0d03

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

