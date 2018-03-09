FROM extvos/alpine
MAINTAINER  "Mingcai SHEN <archsh@gmail.com>"
ENV REDIS_VERSION 3.2.0

COPY entrypoint.sh /entrypoint.sh

RUN apk update && apk add redis
RUN wget https://github.com/noqcks/gucci/releases/download/v0.0.4/gucci-v0.0.4-linux-amd64 -O /usr/bin/gucci \
    && chmod +x /usr/bin/gucci /entrypoint.sh

VOLUME /var/lib/redis
VOLUME /var/log
VOLUME /etc/redis

ADD redis.conf.template /usr/share/redis/

ENV REDIS_BIND ''
ENV REDIS_PORT 6379
ENV REDIS_PROTECTED_MODE yes
ENV REDIS_DATABASE 16
ENV REDIS_LOGLEVEL notice

ENV REDIS_MASTER_HOST ''
ENV REDIS_MASTER_PORT 6379
ENV REDIS_MASTER_AUTH ''
ENV REDIS_SLAVE_PRIORITY 100


EXPOSE 6379

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
CMD [ "redis-server", "/etc/redis/redis.conf" ]