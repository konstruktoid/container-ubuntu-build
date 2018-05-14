
FROM scratch
ADD ./bionic-1805141435.txz /
ENV SHA dcaa2f41681cfa1987c0c75a59844adf8153383c71175df62c44f8623e8c2243

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get --assume-yes upgrade

