
FROM scratch
ADD ./wily-1611022107.txz /
ENV SHA da53df4013ba9136f7663149f3bf2505c685412294eace720d0465e559f2dbb0

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

