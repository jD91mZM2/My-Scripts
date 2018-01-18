#!/bin/sh

if [ -z "$1" ]; then
    echo "Usage: ./reconnect.sh <endpoint>"
    return
fi

sudo systemctl stop openvpn-client@*
sudo systemctl start "openvpn-client@$1"
