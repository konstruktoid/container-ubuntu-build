
FROM scratch
ADD ./cosmic-1905102020.txz /
ENV SHA256 9d6c9858628e14fc914f8c38a3275c8b9b06d28ab0a50d7baaddf7dc227b125e

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

