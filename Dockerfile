# PostGIS 2.1.2
# Ubuntu 14.04

# CREDITS: Based on http://www.peterstratton.com/2014/04/how-to-install-postgis-2-dot-1-and-postgresql-9-dot-3-on-ubuntu-servers/

FROM ubuntugis

MAINTAINER Jonathan Mayer jonathan.mayer@ecountability.co.uk

RUN apt-get install libproj-dev  -y

RUN apt-get install flex bison libfcgi-dev \
libxml2 libxml2-dev curl openssl autoconf apache2 \
python-software-properties subversion git libmozjs185-dev \
python-dev build-essential libfreetype6-dev libproj-dev libgdal1-dev \
libcairo2-dev apache2-dev libxslt1-dev python-cheetah cssmin \
python-psycopg2 python-gdal python-libxslt1  cmake gdal-bin libapache2-mod-fcgid ghostscript xvfb -y

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
   make install 
# Build Zoo WPS  from source -------------------------------------------------------------------------------------#   
RUN   cp main.cfg /usr/lib/cgi-bin && \
   cp zoo_loader.cgi /usr/lib/cgi-bin && \
   chown -R www-data:www-data /usr/lib/cgi-bin
  


   
# Test Location of xslt -----------------------------------------------------------------------------------------#

#CMD  echo dpkg -L packagename libxslt   
   
   
