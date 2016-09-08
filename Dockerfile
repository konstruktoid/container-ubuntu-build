
FROM scratch
ADD ./trusty-1606292211.txz /
ENV SHA f98ad12d06d33bf8878c8ef9938112df60571187991136c26c9ab53b07248b74

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

