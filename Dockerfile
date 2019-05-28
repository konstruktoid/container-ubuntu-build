
FROM scratch
ADD ./disco-1905281831.txz /
ENV SHA256 b61f8e16822907c0fbe36e71110584e174474686242697f1aebd0a2bab53c08b

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

