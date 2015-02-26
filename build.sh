#!/bin/bash

if [[ "$1" == "" ]]; then
	BRANCH="master";
else
	BRANCH="$1";
fi;

if [ ! -d "Redbook" ]; then
	git clone github.com:cfullelove/Redbook.git
fi

if [ ! -d "Redbook" ]; then
	exit 1
fi

cd Redbook

git checkout -f $BRANCH
git pull origin $BRANCH

TAG=$(git rev-parse --short HEAD)

cd ..

sudo docker build -t redbook-${BRANCH}:${TAG} .
