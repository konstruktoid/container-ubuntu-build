
FROM scratch
ADD ./xenial-1604072003.txz /
ENV SHA a237721a00cc738aac1805d320b47c178dd9b0e08b956b66eb74f4f0423c69e3

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

