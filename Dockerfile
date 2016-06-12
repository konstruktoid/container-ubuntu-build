
FROM scratch
ADD ./wily-1606122126.txz /
ENV SHA 20877c2c417c713debd2cc69dc488ffe803f6fc0357a36b77bf388033dad2874

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

