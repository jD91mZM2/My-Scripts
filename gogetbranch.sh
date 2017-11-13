#!/bin/bash

set -e

if [ -z "$1" ]; then
	echo "No URL specified"
	exit 1
fi

if [ -z "$2" ]; then
	echo "No branch specified"
	exit 1
fi

gopath=$GOPATH

if [ -z "$gopath" ]; then
	gopath=~/go
fi


# mkdir "$gopath" "$gopath/src"
# cd "$gopath/src"
# git clone "https://$1"
go get "$1"
cd "$gopath/src/$1"
git checkout "$2" &> /dev/null

go get
go install
