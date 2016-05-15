
FROM scratch
ADD ./wily-1605151755.txz /
ENV SHA cd56e6f82fdc0ad46868e04e48e015331a7f73349043e1ee78f1c3a526ede307

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

