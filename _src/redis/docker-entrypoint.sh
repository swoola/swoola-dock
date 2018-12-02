#!/bin/sh
set -e

# parameters
REDIS_PASSWORD=${REDIS_PASSWORD}

if [ -n "$REDIS_PASSWORD" ]; then
    sed -ir "s/requirepass.*/requirepass ${REDIS_PASSWORD}/g" /etc/redis/redis.conf
fi

exec "$@"