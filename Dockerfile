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
apt-get install -y apt-utils && \
apt-get install -y debconf && \
apt-get install -y apache2 



RUN cd /usr/local/bin && ln -s /usr/bin/python3 python && \
pip3 install --upgrade pip


# install mysql

RUN echo 'mysql-server-5.7 mysql-server/root_password password 123456789'| debconf-set-selections
RUN echo 'mysql-server-5.7 mysql-server/root_password_again password 123456789'| debconf-set-selections
RUN apt-get -y install mysql-server-5.7

#install phpmyadmin
RUN echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
RUN echo "phpmyadmin phpmyadmin/app-password-confirm password 123456789" | debconf-set-selections
RUN echo "phpmyadmin phpmyadmin/mysql/admin-pass password 123456789" | debconf-set-selections
RUN echo "phpmyadmin phpmyadmin/mysql/app-pass password 123456789" | debconf-set-selections
RUN echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections

RUN apt-get install -y phpmyadmin

RUN mkdir -p /var/run/sshd && \
echo 'root:medica' | chpasswd && \
sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config



EXPOSE 80
EXPOSE 3306
EXPOSE 21

CMD /usr/sbin/sshd -D
#CMD /etc/init.d/mysql start -D
#CMD service apache2 restart
#CMD /usr/sbin/sshd -D