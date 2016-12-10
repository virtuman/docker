FROM phusion/baseimage:latest
#FROM funkygibbon/ubuntu:xenial

MAINTAINER Alexei Smirnov <alexei@virtuman.com>

# http://nginx.org/en/download.html
# https://github.com/pagespeed/ngx_pagespeed/releases
# Releases after 1.11.33.4 there will be a PSOL_BINARY_URL file that tells us where to look, until then this is hardcoded
# https://github.com/openresty/headers-more-nginx-module/tags
# https://www.openssl.org/source

ENV NGINX_VERSION=1.11.6 \
    PAGESPEED_VERSION=latest-stable \
    PAGESPEED_PSOL_VERSION=1.11.33.4 \
    HEADERS_MORE_VERSION=0.31 \
    OPENSSL_VERSION=1.0.2j \
    TERM=xterm-256color \
    DEBIAN_FRONTEND=noninteractive \

    DEFAULT_APP_ENV=development \
    DEFAULT_APP_USER=app \
    DEFAULT_APP_GROUP=app \
    DEFAULT_APP_UID=1000 \
    DEFAULT_APP_GID=1000 \
    DEFAULT_UPLOAD_MAX_SIZE=30M \
    DEFAULT_NGINX_MAX_WORKER_PROCESSES=8 \
    DEFAULT_CHOWN_APP_DIR=true \

    SSL_ENABLED=false

#   TZ=UTC \


