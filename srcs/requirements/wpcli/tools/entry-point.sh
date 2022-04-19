#!/bin/sh
set -euo pipefail

# Based on wordpress:cli entrypoint
# https://github.com/docker-library/wordpress/blob/master/php7.2/cli/docker-entrypoint.sh

echo 'yoooo'

if [ "${1#-}" != "$1" ]; then
	set -- wp "$@"
fi

# if our command is a valid wp-cli subcommand (say plugin), let's invoke it through wp-cli instead
# (this allows for "docker run wordpress:cli help", etc)
# documenation of the subcommand is shown
if wp --path=/dev/null help "$1" > /dev/null 2>&1; then
	set -- wp "$@"
fi

# Execute aliases in the make file or directly the provided command
if [ "$1" == "install" ] || [ "$1" == "configure" ]; then
    wp core download --path=/var/www --allow-root
    wp config create --skip-check --path="/var/www" --dbname=$WP_DB_NAME --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb --dbcharset="utf8" --dbcollate="utf8_general_ci"
else
    echo "CLI EXEC: $@"
  exec "$@"
fi
