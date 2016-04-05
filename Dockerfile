
FROM scratch
ADD ./trusty-1604052237.txz /
ENV SHA 451422ad4db2b343e17204875d55d51501247beb41cf121d5197d61be7afcad7

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

