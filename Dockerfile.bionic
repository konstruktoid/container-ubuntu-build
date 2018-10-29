
FROM scratch
ADD ./bionic-1810292048.txz /
ENV SHA256 5c22aec77300aca153293cb712778de36ff1055b2cc3fb766b336d140f992f86

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

