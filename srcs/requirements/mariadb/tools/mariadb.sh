#!/bin/bash

echo "Setting up database: ${MYSQL_DATABASE}"


sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
    mariadbd --datadir=/var/lib/mysql &
    until mysqladmin ping --silent; do
        sleep 1
    done
    mysql -u root <<-EOSQL
        CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
        CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
        CREATE USER IF NOT EXISTS '${MYSQL_ADMIN_USER}'@'%' IDENTIFIED BY '${MYSQL_ADMIN_PASSWORD}';
        GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_ADMIN_USER}'@'%';
        FLUSH PRIVILEGES;
EOSQL
    mysqladmin -u root shutdown
    wait
fi

exec mariadbd --datadir=/var/lib/mysql