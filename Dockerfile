
FROM scratch
ADD ./bionic-1905272155.txz /
ENV SHA256 ef5c16e2761d10b1c69e8e8e6d8885696465a39406292fbdc2cbefbccb328813

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

