#!/usr/bin/env bash

set -e
echo -n "Repo URL or SSH: "
read repo

if [[ "$repo" == "https://github.com/"* ]]; then
	name=`echo -n "$repo" | rev | cut -d / -f 1 | rev`
elif [[ "$repo" == "git@github.com:"* ]]; then
	name=`echo -n "$repo" | cut -d / -f 2 | sed 's/.git$//'`
else
	echo "Invalid link"
	exit 1
fi

cd /tmp

git clone "$repo" &> /dev/null
cd "$name"

git log | grep "^Author: .* <.*@.*>\$" | sort -u

cd ..
rm -rf "$name"
