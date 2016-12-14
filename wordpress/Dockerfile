FROM virtuman/nginx-php-exim-memcached:latest

MAINTAINER Alexei Smirnov <alexei@virtuman.com>


RUN curl -o /usr/local/bin/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x /usr/local/bin/wp-cli.phar && \
    echo 'alias wp="/sbin/setuser ${APP_USER:-$DEFAULT_APP_USER} /usr/local/bin/wp-cli.phar"' >> /root/.bashrc

