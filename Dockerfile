# PostGIS 2.1.2
# Ubuntu 14.04

# CREDITS: Based on http://www.peterstratton.com/2014/04/how-to-install-postgis-2-dot-1-and-postgresql-9-dot-3-on-ubuntu-servers/

FROM ubuntugis

MAINTAINER Jonathan Mayer jonathan.mayer@ecountability.co.uk



RUN cd /usr/local/src && \
   svn checkout http://www.zoo-project.org/svn/trunk zoo && \
   cd /usr/local/src/zoo/thirds/cgic206 && \
   sed "s:lib64:lib:g" -i Makefile && \
   cd /usr/local/src/zoo/zoo-project/zoo-kernel && \
   autoconf


RUN ./configure --with-python --with-pyvers=2.7 --with-js=/usr/ --with-xsltconfig=/usr/bin/xslt-config  && \
   make && \
   make install 
# Build Zoo WPS  from source -------------------------------------------------------------------------------------#   
RUN   cp main.cfg /usr/lib/cgi-bin && \
   cp zoo_loader.cgi /usr/lib/cgi-bin && \
   chown -R www-data:www-data /usr/lib/cgi-bin
  


   
# Test Location of xslt -----------------------------------------------------------------------------------------#

#CMD  echo dpkg -L packagename libxslt   
   
   
