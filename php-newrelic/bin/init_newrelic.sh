#!/usr/bin/env bash

echo " * newrelic: app_name:  ${NEWRELIC_APPNAME}"
echo " * newrelic: license:   ${NEWRELIC_LICENSE}"

sed -i -r "s/^newrelic\.license=.+$/newrelic.license=\"${NEWRELIC_LICENSE}\"/g" /etc/php/5.6/fpm/conf.d/newrelic.ini
sed -i -r "s/^newrelic\.appname=.+$/newrelic.license=\"${NEWRELIC_APPNAME}\"/g" /etc/php/5.6/fpm/conf.d/newrelic.ini
