FROM debian:stable-slim

RUN apt-get update \
	&& apt-get install -y --no-install-recommends mariadb-server ca-certificates

COPY ./tools/mariadb_entrypoint.sh /usr/local/bin/mariadb_entrypoint.sh
RUN chmod +x /usr/local/bin/mariadb_entrypoint.sh

VOLUME ["/var/lib/mysql"]
EXPOSE 3306

CMD ["/usr/local/bin/mariadb_entrypoint.sh"]