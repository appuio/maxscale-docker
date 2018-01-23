#!/bin/sh
set -e

if [ "$1" = 'maxscale' ]; then
  if ! whoami &> /dev/null; then
    if [ -w /etc/passwd ]; then
      echo "${USER_NAME:-maxscale}:x:$(id -u):0:${USER_NAME:-maxscale} user:${HOME}:/sbin/nologin" >> /etc/passwd
    fi
  fi

  echo "===> Starting Application"
fi

# Run CMD
exec "$@"
