
FROM scratch
ADD ./trusty-1801061920.txz /
ENV SHA 0a41cfa3ca02e9d6b96c1325e28683a09095889ae29e42fa062481f91e50756d

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

