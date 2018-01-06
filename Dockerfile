
FROM scratch
ADD ./xenial-1801061929.txz /
ENV SHA 963e1ab57737447426ca876ae3789d12d7ae4847403151ae1bf01cfd0ede5ebe

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

