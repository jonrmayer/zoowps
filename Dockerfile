# PostGIS 2.1.2
# Ubuntu 14.04

# CREDITS: Based on http://www.peterstratton.com/2014/04/how-to-install-postgis-2-dot-1-and-postgresql-9-dot-3-on-ubuntu-servers/

FROM ubuntu:14.04

MAINTAINER Jonathan Mayer jonathan.mayer@ecountability.co.uk

# Update the Ubuntu repository indexes -----------------------------------------------------------------#
RUN apt-get update && apt-get upgrade -y

# Install dependencies - Step 1  ------------------------------------------------------------------------------------------------#
RUN apt-get install -y software-properties-common flex bison libfcgi-dev libxml2 libxml2-dev \
curl openssl autoconf apache2 python-software-properties subversion \
libmozjs185-dev python-dev build-essential

# Add UbuntuGIS repository and update - Step 2  ----------------------------------------------------------------------------------------#
RUN add-apt-repository ppa:ubuntugis/ubuntugis-unstable
RUN apt-get update

# Install GDAL - Step 3  ----------------------------------------------------------------------------------------#
RUN apt-get install libgdal1-dev -y






   
# Test Location of xslt -----------------------------------------------------------------------------------------#

CMD  echo dpkg -L packagename libxslt   
   
   
