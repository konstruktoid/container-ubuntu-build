
FROM scratch
ADD ./wily-1606292158.txz /
ENV SHA c04ccd19a0dd2e5005901e2bb5c6fb983a03b35ab7c23a6b502706ced65b6692

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

