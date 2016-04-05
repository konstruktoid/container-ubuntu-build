
FROM scratch
ADD ./wily-1604052253.txz /
ENV SHA 2952e793b9baf03caedc757f48c2f6da917f28b372789f3b7c86a1866cb7a5d9

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

