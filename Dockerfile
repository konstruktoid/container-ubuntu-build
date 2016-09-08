
FROM scratch
ADD ./xenial-1609082013.txz /
ENV SHA c72cbbfcf40a459ed09120eaa93feba745f8a53b03808d1d5bc0e50f42b7c244

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

