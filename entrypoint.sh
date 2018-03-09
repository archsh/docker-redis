#!/bin/bash
set -e

# sysctl vm.overcommit_memory=1
# echo never > /sys/kernel/mm/transparent_hugepage/enabled
/usr/bin/gucci /usr/share/redis/redis.conf.template > /etc/redis/redis.conf
# if [ "$1" = 'redis-server' ]; then
# 	chown -R redis /var/lib/redis
# 	exec gosu redis "$@"
# fi

exec "$@"