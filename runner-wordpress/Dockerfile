FROM virtuman/nginx-php-exim-memcached:latest

COPY . /app/

RUN apt-get update && \
    apt-get install sudo git-core && \
    apt-get clean && \
    rm -Rf /tmp/* /var/tmp/* /var/lib/apt/lists/*


ENTRYPOINT []

