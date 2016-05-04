
FROM scratch
ADD ./xenial-1605042048.txz /
ENV SHA e6369fb903d8cf2b1411a12456cdecb27ae0ffcbb707a5af09ed044a0bf1dcb8

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

