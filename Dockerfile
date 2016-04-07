
FROM scratch
ADD ./wily-1604071954.txz /
ENV SHA 4005b33d536567e3dabc95f7d27dc8344b48c511dd82d9d3776c86605bd2d8f8

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

