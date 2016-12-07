FROM debian:wheezy
MAINTAINER Rodrigo Manyari (rodrigo.manyari@hotmail.com)

# Installing heimdal dependencies
RUN apt-get update && apt-get install -y texinfo wget socket build-essential python libdb-dev byacc flex lib32ncurses5-dev dh-autoreconf

# Getting a fairly recent version
RUN cd /opt && wget https://www.h5l.org/dist/src/heimdal-1.5.2.tar.gz && tar -xvf heimdal-1.5.2.tar.gz

# Configuring and installing heimdal
RUN cd /opt/heimdal-1.5.2 && autoreconf -f -i && LDFLAGS="-lpthread" ./configure && make && make install

# Adding a basic krb config
ADD krb5.conf /etc/krb5.conf

# Creating the db and initiating the realm
RUN mkdir /var/heimdal && /usr/heimdal/sbin/kadmin -l init --realm-max-ticket-life=999999 --realm-max-renewable-life=999999 TESTBED.COM

# Adding start script
ADD start.sh /etc/start.sh

# Making it executable
RUN chmod 755 /etc/start.sh

# Starting the container
CMD ./etc/start.sh