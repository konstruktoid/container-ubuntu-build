
FROM scratch
ADD ./xenial-1606292147.txz /
ENV SHA dfe87c8800435ff4ed077eed162531f885387effdfe38e45e37a614c0a7f6b86

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

