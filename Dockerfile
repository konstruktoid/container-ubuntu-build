
FROM scratch
ADD ./trusty-1606122115.txz /
ENV SHA 700218fc8aa0201a1465499bb28a28b01db9032a55df22b8ccec6ff0a742599d

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

