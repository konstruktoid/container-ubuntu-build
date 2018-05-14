
FROM scratch
ADD ./bionic-1805142130.txz /
ENV SHA 0c818d67165d61de007370b279b622d3a10a6a4e663cd2d47cd3cd1d893039de

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get --assume-yes upgrade

