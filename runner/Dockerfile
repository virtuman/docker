FROM virtuman/nginx-php-exim:latest

COPY . /app/

RUN apt-get update && \
    apt-get install sudo && \
    apt-get clean && \
    rm -Rf /tmp/* /var/tmp/* /var/lib/apt/lists/* && \
    chmod +x /app/bin/install_composer.sh

RUN /app/bin/install_composer.sh
