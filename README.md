# docker-redis
Dockerfile for Redis

## Note:

Builtin entrypoint will do the following:
 - Using /usr/share/redis/redis.conf.template and environments to generate /etc/redis/redis.conf
 - Using /usr/share/redis/sentinel.conf.template an environments to generate /etc/redis/sentinel.cond

If you want to customize more, modify the templates.

## Usage:

### Redis Master
```bash
$ docker run -d --name rdsmaster extvos/redis:latest 
```

### Redis Slave
```bash
$ docker run -d --name rdsslave \
         --env REDIS_MASTER_HOST=rdsmaster \
         --env REDIS_MASTER_PORT=6379
         extvos/redis:latest
```

### Redis Sentinel
```bash
$ docker run -d --name rdspool \
         --env SENTINEL_PORT=26379 \
         --env SENTINEL_MONITORS=rd1:rdsmaster1:6379,rd2:rdsmaster2:6379 \
         extvos/redis:latest redis-sentinel /etc/redis/sentinel.conf
```

## Environment Ref:
```
ENV REDIS_BIND ''
ENV REDIS_PORT 6379
ENV REDIS_PROTECTED_MODE yes
ENV REDIS_DATABASE 16
ENV REDIS_LOGLEVEL notice

ENV REDIS_MASTER_HOST ''
ENV REDIS_MASTER_PORT 6379
ENV REDIS_MASTER_AUTH ''
ENV REDIS_SLAVE_PRIORITY 100

ENV SENTINEL_BIND ''
ENV SENTINEL_PORT 26379
ENV SENTINEL_MONITORS ''
ENV SENTINEL_QUORUM 2
ENV SENTINEL_DOWN_AFTER 5000
ENV SENTINEL_FAILOVER 10000
ENV SENTINEL_PARALLEL_SYNCS 1

```