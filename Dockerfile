
FROM scratch
ADD ./trusty-1604071946.txz /
ENV SHA 7dd68a9f31faaf2c8ae29f73d904c170d65b4ab4a66d5c2706de1d8c1526c27a

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

