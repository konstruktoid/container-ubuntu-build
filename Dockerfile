
FROM scratch
ADD ./xenial-1905102026.txz /
ENV SHA256 0a0f9496e98a0a3e281c25f5188be1ef50c7b3897de599dc82244255b2bbf07e

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

