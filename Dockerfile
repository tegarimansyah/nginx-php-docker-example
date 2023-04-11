FROM php:7.4-fpm-alpine

RUN apk add --no-cache nginx && \
    mkdir -p /var/run/nginx

COPY index.php /var/www/html/
COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /etc/entrypoint.sh

RUN chmod +x /etc/entrypoint.sh

EXPOSE 80

CMD ["/etc/entrypoint.sh"]