FROM    alpine
RUN     apk update
RUN     apk upgrade
RUN     apk add --no-cache redis

ADD    conf/redis.conf /etc/redis/redis.conf

ENTRYPOINT "redis-server"