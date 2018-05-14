FROM konstruktoid/ubuntu:bionic

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ENV BUILDAREA /opt/buildarea

RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get -y install debootstrap openssl sudo xz-utils && \
  mkdir -p $BUILDAREA && \
  apt-get clean && \
  apt-get autoremove && \
  rm -rf /var/lib/apt/lists/* \
    /usr/share/doc /usr/share/doc-base \
    /usr/share/man /usr/share/locale /usr/share/zoneinfo

COPY ./buildeb.sh /buildeb.sh

WORKDIR /
VOLUME $BUILDAREA

ENTRYPOINT ["/buildeb.sh"]
CMD []
