#!/bin/sh

echo $1 '---' $2;
# Based on wordpress:cli entrypoint
# https://github.com/docker-library/wordpress/blob/master/php7.2/cli/docker-entrypoint.sh

if [ "${1#-}" != "$1" ]; then
	set -- wp "$@"
fi

install_dir="/var/www"

# if our command is a valid wp-cli subcommand (say plugin), let's invoke it through wp-cli instead
# (this allows for "docker run wordpress:cli help", etc)
# documenation of the subcommand is shown
if wp --path=$install_dir help "$1" > /dev/null 2>&1; then
	set -- wp "$@"
fi
echo 'Executing'


# Execute aliases in the make file or directly the provided command
if [ "$1" == "install" ] && [ ! $(wp core is-installed --path="$install_dir") ]; then
    echo 'DOWNLOADING WORDPRESS CLI'
    wp core download --path=$install_dir
    echo 'CREATING WORDPRESS CONFIG AT' $install_dir
    ls $install_dir
    wp config create --path="$install_dir" --dbname=$WP_DB_NAME --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb --dbcharset="utf8" --dbcollate="utf8_general_ci"
    cat $install_dir/wp-config.php
    echo 'CORE INSTALL WORDPRESS CONFIG'
    wp core install --path=$install_dir --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL
    echo 'CREATING USER'
    wp user create --path=$install_dir $WP_USER $WP_EMAIL --user_pass=$WP_PWD --role="editor"
else
  echo "WPCLI EXEC: $1"
  exec "$@"
fi

exec /bin/sh