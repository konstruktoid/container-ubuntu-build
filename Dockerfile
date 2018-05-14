
FROM scratch
ADD ./xenial-1805142139.txz /
ENV SHA cd426a6e17e7e5d35673e226129b618955aa0c38dc1ded3e4ab4fb472be8285e

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get --assume-yes upgrade

