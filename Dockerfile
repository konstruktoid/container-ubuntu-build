
FROM scratch
ADD ./yakkety-1606292126.txz /
ENV SHA db2b88c6d53e98d9552831be75d8b4bef8607150a8f201334635d29f4bd3bdc4

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

