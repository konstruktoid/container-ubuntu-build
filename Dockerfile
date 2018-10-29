
FROM scratch
ADD ./cosmic-1810292114.txz /
ENV SHA256 37bc866b42b75b85e5d3a7bda17cc7f9e8f619623671f1c92fcc9d0775fecb70

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

