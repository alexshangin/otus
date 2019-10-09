FROM alpine:3.10

LABEL maintainer="Alex Shangin alex.shangin.13@gmail.com"

RUN mkdir -p /run/nginx

RUN addgroup -g 101 -S nginx \
    && adduser -S -D -H -u 101 -h /var/cache/nginx -s /sbin/nologin -G nginx -g nginx nginx

RUN apk add --no-cache nginx

#RUN rm /etc/nginx/conf.d/default.conf
#COPY config/default.conf /etc/nginx/conf.d/default.conf

COPY config/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /www

COPY src/index.html /www/index.html

EXPOSE 80 443

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
