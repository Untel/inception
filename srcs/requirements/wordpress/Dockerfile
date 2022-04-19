FROM      alpine

RUN       apk update
RUN       apk upgrade
RUN       apk add --no-cache &&\
                apk php7-phar php7-session php7-fpm php7-mbstring php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom

RUN       adduser -D -g 'www' www
RUN       mkdir -p /var/www
RUN       mkdir -p /var/log
RUN       chown -R www:www /var/www
RUN       chown -R www:www /var/log

ADD       https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp
RUN       chmod +x /usr/local/bin/wp
RUN       chown www:www /usr/local/bin/wp
COPY      /tools/wordpress.sh /tmp/wordpress.sh

# COPY      /conf/wp-config.php wp-config.php
RUN       wp core download --path=/var/www --allow-root
EXPOSE    9000

WORKDIR   /var/www/wordpress
ENTRYPOINT su -c "sh /tmp/wordpress.sh" - www