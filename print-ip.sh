#!/bin/sh

while true; do
    echo -n "Checking...\r"
    curl http://bot.whatismyipaddress.com/
    echo
    sleep 5
done
