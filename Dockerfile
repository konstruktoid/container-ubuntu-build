
FROM scratch
ADD ./trusty-1611022058.txz /
ENV SHA 129bc99de56aa732b28b572ec15d28a876db507a2cf405c2dc9068458d08739d

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

