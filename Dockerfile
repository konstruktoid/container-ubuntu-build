
FROM scratch
ADD ./disco-1904041000.txz /
ENV SHA256 701e0f848a31fd6616bfcbded250553e5537d6f2e6cf61aebb38a9d39245ba92

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

