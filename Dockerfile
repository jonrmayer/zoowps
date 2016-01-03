# PostGIS 2.1.2
# Ubuntu 14.04

# CREDITS: Based on http://www.peterstratton.com/2014/04/how-to-install-postgis-2-dot-1-and-postgresql-9-dot-3-on-ubuntu-servers/

FROM ubuntugis

MAINTAINER Jonathan Mayer jonathan.mayer@ecountability.co.uk

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

RUN cd /usr/local/src && \
   svn checkout http://www.zoo-project.org/svn/trunk zoo && \
   cd /usr/local/src/zoo/thirds/cgic206 && \
   sed "s:lib64:lib:g" -i Makefile && \
   make && \
   cd /usr/local/src/zoo/zoo-project/zoo-kernel && \
   autoconf


RUN cd /usr/local/src/zoo/zoo-project/zoo-kernel && \
   ./configure --with-python --with-pyvers=2.7 --with-js=/usr/ --with-xsltconfig=/usr/bin/xslt-config  && \
   make
RUN cd /usr/local/src/zoo/zoo-project/zoo-kernel && \
   make install && \
   ldconfig


# Build Zoo WPS  from source -------------------------------------------------------------------------------------#   
RUN cd /usr/local/src/zoo/zoo-project/zoo-kernel && \
    cp main.cfg /usr/lib/cgi-bin && \
   cp zoo_loader.cgi /usr/lib/cgi-bin && \
   chown -R www-data:www-data /usr/lib/cgi-bin
  
# Add Apache/MapServer daemon
RUN mkdir /etc/service/apache2
ADD apache2.sh /etc/service/apache2/run

RUN chmod 755 /etc/service/apache2/*

# Add Apache Environment variables
RUN echo www-data > /etc/container_environment/APACHE_RUN_USER
RUN echo www-data > /etc/container_environment/APACHE_RUN_GROUP
RUN echo /var/log/apache2 > /etc/container_environment/APACHE_LOG_DIR

# Activate needed Apache modules 
RUN a2enmod cgi




RUN mkdir /myvol

VOLUME /myvol

EXPOSE 80
   
# Test Location of xslt -----------------------------------------------------------------------------------------#

#CMD  echo dpkg -L packagename libxslt   
   
   
