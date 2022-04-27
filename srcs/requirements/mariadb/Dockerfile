FROM    alpine

RUN     apk update
RUN     apk upgrade
RUN     apk add --no-cache mariadb 
RUN     apk add --no-cache mariadb-client



USER        root
COPY        /conf/my.cnf /etc/mysql/my.cnf
# COPY        /tools/bootstrap.sql.sh /bootstrap.sql.sh

ARG         WP_DB_NAME
ARG         MYSQL_USER
ARG         MYSQL_PASSWORD
ARG         MYSQL_ROOT_PASSWORD

# Anonymous users @see https://stackoverflow.com/questions/10299148/mysql-error-1045-28000-access-denied-for-user-billlocalhost-using-passw
RUN         echo -e "\
    USE mysql;\n\
    FLUSH PRIVILEGES;\n\
    DELETE FROM mysql.user WHERE User='';\n\
    GRANT ALL PRIVILEGES on *.* to 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';\n\
    GRANT ALL PRIVILEGES on *.* to 'mysql'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';\n\
    CREATE DATABASE $WP_DB_NAME CHARACTER SET utf8 COLLATE utf8_general_ci;\n\
    CREATE USER '$MYSQL_USER'@'%' IDENTIFIED by '$MYSQL_PASSWORD';\n\
    GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO '$MYSQL_USER'@'%';\n\
    FLUSH PRIVILEGES;\n\
" > /bootstrap.sql
RUN         mkdir -p /run/mysqld
RUN         chown -R mysql:mysql /run/mysqld
RUN         mariadb-install-db

EXPOSE      3306
ENTRYPOINT  mysqld

