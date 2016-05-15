
FROM scratch
ADD ./yakkety-1605151819.txz /
ENV SHA b185cb69cc8f1c8b8bd247a6f74d79447634ff2d9c1f99755b17e25cb8d7b126

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

