#!/bin/sh

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "type-loop.sh <duration> <text>" >&2
    exit 1
fi

sleep 5

while true; do
    xdotool type "$2"
    sleep "$1"
    xdotool key Return
    sleep 1
done
