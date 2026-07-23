FROM debian:bookworm

RUN apt update \
	&& apt install -y mariadb-server mariadb-client


COPY ./tools/mariadb.sh /usr/local/bin/mariadb.sh

RUN chmod +x /usr/local/bin/mariadb.sh

CMD ["/usr/local/bin/mariadb.sh"]