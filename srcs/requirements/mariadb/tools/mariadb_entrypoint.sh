#!/bin/sh
set -e

DATADIR=/var/lib/mysql

if [ ! -d "$DATADIR/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --datadir="$DATADIR" || {
        echo "mysql_install_db failed, trying mariadb-install-db..."
        mariadb-install-db --user=mysql --datadir="$DATADIR"
    }
fi

echo "Starting MariaDB..."
exec mysqld --user=mysql --datadir="$DATADIR" --bind-address=0.0.0.0
