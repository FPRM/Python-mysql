FROM ubuntu:16.04

MAINTAINER florian pereme <florian.pereme@altran.com>


## install package and dependecies for python 3

RUN apt-get update 

RUN apt-get install -y python3-pip && \
 	apt-get install -y python3-dev && \
 	apt-get install -y openssh-server && \
 	apt-get install apt-utils && \
 	apt-get install -y git
RUN cd /usr/local/bin \
&& ln -s /usr/bin/python3 python
RUN pip3 install --upgrade pip


# install mysql

RUN { \
        echo mysql-community-server mysql-community-server/data-dir select ''; \
        echo mysql-community-server mysql-community-server/root-pass password '123456789'; \
        echo mysql-community-server mysql-community-server/re-root-pass password '123456789'; \
        echo mysql-community-server mysql-community-server/remove-test-db select false; \
    } | debconf-set-selections \
    && apt-get update && apt-get install -y mysql-server
#RUN mysqladmin -u root password mypassword  
#RUN apt-get install apache2 && php5 libapache2-mod-php5 php5-mcrypt && expect

# Install MySQL
#RUN apt-get install -y mysql-server mysql-client libmysqlclient-dev
# Install Apache
#RUN apt-get install -y apache2
# Install php
#RUN apt-get install -y php5 libapache2-mod-php5 php5-mcrypt

# Install expect
#RUN apt-get install -y expect

# Install phpMyAdmin
 

EXPOSE 80
EXPOSE 3306

CMD /usr/sbin/sshd -D; \
	service apache2 start; \