
FROM scratch
ADD ./wily-1609082001.txz /
ENV SHA cec8db9fa0404f064d23f84c78b60fce9d3496ee81eb52369e0ef2d3e4a7676d

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

