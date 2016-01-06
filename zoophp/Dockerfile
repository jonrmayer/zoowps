# PHP 
# ZooWPS

# CREDITS: Based on http://www.peterstratton.com/2014/04/how-to-install-postgis-2-dot-1-and-postgresql-9-dot-3-on-ubuntu-servers/

FROM ubuntugis

MAINTAINER Jonathan Mayer jonathan.mayer@ecountability.co.uk

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive


#PHP -----------Build & Installation------------
RUN cd /usr/local/src && \
wget http://uk1.php.net/get/php-5.5.13.tar.gz/from/this/mirror -O php-5.5.13.tar.gz && \
tar xvf php-5.5.13.tar.gz && \
cd php-5.5.13 && \
./configure --prefix=/usr --enable-embed --enable-maintainer-zts && \
make


RUN cd /usr/local/src/php-5.5.13 && \
make install && \
ldconfig 

#ZOO --------Buils & Installation---------------

RUN cd /usr/local/src && \
   svn checkout http://www.zoo-project.org/svn/trunk zoo && \
   cd /usr/local/src/zoo/thirds/cgic206 && \
   sed "s:lib64:lib:g" -i Makefile && \
   make && \
   cd /usr/local/src/zoo/zoo-project/zoo-kernel && \
   autoconf


RUN cd /usr/local/src/zoo/zoo-project/zoo-kernel && \
   ./configure --with-python --with-pyvers=2.7 --with-php --with-js=/usr/ --with-xsltconfig=/usr/bin/xslt-config  && \
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





COPY zoophpconfig/apache2.conf /etc/apache2/apache2.conf
COPY zoophpconfig/serve-cgi-bin.conf /etc/apache2/conf-available/serve-cgi-bin.conf

RUN  a2enmod fcgid && a2enmod cgid && a2enmod rewrite



RUN mkdir /var/www/html/temp
RUN mkdir /var/www/html/zoo
RUN mkdir /var/www/cgi-bin

#COPY test/* /var/www/cgi-bin

RUN cd /usr/local/src/zoo/zoo-project/zoo-services/hello-php/cgi-env/ && \
    cp hello.php /var/www/cgi-bin && \
   cp HelloPHP.zcfg /var/www/cgi-bin




#COPY investcode/* /var/www/cgi-bin/
#COPY zoowpsconfig/main.cfg /usr/lib/cgi-bin/main.cfg

RUN cp /usr/local/src/zoo/zoo-project/zoo-kernel/zoo_loader.cgi /var/www/cgi-bin/zoo_loader.cgi


#RUN ln -s investcode /usr/lib/cgi-bin/

COPY zoophpconfig/main.cfg /var/www/cgi-bin/main.cfg


#COPY zoowpsconfig/.htaccess /var/www/html/zoo/.htaccess

RUN chown -R www-data:www-data /var/www/html/temp
RUN chown -R www-data:www-data /var/www/html/zoo
#RUN chown -R www-data:www-data /usr/lib/cgi-bin


RUN chmod 755 /var/www/cgi-bin/*



RUN mkdir /myvol

VOLUME /myvol

EXPOSE 80
   
