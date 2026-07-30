#!/bin/bash

sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld

if [ ! -f /var/lib/mysql/.setup_done ]; then
    echo ">>> FIRST RUN: installing database"

    if [ ! -d /var/lib/mysql/mysql ]; then
        mariadb-install-db --user=mysql --datadir=/var/lib/mysql
    fi

    mariadbd --user=mysql --datadir=/var/lib/mysql &

    until mysqladmin ping --silent; do
        sleep 1
    done

    echo ">>> creating users"
    mysql -u root <<EOSQL
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
CREATE USER IF NOT EXISTS '${MYSQL_ADMIN_USER}'@'%' IDENTIFIED BY '${MYSQL_ADMIN_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_ADMIN_USER}'@'%';
FLUSH PRIVILEGES;
EOSQL
    echo ">>> SQL exit code: $?"

    touch /var/lib/mysql/.setup_done

    mysqladmin -u root shutdown
    wait
    echo ">>> temp mariadbd stopped"
fi

exec mariadbd --user=mysql --datadir=/var/lib/mysql