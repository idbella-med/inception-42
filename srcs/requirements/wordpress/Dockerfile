FROM debian:stable-slim


RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       php-fpm php-mysql wget tar unzip ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

RUN wget https://wordpress.org/latest.tar.gz -O /tmp/wordpress.tar.gz \
    && tar -xzf /tmp/wordpress.tar.gz -C /tmp \
    && mv /tmp/wordpress/* /var/www/html/ \
    && rm -rf /tmp/wordpress* \
    && chown -R www-data:www-data /var/www/html

EXPOSE 9000

CMD ["php-fpm", "-F"]
