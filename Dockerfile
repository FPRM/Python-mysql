FROM ubuntu:16.04

MAINTAINER florian pereme <florian.pereme@altran.com>


## install package and dependecies for python 3

RUN apt-get update 

RUN apt-get install -y python3-pip 
RUN apt-get install -y python3-dev 
RUN apt-get install -y openssh-server 
RUN apt-get install -y git 
RUN cd /usr/local/bin \
&& ln -s /usr/bin/python3 python
RUN pip3 install --upgrade pip


# install mysql

RUN debconf-set-selections <<< 'mysql-server mysql-server/mypassword' 
RUN debconf-set-selections <<< 'mysql-server mysql-server/mypassword'
RUN apt-get -y install mysql-server 
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