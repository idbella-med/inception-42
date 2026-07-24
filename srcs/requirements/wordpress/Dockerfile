FROM debian:bookworm

RUN apt update && apt install -y php-fpm php-mysql curl

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp


COPY ./tools/wordpress.sh /usr/local/bin/wordpress.sh
RUN chmod +x /usr/local/bin/wordpress.sh

CMD ["/usr/local/bin/wordpress.sh"]