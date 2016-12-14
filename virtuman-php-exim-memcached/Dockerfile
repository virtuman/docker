FROM virtuman/nginx-php-exim:latest

MAINTAINER Alexei Smirnov <alexei@virtuman.com>

RUN apt-get update && \
    apt-get -y --no-install-recommends install memcached sudo && \
	apt-get autoremove -yqq && \
	apt-get clean autoclean && \
    rm -Rf /tmp/* /var/tmp/* /var/lib/apt/lists/*


EXPOSE 11211

ENV DEFAULT_MEMCACHED_MEMORY_LIMIT=64m \
    DEFAULT_MEMCACHED_MAXCONN=18192 \
    DEFAULT_MEMCACHED_PORT=11211

COPY . /app

RUN chmod 750 /app/bin/* && \
    /app/bin/init_memcached.sh
