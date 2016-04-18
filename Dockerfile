
FROM scratch
ADD ./xenial-1604182049.txz /
ENV SHA 94125cd3c990d36ac1a7caa62cd55e245a9465cba9ed5110488ec0fbeed022a8

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

