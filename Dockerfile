
FROM scratch
ADD ./xenial-1611022123.txz /
ENV SHA 6232f6c0bf958b0c5560b6034548238c244d389552cb3a46b5dc775dd2c34de8

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

