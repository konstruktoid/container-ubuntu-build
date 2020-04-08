FROM konstruktoid/ubuntu:focal

LABEL maintainer='Thomas Sjögren <konstruktoid@users.noreply.github.com>'

ENV BUILDAREA /opt/buildarea

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

RUN \
  apt-get update && \
  sh -c 'yes | apt-get --assume-yes upgrade' && \
  apt-get --assume-yes install debootstrap openssl sudo xz-utils --no-install-recommends && \
  apt-get --assume-yes clean && \
  apt-get --assume-yes autoremove && \
  mkdir -p $BUILDAREA && \
  rm -rf /var/lib/apt/lists/* \
    /usr/share/doc /usr/share/doc-base \
    /usr/share/man /usr/share/locale /usr/share/zoneinfo

COPY ./buildeb.sh /buildeb.sh

WORKDIR /
VOLUME $BUILDAREA

ENTRYPOINT ["/buildeb.sh"]
CMD []
