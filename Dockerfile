
FROM scratch
ADD ./xenial-1810292101.txz /
ENV SHA256 ba870cd0a351b807db5b2a1b3e2a061b816fa6be85d849aefb99183156e6f944

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

