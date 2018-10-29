
FROM scratch
ADD ./trusty-1810292054.txz /
ENV SHA256 f9ae74ef512b425a922d42330dafbc8f5f9a6a9d34659901ef6b75104d398097

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

