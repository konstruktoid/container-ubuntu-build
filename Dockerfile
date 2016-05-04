
FROM scratch
ADD ./wily-1605042058.txz /
ENV SHA d14481afa0e6724773fbf369e4cd06dc78c731ffef97219ea8568e9b5eb69e0f

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

