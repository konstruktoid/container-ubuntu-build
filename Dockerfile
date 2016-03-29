
FROM scratch
ADD ./wily-1603292027.txz /
ENV SHA fd39c0e5f7750ef17226481b4f36b36cc7981a7aad32e95d65f5efeb3b4542fb

ONBUILD RUN apt-get update && apt-get -y upgrade

