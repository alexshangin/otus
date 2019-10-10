FROM alpine:3.10

LABEL maintainer="Alex Shangin alex.shangin.13@gmail.com"

RUN mkdir -p /run/nginx

RUN addgroup -g 101 -S nginx \
    && adduser -S -D -H -u 101 -h /var/cache/nginx -s /sbin/nologin -G nginx -g nginx nginx

RUN apk add --no-cache nginx

COPY config/nginx.conf /etc/nginx/nginx.conf

COPY config/nginx.vh.default.conf /etc/nginx/conf.d/default.conf

RUN mkdir -p /var/www

COPY src/index.html /var/www/index.html

#COPY src/index.php /var/www/index.php

EXPOSE 80 443

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
