#!/bin/bash
set -e

# sysctl vm.overcommit_memory=1
# echo never > /sys/kernel/mm/transparent_hugepage/enabled
if [ "$1" = 'redis-server' ]; then
    /usr/bin/gucci /usr/share/redis/redis.conf.template > /etc/redis/redis.conf
elif [ "$1" = 'redis-sentinel' ]; then
	/usr/bin/gucci /usr/share/redis/sentinel.conf.template > /etc/redis/sentinel.conf
fi
# if [ "$1" = 'redis-server' ]; then
# 	chown -R redis /var/lib/redis
# 	exec gosu redis "$@"
# fi

exec "$@"