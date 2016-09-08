
FROM scratch
ADD ./trusty-1609081938.txz /
ENV SHA 482ee092a1d5ef9124d04fb22a2df76443a31135d7593c0d6b067147d72afa92

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

