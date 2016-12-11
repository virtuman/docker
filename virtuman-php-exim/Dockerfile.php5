FROM virtuman/nginx-pagespeed:latest

MAINTAINER Alexei Smirnov <alexei@virtuman.com>


ENV PHP_VERSION 5.6

#    if [[ ${PHP_VERSION} == "5.6" ]]; then apt-get install software-properties-common && add-apt-repository ppa:ondrej/php && apt-get update; fi && \
#		if [[ ${PHP_VERSION} == "5.6" ]]; then $packagesPHP7; else $packagesPHP7; fi && \

RUN wget -O - https://download.newrelic.com/548C16BF.gpg | apt-key add - && \
    sh -c 'echo "deb http://apt.newrelic.com/debian/ newrelic non-free" > /etc/apt/sources.list.d/newrelic.list' && \
    add-apt-repository ppa:ondrej/php && \
    apt-get update && \
    packagesPHP7=' \
        php \
        php-bcmath \
        php-cli \
        php-curl \
        php-fpm \
        php-gd \
        php-igbinary \
        php-imagick \
        php-imap \
        php-intl \
        php-mbstring \
        php-mcrypt \
        php-memcache \
        php-memcached \
        php-mongodb \
        php-monolog \
        php-msgpack \
        php-mysql \
        php-recode \
        php-redis \
        php-xdebug \
        php-xml \
        php-xsl \
        php-zip ' && \
    packagesPHP5=' \
        php5.6 \
        php5.6-bcmath \
        php5.6-fpm \
        php5.6-mysql \
        php5.6-cli \
        php5.6-curl \
        php5.6-gd \
        php-imagick \
        php5.6-imap \
        php5.6-intl \
        php5.6-json \
        php5.6-ldap \
        php5.6-mbstring \
        php5.6-mcrypt \
        php5.6-memcache \
        php5.6-memcached \
        php5.6-mhash \
        php-mongodb \
        php-msgpack \
        php5.6-mysql \
        php-mysqlnd-ms \
        php5.6-opcache \
        php5.6-redis \
        php5.6-xdebug \
        php5.6-xml \
        php5.6-recode \
        php5.6-soap \
        php5.6-zip ' && \
    apt-get -y --no-install-recommends install \
		exim4 \
		newrelic-php5 \
		$packagesPHP5 \
		&& \
    newrelic-install install && \
	apt-get autoremove -yqq && \
	apt-get clean autoclean && \
    rm -Rf /tmp/* /var/tmp/* /var/lib/apt/lists/*

# ${PHP_EXTRA_PACKAGES} \
RUN mkdir /root/bin/ && \
	echo "export PATH=/root/bin:$PATH" > /root/.bashrc

EXPOSE 443
EXPOSE 80


ENV DEFAULT_ADMIN_EMAIL nobody@example.com
ENV DEFAULT_APP_ENV production
ENV DEFAULT_CHOWN_APP_DIR false
ENV DEFAULT_VIRTUAL_HOST example.com
ENV DEFAULT_APP_HOSTNAME example.com
ENV DEFAULT_APP_USER app
ENV DEFAULT_APP_GROUP app
ENV DEFAULT_APP_UID 1000
ENV DEFAULT_APP_GID 1000
ENV DEFAULT_UPLOAD_MAX_SIZE 30M
ENV DEFAULT_NGINX_MAX_WORKER_PROCESSES 8
ENV DEFAULT_NGINX_KEEPALIVE_TIMEOUT 30
ENV DEFAULT_PHP_MEMORY_LIMIT 128M
ENV DEFAULT_PHP_MAX_EXECUTION_TIME 300
ENV DEFAULT_PHP_MAX_INPUT_VARS 2000
ENV DEFAULT_PHP_PROCESS_MANAGER dynamic
ENV DEFAULT_PHP_MAX_CHILDREN 6
ENV DEFAULT_PHP_START_SERVERS 3
ENV DEFAULT_PHP_MIN_SPARE_SERVERS 2
ENV DEFAULT_PHP_MAX_SPARE_SERVERS 3
ENV DEFAULT_PHP_MAX_REQUESTS 500
ENV DEFAULT_PHP_DISABLE_FUNCTIONS false
ENV DEFAULT_PHP_XDEBUG_REMOTE_HOST 172.17.42.1
ENV DEFAULT_PHP_XDEBUG_REMOTE_PORT 9000
ENV DEFAULT_PHP_XDEBUG_IDE_KEY default_ide_key
ENV DEFAULT_EXIM_DELIVERY_MODE local
ENV DEFAULT_EXIM_MAIL_FROM example.com
ENV DEFAULT_EXIM_SMARTHOST smtp.example.org::587
ENV DEFAULT_EXIM_SMARTHOST_AUTH_USERNAME postmaster@example.com
ENV DEFAULT_EXIM_SMARTHOST_AUTH_PASSWORD password_123

ENV DEFAULT_NEWRELIC_ENABLED true
ENV DEFAULT_NEWRELIC_LICENSE DISABLED

COPY . /app

RUN chmod 750 /app/bin/*

RUN /app/bin/init_php.sh

ENTRYPOINT ["/app/bin/boot.sh"]

CMD ["/sbin/my_init"]