#    apt-add-repository 'deb-src http://mirror.rackspace.com/ubuntu/ xenial main restricted universe multiverse' && \
RUN apt-add-repository 'deb http://mirror.rackspace.com/ubuntu/ xenial main restricted universe multiverse' && \
    apt-add-repository 'deb http://mirror.rackspace.com/ubuntu/ xenial-updates main restricted universe multiverse' && \
    apt-add-repository 'deb http://mirror.rackspace.com/ubuntu/ xenial-backports main restricted universe multiverse' && \
    apt-add-repository 'deb http://mirror.rackspace.com/ubuntu/ xenial-security main restricted universe multiverse' && \
    apt-add-repository 'deb-src http://mirror.rackspace.com/ubuntu/ xenial-updates main restricted universe multiverse' && \
    apt-add-repository 'deb-src http://mirror.rackspace.com/ubuntu/ xenial-backports main restricted universe multiverse' && \
    apt-add-repository 'deb-src http://mirror.rackspace.com/ubuntu/ xenial-security main restricted universe multiverse' && \
    useradd -r -s /usr/sbin/nologin nginx && \
    mkdir -p /var/log/nginx /var/cache/nginx && \
	apt-get update  && apt-get -y upgrade &&  \
	apt-get -y --no-install-recommends install autoconf automake build-essential ca-certificates debhelper \
                                               libgd2-xpm-dev libgeoip-dev libgoogle-perftools-dev libldap-dev libpcre3-dev \
                                               libperl-dev libssl-dev libtool libxml2-dev libxslt1-dev lsb-release \
                                               unzip wget zlib1g-dev geoip-database-contrib libatomic-ops-dev && \
	echo "Downloading nginx ${NGINX_VERSION} from http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz ..." && wget -qO - http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz | tar zxf - -C /tmp && \
	echo "Downloading headers-more ${HEADERS_MORE_VERSION} from https://github.com/openresty/headers-more-nginx-module/archive/v${HEADERS_MORE_VERSION}.tar.gz ..." && wget -qO - https://github.com/openresty/headers-more-nginx-module/archive/v${HEADERS_MORE_VERSION}.tar.gz | tar zxf - -C /tmp && \
	echo "Downloading ngx_pagespeed ${PAGESPEED_VERSION} from https://github.com/pagespeed/ngx_pagespeed/archive/${PAGESPEED_VERSION}.tar.gz..." && wget -qO - https://github.com/pagespeed/ngx_pagespeed/archive/${PAGESPEED_VERSION}.tar.gz | tar zxf - -C /tmp && \
	echo "Downloading pagespeed psol ${PAGESPEED_PSOL_VERSION} from https://dl.google.com/dl/page-speed/psol/${PAGESPEED_PSOL_VERSION}.tar.gz..." && wget -qO - https://dl.google.com/dl/page-speed/psol/${PAGESPEED_PSOL_VERSION}.tar.gz | tar xzf  - -C /tmp/ngx_pagespeed-${PAGESPEED_VERSION} && \
	echo "Downloading openssl v${OPENSSL_VERSION} from https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz ..." && wget -qO - https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz | tar xzf  - -C /tmp && \
    echo "Downloading nginx-auth-ldap from https://github.com/kvspb/nginx-auth-ldap/archive/master.tar.gz ..." && wget -qO - https://github.com/kvspb/nginx-auth-ldap/archive/master.tar.gz | tar xzf  - -C /tmp && \
    cd /tmp/nginx-${NGINX_VERSION} && \
    	./configure \
		--prefix=/etc/nginx  \
		--sbin-path=/usr/sbin/nginx  \
		--conf-path=/etc/nginx/nginx.conf  \
		--error-log-path=/var/log/nginx/error.log \
		--http-log-path=/var/log/nginx/access.log \
		--pid-path=/var/run/nginx.pid \
		--lock-path=/var/run/nginx.lock \
		--http-client-body-temp-path=/var/cache/nginx/client_temp \
		--http-proxy-temp-path=/var/cache/nginx/proxy_temp \
		--http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp  \
		--http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp  \
		--http-scgi-temp-path=/var/cache/nginx/scgi_temp  \
		--user=nginx  \
		--group=nginx  \
		--with-compat \
		--with-file-aio  \
		--with-http_addition_module  \
		--with-http_auth_request_module  \
		--with-http_dav_module  \
		--with-http_flv_module  \
		--with-http_geoip_module \
		--with-http_gunzip_module  \
		--with-http_gzip_static_module  \
		--with-http_image_filter_module \
		--with-http_mp4_module  \
		--with-http_random_index_module  \
		--with-http_realip_module  \
		--with-pcre-jit \
		--with-http_secure_link_module \
		--with-http_slice_module \
		--with-http_ssl_module  \
		--with-http_stub_status_module  \
		--with-http_sub_module  \
		--with-http_v2_module \
		--without-http_ssi_module \
		--with-libatomic \
		--with-mail \
		--with-mail_ssl_module  \
		--with-stream \
		--with-stream_realip_module \
		--with-stream_ssl_module \
        --with-stream_ssl_preread_module \
		--with-threads \
		--with-cc-opt='-g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2'  \
		--with-ld-opt='-Wl,-Bsymbolic-functions -Wl,-z,relro -Wl,--as-needed' \
		--with-ipv6 \
		--with-openssl=/tmp/openssl-${OPENSSL_VERSION} \
        --add-module=/tmp/headers-more-nginx-module-${HEADERS_MORE_VERSION} \
        --add-module=/tmp/nginx-auth-ldap-master \
		--add-module=/tmp/ngx_pagespeed-${PAGESPEED_VERSION}  && \
	make && \
	make install && \
	apt-get purge -yqq --auto-remove gcc libc6-dev make automake autoconf build-essential debhelper libatomic-ops-dev \
	                   libgoogle-perftools-dev libldap-dev libpcre3-dev libperl-dev libssl-dev libtool \
	                   libxml2-dev libxslt1-dev perl zlib1g-dev libgd2-xpm-dev && \
	apt-get install -yqq libgd3 && \
	apt-get autoremove -yqq && \
	apt-get clean autoclean && \
	rm -Rf /tmp/* /var/tmp/* /var/lib/apt/lists/*
#
# 	find /var/lib/{apt,dpkg,cache} -type f -delete 2>/dev/null && \

COPY . /app

RUN chmod 750 /app/bin/*.sh && \
    /app/bin/init_nginx.sh

EXPOSE 80 443

CMD ["/sbin/my_init"]
