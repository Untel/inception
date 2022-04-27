#!/bin/sh
install_dir="/var/www"
wp_opts="--path=$install_dir"
if [ "${1#-}" != "$1" ]; then
  set -- wp "$wp_opts $@"
fi
if wp --path=$install_dir help "$1" > /dev/null 2>&1; then
	set -- wp "$wp_opts" "$@"

fi
if [ "$1" == "install" ]; then
    echo 'INSTALLING VIA WORDPRESS CLI'
    if [ ! -f "$install_dir/wp-config-sample.php" ]; then
      echo 'DOWNLOADING WORDPRESS CLI'
      wp $wp_opts core download
    else
      echo 'WORDPRESS IS STILL DOWNLOADED'
    fi
    if ! wp $wp_opts core is-installed; then
      echo "MSQL USER" $MYSQL_USER " DB IS " $WP_DB_NAME
      echo -e $WP_CONFIG_EXTRA | wp $wp_opts config create --dbname=$WP_DB_NAME --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb --dbcharset=utf8 --dbcollate=utf8_general_ci --extra-php
      echo 'CORE INSTALL WORDPRESS CONFIG'
      wp $wp_opts core install --url="$DOMAIN_NAME/" --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email
      echo 'CREATING USER'
      wp $wp_opts user create --path=$install_dir $WP_USER $WP_EMAIL --user_pass=$WP_PWD --role="editor"
    else
      echo 'WORDPRESS IS STILL CONFIGURED'
    fi
else
  exec "$@"
fi