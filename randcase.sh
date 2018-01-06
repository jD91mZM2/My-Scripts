#!/bin/sh

read line

for i in $(seq 1 ${#line}); do
    char="${line:i-1:1}"

    if [[ $((RANDOM % 2)) == 0 ]]; then
        echo -n "${char^^}"
    else
        echo -n "${char,,}"
    fi
done
echo
