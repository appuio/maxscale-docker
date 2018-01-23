#!/bin/sh
set -e

DIR=/docker-entrypoint.d

if [ "$1" = '/app/bin/maxscale' ]; then
  if ! whoami &> /dev/null; then
    if [ -w /etc/passwd ]; then
      echo "${USER_NAME:-maxscale}:x:$(id -u):0:${USER_NAME:-maxscale} user:${HOME}:/sbin/nologin" >> /etc/passwd
    fi
  fi

  echo "===> Starting Application"
  exec /app/bin/maxscale
fi

# Run CMD
exec "$@"
