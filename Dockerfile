
FROM scratch
ADD ./trusty-1612102200.txz /
ENV SHA 14479685cbead961b789fab4634444754af7f2dded760d500c018f4efa34aae1

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

