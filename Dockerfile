
FROM scratch
ADD ./bionic-1905082101.txz /
ENV SHA256 83c7b0832811122bd886729275f93352a2608ecbec6f09fbcb8367db9a75cb1b

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

