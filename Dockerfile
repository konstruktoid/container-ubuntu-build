
FROM scratch
ADD ./trusty-1805142134.txz /
ENV SHA d457e641113a4e6e5778950a4eb303801c95830b8386e31e063d40c79f1cad32

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get --assume-yes upgrade

