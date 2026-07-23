FROM debian:bookworm

RUN apt update \
    apt install -y nginx

COPY ./tools/nginx.sh /usr/local/bin/nginx.sh

RUN chmod +x /usr/local/bin/nginx.sh

CMD ["/usr/local/bin/nginx.sh"]