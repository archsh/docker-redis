<<<<<<< HEAD
FROM alpine:3.4

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN addgroup -S redis && adduser -S -G redis redis

# grab su-exec for easy step-down from root
RUN apk add --no-cache 'su-exec>=0.2'

ENV REDIS_VERSION 3.2.2
ENV REDIS_DOWNLOAD_URL http://download.redis.io/releases/redis-3.2.2.tar.gz
ENV REDIS_DOWNLOAD_SHA1 3141be9757532139f445bd5f6f4fae293bc33d27

# for redis-sentinel see: http://redis.io/topics/sentinel
RUN set -x \
	&& apk add --no-cache --virtual .build-deps \
		gcc \
		linux-headers \
		make \
		musl-dev \
		tar \
	&& wget -O redis.tar.gz "$REDIS_DOWNLOAD_URL" \
	&& echo "$REDIS_DOWNLOAD_SHA1 *redis.tar.gz" | sha1sum -c - \
	&& mkdir -p /usr/src/redis \
	&& tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1 \
	&& rm redis.tar.gz \
	&& make -C /usr/src/redis \
	&& make -C /usr/src/redis install \
	&& rm -r /usr/src/redis \
	&& apk del .build-deps

RUN mkdir /data && chown redis:redis /data
VOLUME /data
WORKDIR /data

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
=======
FROM extvos/alpine
MAINTAINER  "Mingcai SHEN <archsh@gmail.com>"
ENV REDIS_VERSION 3.2.0

COPY entrypoint.sh /entrypoint.sh

RUN apk update && apk add redis

VOLUME /var/lib/redis
VOLUME /var/log
VOLUME /etc/redis

>>>>>>> 831ad64bb8fecf0925187d49bd22796f48374faa

EXPOSE 6379
CMD [ "redis-server" ]