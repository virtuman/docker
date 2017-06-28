FROM virtuman/wordpress:latest

RUN apt-get update && \
    apt-get install -yqq sudo && \
    apt-get clean && \
    rm -Rf /tmp/* /var/tmp/* /var/lib/apt/lists/*

WORKDIR /var/www

ENTRYPOINT []

