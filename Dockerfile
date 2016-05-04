
FROM scratch
ADD ./trusty-1605042109.txz /
ENV SHA cc81b16f61ddfe9b5acc321551638dda35f03037c5e1711c9eac3a6d4b4b877f

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

