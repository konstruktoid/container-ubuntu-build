
FROM scratch
ADD ./trusty-1604182032.txz /
ENV SHA b5f3babcea79c49d904e24988a488201519a10260f1bb3d3626686f11a588bab

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

