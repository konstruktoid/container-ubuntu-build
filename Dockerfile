
FROM scratch
ADD ./wily-1604182041.txz /
ENV SHA e6f51b22e3ff097397383de49396794dd21622ffc2752d07bc0aa5e1dc37f7b5

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

