FROM virtuman/nginx-php-exim:latest

COPY . /app/

RUN apt-get update && \
    apt-get install -yqq sudo git-core && \
    apt-get clean && \
    rm -Rf /tmp/* /var/tmp/* /var/lib/apt/lists/*

ENTRYPOINT []

