FROM php:7-apache

RUN docker-php-source extract \
&& apt-get update \
&& apt-get install libxslt1-dev nano -y \
&& rm -rf /var/lib/apt/lists/* \
&& docker-php-ext-install xsl mysqli pdo_mysql pdo \
&& a2enmod rewrite \
&& a2enmod ssl \
&& docker-php-source delete

