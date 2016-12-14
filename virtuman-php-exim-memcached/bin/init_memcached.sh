#!/bin/bash
set -e

cp -R /app/etc/* /etc

chmod 750 /etc/service/*/run
