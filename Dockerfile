#################################################
# Dockerfile to build Python-Django WSGI Application Containers
# Based on Debian Jessie
#

# Set the base image to Ubuntu
FROM debian:jessie

ENV DJANGO_VER 111
ENV PYTHON_VER 34

# The path where the django app is stored
ENV APP_PATH /usr/src/app

# Main Django dir under APP_PATH, that stores wsgi.py, settings.py, etc.
ENV SITE_DIR mysite
RUN export DEBIAN_FRONTEND=noninteractive

# Update the sources list
RUN apt-get update

# Install basic applications
RUN apt-get install -y aptitude apt-utils apache2  libapache2-mod-wsgi-py3

# Install Python and Basic Python Tools
RUN apt-get install -y python3 wget

RUN apt-get install -y python3-pip python3-lxml mysql-server phpmyadmin vim

#RUN pip install --upgrade pip

#install MySQL in noninteractive way

RUN apt-get install -qy python-dev python3-dev
RUN apt-get install -qy libmysqlclient-dev

COPY requirements.txt /
# Get pip to download and install requirements:
RUN pip3 install -r /requirements.txt

COPY start.sh /
RUN chmod a+x /start.sh

#expose the port
EXPOSE 80


ENTRYPOINT ["/start.sh"]




