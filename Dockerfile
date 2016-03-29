
FROM scratch
ADD ./xenial-1603292035.txz /
ENV SHA ed0313228bdad1b4409f63ea13aee6ab1955079dd7f5a5079080ddf42996ba49

ONBUILD RUN apt-get update && apt-get -y upgrade

