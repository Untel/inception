###             BaseImage
FROM            alpine as inception_alpine_php
RUN             apk update
RUN             apk upgrade
RUN             apk add --no-cache &&\
                apk add php7-phar php7-session php7-fpm php7-mbstring php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom
RUN             adduser -D -g 'www' www
RUN             mkdir -p /var/www
RUN             mkdir -p /var/log
RUN             chown -R www:www /var/www
RUN             chown -R www:www /var/log


WORKDIR         /var/www

###             Wordpress image
FROM            inception_alpine_php as inception_wordpress

RUN             touch /var/log/php7/incepool.access.log
COPY            conf/php-fpm.conf /etc/php7/php-fpm.conf
COPY            conf/incepool.conf /etc/php7/php-fpm.d/incepool.conf
EXPOSE          9000
ENTRYPOINT      su -c "/usr/sbin/php-fpm7 -F -R" - root

###             WPCli image
FROM            inception_alpine_php as inception_wpcli
RUN             apk add mariadb-client
ADD             https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp
RUN             chmod +x /usr/local/bin/wp
RUN             chown -R www:www /usr/local/bin/wp

ADD             /tools/entry-point.sh /scripts/
RUN             chmod +x /scripts/entry-point.sh

USER            www
ENTRYPOINT      /scripts/entry-point.sh
CMD             ["wp", "--allow-root"]