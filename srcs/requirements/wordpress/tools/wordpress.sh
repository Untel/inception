#!/bin/sh

# if [ ! -f "/var/www/html/index.html" ]; then
#     wp core download --allow-root
#     wp config create --dbname=$WP_DATABASE_NAME --dbuser=$WP_DATABASE_USR --dbpass=$WP_DATABASE_PWD --dbhost=$MYSQL_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
#     wp core install --url=$DOMAIN_NAME/wordpress --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
#     wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root
#     wp theme install inspiro --activate --allow-root

#     # enable redis cache
#     sed -i "40i define( 'WP_REDIS_HOST', '$REDIS_HOST' );"      wp-config.php
#     sed -i "41i define( 'WP_REDIS_PORT', 6379 );"               wp-config.php
#     #sed -i "42i define( 'WP_REDIS_PASSWORD', '$REDIS_PWD' );"   wp-config.php
#     sed -i "42i define( 'WP_REDIS_TIMEOUT', 1 );"               wp-config.php
#     sed -i "43i define( 'WP_REDIS_READ_TIMEOUT', 1 );"          wp-config.php
#     sed -i "44i define( 'WP_REDIS_DATABASE', 0 );\n"            wp-config.php

# fi

if ! $(su -c 'wp core is-installed --path="/var/www"' - www); then
    su -c 'wp core install --path="/var/www" --url="172.17.0.2:5050" --title="WP Adda-sil" --admin_user="wpadda" --admin_password="wpadda" --admin_email="adrien@fernandes.bzh"' - www
    su -c 'wp user create --path="/var/www" "adda-sil" "adda-sil@student.42.fr" --user_pass="adda-sil" --role="editor"' - www
    su -c 'wp user create --path="/var/www" "roalvare" "roalvare@student.42.fr" --user_pass="roalvare" --role="author"' - www
    su -c 'wp user create --path="/var/www" "mchardin" "mchardin@student.42.fr" --user_pass="mchardin" --role="contributor"' - www
fi

# wp redis enable --allow-root

# echo "Wordpress started on :9000"
su -c '/usr/sbin/php-fpm7 -F' - www