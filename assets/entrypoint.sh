#!/bin/sh
set -e

if [ "x$1" = 'x/usr/local/bin/vpnclient' ]; then
    chown -R softether:softether /usr/local/libexec/softether/vpnclient
    setcap 'cap_net_bind_service=+ep' /usr/local/bin/vpnclient

    echo "Starting SoftEther VPN Client"
    exec su-exec softether sh -c "`echo $@`"
else
    exec "$@"
fi
