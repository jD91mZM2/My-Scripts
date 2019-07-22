#!/bin/sh

: "${1:?No argument supplied, enter name of project}"

cd ~/nixpkgs
git fetch origin
if ! git checkout -b "$1" origin/master; then
    git checkout "$1"
    git rebase origin/master
fi

path="$(nix eval --raw '(builtins.elemAt (builtins.split ":" (import ./. {}).'"$1"'.meta.position) 0)')"
# Replace all hashes with 0s
sed -i "s/\b\(\([a-f0-9]\{40\}\|[a-f0-9]\{64\}\|[a-f0-9]\{128\}\)\|\([0-9a-df-np-sv-z=]\{32\}\|[0-9a-df-np-sv-z=]\{52\}\|[0-9a-df-np-sv-z=]\{103\}\)\|\([a-zA-Z0-9+\/=]\{28\}\|[a-zA-Z0-9+\/=]\{44\}\|[a-zA-Z0-9+\/=]\{88\}\)\)\b/0000000000000000000000000000000000000000000000000000000000000000/g" "$path"
nix edit -f . "$1"
