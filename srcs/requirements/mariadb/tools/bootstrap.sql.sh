tfile=`mktemp`
cat << EOF > $tfile
    FLUSH PRIVILEGES;
    CREATE DATABASE $WP_DB_NAME DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
    GRANT ALL ON $WP_DB_NAME.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
    FLUSH PRIVILEGES;
EOF
cat $tfile > /bootstrap.sql