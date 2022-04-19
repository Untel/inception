#!/bin/sh

echo $1 '---' $2;
# Based on wordpress:cli entrypoint
# https://github.com/docker-library/wordpress/blob/master/php7.2/cli/docker-entrypoint.sh

if [ "${1#-}" != "$1" ]; then
	set -- wp "$@"
fi


# if our command is a valid wp-cli subcommand (say plugin), let's invoke it through wp-cli instead
# (this allows for "docker run wordpress:cli help", etc)
# documenation of the subcommand is shown
if wp --path=/dev/null help "$1" > /dev/null 2>&1; then
	set -- wp "$@"
fi
echo 'Executing'


# Execute aliases in the make file or directly the provided command
if [ "$1" == "install" ] || [ "$1" == "configure" ]; then
    if ! $(wp core is-installed --path="/var/www"); then
        echo 'DOWNLOADING WORDPRESS CLI'
        wp core download --path=/var/www
    fi
    echo 'CREATING WORDPRESS CONFIG'
    wp config create --path="/var/www" --dbname=$WP_DB_NAME --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb --dbcharset="utf8" --dbcollate="utf8_general_ci"
    cat /var/www/wp-config.php
    echo 'CORE INSTALL WORDPRESS CONFIG'
    wp core install --path="/var/www" --url=$DOMAIN_NAME/wordpress --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL
    echo 'CREATING USER'
    wp user create --path="/var/www" $WP_USER $WP_EMAIL --user_pass=$WP_PWD --role="editor"
else
  echo "WPCLI EXEC: $1"
  exec "$@"
fi
