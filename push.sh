#!/bin/sh

if [ -z $1 ]; then
	echo "no commit name"
	exit
fi

echo "commit with name: $1"

git add *
git commit -m "$1"
git push origin main
