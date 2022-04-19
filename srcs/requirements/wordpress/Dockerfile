FROM      alpine

RUN         apk update
RUN         apk upgrade
RUN         apk add --no-cache &&\
            apk add php7-phar php7-session php7-fpm php7-mbstring php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom

RUN         adduser -D -g 'www' www
RUN         mkdir -p /var/www
RUN         mkdir -p /var/log
RUN         chown -R www:www /var/www
RUN         chown -R www:www /var/log

EXPOSE      9000

WORKDIR     /var/www

ENTRYPOINT  su -c "/usr/sbin/php-fpm7 -F -R" - root