FROM    alpine
RUN     apk update
RUN     apk upgrade
RUN     apk add --no-cache git

RUN     adduser -D -g 'www' www
RUN     mkdir -p /var/www
RUN     chown -R www:www /var/www

ADD     tools/entry-point.sh /tmp/entry-point.sh
RUN     chmod +x /tmp/entry-point.sh
ADD     conf/adminer.php /tmp/adminer.php

USER    root

ENTRYPOINT sh /tmp/entry-point.sh