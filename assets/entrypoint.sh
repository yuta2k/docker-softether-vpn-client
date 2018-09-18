#!/bin/sh
set -e

if [ "x$1" = 'x/usr/bin/vpnclient' ]; then
    chown -R softether:softether /usr/vpnclient
    setcap 'cap_net_bind_service=+ep' /usr/bin/vpnclient

    echo "Starting SoftEther VPN Client"
    exec su-exec softether sh -c "`echo $@`"
else
    exec "$@"
fi
