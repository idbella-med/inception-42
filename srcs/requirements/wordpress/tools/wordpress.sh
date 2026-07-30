#!/bin/bash

until mysqladmin ping -h "mariadb" -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}" --silent; do
    sleep 1
done

if [ ! -f /var/www/html/wp-config.php ]; then

    wp core download --path=/var/www/html --force --allow-root

    wp config create \
        --path=/var/www/html \
        --dbname=${MYSQL_DATABASE} \
        --dbuser=${MYSQL_USER} \
        --dbpass=${MYSQL_PASSWORD} \
        --dbhost=mariadb \
        --allow-root

    wp core install \
        --path=/var/www/html \
        --url=${DOMAIN_NAME} \
        --title="Inception" \
        --admin_user=${MYSQL_ADMIN_USER} \
        --admin_password=${MYSQL_ADMIN_PASSWORD} \
        --admin_email=admin@${DOMAIN_NAME} \
        --allow-root

    wp user create \
        ${WP_SECOND_USER} \
        ${WP_SECOND_USER}@${DOMAIN_NAME} \
        --role=author \
        --user_pass=${WP_SECOND_PASSWORD} \
        --path=/var/www/html \
        --allow-root

    chown -R www-data:www-data /var/www/html
fi


exec php-fpm8.2 -F