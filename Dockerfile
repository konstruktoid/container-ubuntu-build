
FROM scratch
ADD ./trusty-1605151745.txz /
ENV SHA 36b252a3b60cb64d4909deb24b0944c01978931d5b190df5cb7d8dafa4ca9e21

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

