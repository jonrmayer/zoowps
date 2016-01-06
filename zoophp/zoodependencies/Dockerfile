# Ubuntu 14.04 with GDAL as a base for Zoo WPS

# CREDITS: Based on http://www.peterstratton.com/2014/04/how-to-install-postgis-2-dot-1-and-postgresql-9-dot-3-on-ubuntu-servers/

FROM phusion/baseimage:0.9.18

MAINTAINER Jonathan Mayer jonathan.mayer@ecountability.co.uk

# Update the Ubuntu repository indexes -----------------------------------------------------------------#
ENV HOME /root

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]


RUN apt-get update && apt-get install -y wget ca-certificates

# Install dependencies - Step 1  ------------------------------------------------------------------------------------------------#
#RUN apt-get install -y software-properties-common flex bison libfcgi-dev libxml2 libxml2-dev libxslt1-dev \
#curl openssl autoconf apache2 python-software-properties subversion \
#libmozjs185-dev python-dev build-essential

RUN apt-get install flex bison libfcgi-dev \
libxml2 libxml2-dev curl openssl autoconf apache2 \
python-software-properties subversion git wget unzip libmozjs185-dev \
python-dev build-essential libfreetype6-dev  \
libcairo2-dev apache2-dev libxslt1-dev python-cheetah cssmin \
python-psycopg2  python-libxslt1  cmake  libapache2-mod-fcgid ghostscript xvfb -y


# Add UbuntuGIS repository and update - Step 2  ----------------------------------------------------------------------------------------#
RUN add-apt-repository ppa:ubuntugis/ubuntugis-unstable
RUN apt-get update



# Install GDAL - Step 3  ----------------------------------------------------------------------------------------#

RUN apt-get install libproj-dev libgdal1-dev gdal-bin python-gdal  -y







# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

