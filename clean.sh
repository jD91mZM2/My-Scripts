#!/usr/bin/env bash

cd ~/Coding

IFS=$'\n'

ask() {
    echo -n "$1 [y/N] "
    read -r clean
}

ask "Clean git repositories?"
if [ "$clean" == "y" ]; then
    find . -name .git -exec git -C "{}" gc \; &> /dev/null
fi

ask "Clean external rust binaries?"
if [ "$clean" == "y" ]; then
    pushd Rust/external
    for f in $(find . -name Cargo.toml); do
        echo "Cleaning $f..."
        cargo clean --manifest-path "$f"
    done
    popd
fi

ask "Clean docs?"
if [ "$clean" == "y" ]; then
    for f in $(find . -regex 'target/doc$'); do
        echo "Removing $f..."
        trash "$f"
    done
fi

ask "Clean debug rust binaries?"
if [ "$clean" == "y" ]; then
    for f in $(find . -regex '.*target/\(target\|debug\|rls\|package\)$'); do
        echo "Removing $f..."
        trash "$f"
    done
fi

ask "Clean those goddamn node_modules?"
if [ "$clean" == "y" ]; then
    for f in $(find . -name node_modules -prune); do
        echo "Beating the crap out of $f..."
        trash "$f"
    done
fi
