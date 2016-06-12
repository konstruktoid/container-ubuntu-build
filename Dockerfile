
FROM scratch
ADD ./xenial-1606122133.txz /
ENV SHA 3c85da80dc7d849212ab43f366884a883bce919efca4100e4eaf79f4d06dd500

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

