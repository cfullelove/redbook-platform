#!/bin/bash

TAG=`date +%Y%m%d%H%M%S`

if [[ "$1" -eq "" ]]; then
	BRANCH="master";
else
	BRANCH="$1";
fi;

echo redbook-${BRANCH}:${TAG}

if [ ! -d "Redbook" ]; then
	git clone github:cfullelove/Redbook.git
fi

if [ ! -d "Redbook" ]; then
	exit 1
fi

cd Redbook

git checkout -f $BRANCH
git pull origin $BRANCH

cd ..

docker build -t redbook-${BRANCH}:${TAG} .
