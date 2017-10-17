#!/bin/sh

while true; do
    printf "Checking...\r"
    curl http://bot.whatismyipaddress.com/
    echo
    sleep 5
done
