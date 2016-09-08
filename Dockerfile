
FROM scratch
ADD ./trusty-1609081952.txz /
ENV SHA d57cbb13b23b44bb2efd57e8c4135cdf01d0fb21b86a503623b8e412ad1b5c9e

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

