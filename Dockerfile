FROM extvos/alpine
MAINTAINER  "Mingcai SHEN <archsh@gmail.com>"
ENV REDIS_VERSION 3.2.0

COPY entrypoint.sh /entrypoint.sh

RUN apk update && apk add redis
RUN wget https://github.com/noqcks/gucci/releases/download/v0.0.4/gucci-v0.0.4-linux-amd64 -O /usr/bin/gucci \
    && chmod +x /usr/bin/gucci

VOLUME /var/lib/redis
VOLUME /var/log
VOLUME /etc/redis

ADD redis.conf.template /usr/share/redis/

EXPOSE 6379
CMD [ "redis-server", "/etc/redis/redis.conf" ]