
FROM scratch
ADD ./disco-1905102010.txz /
ENV SHA256 1c8364073bf3c7f31587a7174c16eb0b7f98fefef30af1a173431131139dd5c4

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

