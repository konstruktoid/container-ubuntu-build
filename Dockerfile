
FROM scratch
LABEL maintainer='Thomas Sjögren <konstruktoid@users.noreply.github.com>'
ADD ./focal-2105200907.txz /
ENV SHA256 c93bde0884e5fe23e9307ff64497ad8be3e4e5f7f366321509f8de1c4c99ad76

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && sh -c 'yes | apt-get --assume-yes upgrade'

