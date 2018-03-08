FROM extvos/alpine
MAINTAINER  "Mingcai SHEN <archsh@gmail.com>"
ENV REDIS_VERSION 3.2.0

COPY entrypoint.sh /entrypoint.sh

RUN apk update && apk add redis

VOLUME /var/lib/redis
VOLUME /var/log
VOLUME /etc/redis

ADD redis.conf.template /etc/redis/

EXPOSE 6379
CMD [ "redis-server", "--protected-mode no" ]