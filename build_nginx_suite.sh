#!/bin/bash

set -e

NAMESPACE=virtuman

TAG=latest

PROJECT_DIR=`pwd`

PROJECTS=("virtuman-nginx-pagespeed"  "virtuman-php-exim" "virtuman-php-exim-memcached" "wordpress" "runner-php" "runner-wordpress")

NGINX_VERSION="1.13.0"

NGINX_PAGESPEED_VERSION="latest-stable"

NGINX_PSOL_VERSION="1.11.33.4"

OPENSSL_VERSION="1.0.2j"

HEADERS_MORE_VERSION="0.32"

PHP_VERSION="7.0"

while getopts n:t: opt; do
  case $opt in
  n)
      NAMESPACE=$OPTARG
      ;;
  t)
      TAG=$OPTARG
      ;;
  esac
done

shift $((OPTIND - 1))

for PROJECT in "${PROJECTS[@]}"
do

  if [ ! -d ${PROJECT_DIR}/${PROJECT} ]; then
    echo -e "ERROR :: Directory not found : ${PROJECT_DIR}/${PROJECT}"
    continue
  fi

  cd ${PROJECT_DIR}/${PROJECT}

  sed -i -r "s/ENV NGINX_VERSION .*/ENV NGINX_VERSION ${NGINX_VERSION}/g" Dockerfile
  sed -i -r "s/ENV NGINX_PAGESPEED_VERSION .*/ENV NGINX_PAGESPEED_VERSION ${NGINX_PAGESPEED_VERSION}/g" Dockerfile
  sed -i -r "s/ENV NGINX_PSOL_VERSION .*/ENV NGINX_PSOL_VERSION ${NGINX_PSOL_VERSION}/g" Dockerfile
  sed -i -r "s/ENV OPENSSL_VERSION .*/ENV OPENSSL_VERSION ${OPENSSL_VERSION}/g" Dockerfile
  sed -i -r "s/ENV HEADERS_MORE_VERSION .*/ENV HEADERS_MORE_VERSION ${HEADERS_MORE_VERSION}/g" Dockerfile
  sed -i -r "s/ENV PHP_VERSION .*/ENV PHP_VERSION ${PHP_VERSION}/g" Dockerfile

  sed -i -r "s/(nginx)([ -])[0-9\.]+/\1\2${NGINX_VERSION}/ig" README.md
  sed -i -r "s/(ngx_pagespeed)([ -])[0-9\.]+/\1\2${NGINX_PAGESPEED_VERSION}/ig" README.md
  # Special case for nginx latest-stable image
  sed -i -r "s/ngx_pagespeed-latest-stable/ngx_pagespeed-latest--stable/ig" README.md
  sed -i -r "s/(openssl)([ -])[0-9a-z\.]+/\1\2${OPENSSL_VERSION}/ig" README.md
  sed -i -r "s/(php)([ -])[0-9\.]+/\1\2${PHP_VERSION}/ig" README.md

  echo -e "Building ${NAMESPACE}/${PROJECT}:${TAG} ..."
  docker build -t ${NAMESPACE}/${PROJECT}:${TAG} .

done
