
FROM scratch
ADD ./xenial-1612102220.txz /
ENV SHA edb551691752618bd0e480cdc464a7a05b58a10deb3af95dbeb8525f8bf7c622

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

