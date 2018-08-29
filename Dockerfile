FROM ubuntu:16.04

MAINTAINER florian pereme <florian.pereme@altran.com>

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
## install package and dependecies for python 3

RUN apt-get update 

RUN apt-get install -y python3-pip && \
apt-get install -y python3-dev && \
apt-get install -y openssh-server &&\
apt-get install -y apt-utils && \
apt-get install -y git && \
apt-get install -y apache2

RUN cd /usr/local/bin && ln -s /usr/bin/python3 python && \
pip3 install --upgrade pip


# install mysql


RUN { \
        echo mysql-community-server mysql-community-server/data-dir select ''; \
        echo mysql-community-server mysql-community-server/root-pass password '123456789'; \
        echo mysql-community-server mysql-community-server/re-root-pass password '123456789'; \
        echo mysql-community-server mysql-community-server/remove-test-db select false; \
    } | debconf-set-selections \



EXPOSE 80
EXPOSE 3306

CMD /usr/sbin/sshd -D