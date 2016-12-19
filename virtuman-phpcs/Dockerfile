FROM php:7.0-alpine

RUN apk add --no-cache patch git

RUN pear install PHP_CodeSniffer && \
    git clone https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards.git /usr/local/lib/php/PHP/CodeSniffer/Standards/WordPress && \
    phpcs --config-set installed_paths /usr/local/lib/php/PHP/CodeSniffer/Standards/WordPress && \
    phpcs --config-set default_standard WordPress && \
    phpcs --config-set colors 1 && \
    phpcs --config-set show_progress 1 && \
    phpcs --config-set report_width 120 && \
    phpcs --config-set encoding utf-8

