FROM    alpine
RUN     apk update
RUN     apk upgrade
RUN     apk add --no-cache redis

ENTRYPOINT "redis-server"