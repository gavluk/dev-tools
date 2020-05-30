#!/bin/sh

IMAGE=$1
CMD=$2
CMD2=$3

echo "Running docker $IMAGE command '$CMD' into current directory"

docker run --rm -u `id -u`:`id -g` -v `pwd`:/work -w /work $IMAGE $CMD $CMD2


