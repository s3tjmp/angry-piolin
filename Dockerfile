FROM node:6
MAINTAINER Catalunya

RUN mkdir /app

# Bundle app source
ADD . /app

# Set Workdir
WORKDIR /app

ENV NGINX_VERSION 1.9.10-1~jessie

RUN echo "deb http://httpredir.debian.org/debian jessie-backports main" >> /etc/apt/sources.list \
	&& apt-get update \
	&& apt-get install -y --fix-missing xvfb wget bzip2 tar build-essential\
	&& apt-get install -y --fix-missing ca-certificates nginx gettext-base\
	&& rm -rf /var/lib/apt/lists/*

RUN ln -sf /dev/stdout /var/log/nginx/access.log\
	&& ln -sf /dev/stderr /var/log/nginx/error.log

COPY default.conf /etc/nginx/conf.d/default.conf

ENV DBUS_SESSION_BUS_ADDRESS=/dev/null

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

