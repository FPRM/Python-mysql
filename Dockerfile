FROM mysql/mysql-server

RUN apt-get update 

RUN apt-get install -y python3-pip && \
apt-get install -y python3-dev && \
apt-get install -y git



EXPOSE 3306 33060 5006
CMD ["mysqld"]