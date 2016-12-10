
FROM scratch
ADD ./wily-1612102210.txz /
ENV SHA 1830d21f7b5516e6ec2dacb34b715de2326c61184b69f7f20df4146ff790a5ee

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

