# PHP 
# ZooWPS
# DropBox Code

# CREDITS: Based on http://www.peterstratton.com/2014/04/how-to-install-postgis-2-dot-1-and-postgresql-9-dot-3-on-ubuntu-servers/

FROM zoowps_php

MAINTAINER Jonathan Mayer jonathan.mayer@ecountability.co.uk

# Testing DropBox integration -----------------

RUN cd /usr/local/src && \
wget https://www.dropbox.com/sh/im6k3in523shylt/AADtDIGJUTyGQK10Ku_BQQQPa?dl=1 -O zoophpsrc.zip 

# Okay this is a bit dangerous but unzip doesn't seem to be working too well on dropbox zipfiles - I have to assume that the folder is being extracted and return 0=success  otherwise docker build will fail
RUN cd /usr/local/src && \
unzip -j zoophpsrc.zip -d /usr/local/src/zoophpsrc; exit 0
# -------------------------------------------------

# Copy the DropBox Code into /var/www/cgi-bin and then enable it



RUN cp /usr/local/src/zoophpsrc/* /var/www/cgi-bin/

RUN chmod 755 /var/www/cgi-bin/*













   
