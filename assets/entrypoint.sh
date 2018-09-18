#!/bin/sh
set -e

if [ "$1" = 'supervisord' ]; then
  if [ -z ${SE_SERVER+x} ]; then
    echo "Please provide SE_SERVER environment variable"
    exit
  fi
  
  if [ -z ${SE_HUB+x} ]; then
    echo "Please provide SE_HUB environment variable"
    exit
  fi
  
  if [ -z ${SE_USERNAME+x} ]; then
    echo "Please provide SE_USERNAME environment variable"
    exit
  fi
  
  if [ -z ${SE_PASSWORD+x} ]; then
    echo "Please provide SE_PASSWORD environment variable"
    exit
  fi
fi

exec "$@"
