#!/bin/bash
set -e

sysctl vm.overcommit_memory=1
echo never > /sys/kernel/mm/transparent_hugepage/enabled

if [ "$1" = 'redis-server' ]; then
	chown -R redis .
	exec gosu redis "$@"
fi

exec "$@"