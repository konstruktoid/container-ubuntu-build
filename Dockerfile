
FROM scratch
ADD ./trusty-1603292019.txz /
ENV SHA 4e1ed85c98b7e0e3772893bc07e435b2bedf2da2eb658a2bcab61a9c3ad7bb7a

ONBUILD RUN apt-get update && apt-get -y upgrade

