# PostGIS 2.1.2
# Ubuntu 14.04

# CREDITS: Based on http://www.peterstratton.com/2014/04/how-to-install-postgis-2-dot-1-and-postgresql-9-dot-3-on-ubuntu-servers/

FROM ubuntugis

MAINTAINER Jonathan Mayer jonathan.mayer@ecountability.co.uk

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

ENV updated-adds-on 003 
RUN git clone https://github.com/jonrmayer/natcap_python_src.git /usr/local/natcap

RUN ln -s /usr/local/natcap/natcap/invest /usr/local/lib/python2.7/dist-packages/natcap




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

RUN  a2enmod fcgid && a2enmod cgid && a2enmod rewrite


COPY zoowpsconfig/apache2.conf /etc/apache2/apache2.conf

RUN mkdir /var/www/html/temp
RUN mkdir /var/www/html/zoo

ENV investcode 002
COPY investcode/* /usr/lib/cgi-bin/

COPY util.py /usr/lib/python2.7/ctypes


#RUN ln -s investcode /usr/lib/cgi-bin/

COPY zoowpsconfig/main.cfg /usr/lib/cgi-bin/main.cfg
COPY zoowpsconfig/.htaccess /var/www/html/zoo/.htaccess

RUN chown -R www-data:www-data /var/www/html/temp
RUN chown -R www-data:www-data /var/www/html/zoo
RUN chown -R www-data:www-data /usr/lib/cgi-bin

RUN mkdir /myvol

VOLUME /myvol

EXPOSE 80
   
# Test Location of xslt -----------------------------------------------------------------------------------------#

#CMD  echo dpkg -L packagename libxslt   
   
   
