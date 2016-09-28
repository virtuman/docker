FROM funkygibbon/nginx-php-exim:latest

ENV NEWRELIC_LICENSE "REPLACE_ME"

ENV NEWRELIC_APPNAME "Docker PHP Application"

RUN echo 'deb http://apt.newrelic.com/debian/ newrelic non-free' | tee /etc/apt/sources.list.d/newrelic.list \
 && wget -O - https://download.newrelic.com/548C16BF.gpg | apt-key add - \
 && apt-get update \
 && apt-get install -y newrelic-php5 \
 && newrelic-install install \
 && echo newrelic.license="__NEWRELIC_LICENSE__" > /etc/php/5.6/fpm/conf.d/newrelic.ini \
 && echo newrelic.appname="__NEWRELIC_APPNAME__" >> /etc/php/5.6/fpm/conf.d/newrelic.ini

COPY . /app

RUN chmod +x /app/bin/* \
 && mv /app/bin/init_newrelic.sh /etc/my_init.d/10_init_newrelic.sh
