
FROM scratch
ADD ./bionic-1801061858.txz /
ENV SHA b50fe44861f8ed091aeacba407e94673e865b9cdef6876bfe106a38511d051e1

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

ONBUILD RUN apt-get update && apt-get -y upgrade

