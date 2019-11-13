#
#    php7-mysqli php7-phar php7-intl php7-dom php7-xmlreader php7-ctype php7-session php7-mbstring
#
# Configure PHP-FPM
# COPY config/fpm-pool.conf /etc/php7/php-fpm.d/www.conf
# COPY config/php.ini /etc/php7/conf.d/zzz_custom.ini

FROM alpine:3.10
LABEL Maintainer="Alex Shangin alex.shangin.13@gmail.com"

RUN apk update && \
    apk add --no-cache \
    # add my modules
    bash \
    php7 \
    php7-json \
    php7-openssl \
    php7-zlib \
    php7-xml \
    # ---------
    php7-mcrypt \
    php7-zip \
    php7-gd \
    php7-bz2 \
    php7-curl \
    php7-fpm && \
    rm -rf /var/cache/apk/* && \
    # Some initial php config changes
    sed -i "s|;*daemonize\s*=\s*yes|daemonize = no|g" /etc/php7/php-fpm.conf && \
    sed -i "s|;*listen\s*=\s*127.0.0.1:9000|listen = 9000|g" /etc/php7/php-fpm.d/www.conf && \
    sed -i "s|;*listen\s*=\s*/||g" /etc/php7/php-fpm.d/www.conf && \
    sed -i "s|;*memory_limit =.*|memory_limit = 512M|i" /etc/php7/php.ini && \
    sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= 0|i" /etc/php7/php.ini

RUN mkdir -p /var/www
#WORKDIR /var/www
#VOLUME /var/www
COPY src/index.php /var/www/index.php
COPY src/index.html /var/www/index.html

EXPOSE 9000

ENTRYPOINT ["/usr/sbin/php-fpm7"]