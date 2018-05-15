FROM konstruktoid/ubuntu:bionic

ENV BUILDAREA /opt/buildarea

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

RUN \
  apt-get update && \
  sh -c 'yes | apt-get -y upgrade' && \
  apt-get -y install debootstrap openssl sudo xz-utils && \
  mkdir -p $BUILDAREA && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* \
    /usr/share/doc /usr/share/doc-base \
    /usr/share/man /usr/share/locale /usr/share/zoneinfo

COPY ./buildeb.sh /buildeb.sh

WORKDIR /
VOLUME $BUILDAREA

ENTRYPOINT ["/buildeb.sh"]
CMD []
