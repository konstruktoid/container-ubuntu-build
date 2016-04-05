
FROM scratch
ADD ./xenial-1604052304.txz /
ENV SHA 8a4201d1e59fa1e5089a5e6792a8c4192afed1de6270ae35fae2de59c59bdf4a

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

