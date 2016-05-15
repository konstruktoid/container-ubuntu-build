
FROM scratch
ADD ./xenial-1605151803.txz /
ENV SHA 119a26e55f2c408b50e62a68499f9dcbd9c6e8833b5de44a43dd36a5524871a8

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

