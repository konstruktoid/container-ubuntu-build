
FROM scratch
ADD ./trusty-1905102034.txz /
ENV SHA256 d9d5aa835aed4227dd216d8a3b65e7d50029a560c9440a5506520f52a9dc8693

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

