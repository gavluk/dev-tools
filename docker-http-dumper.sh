#!/bin/bash 

PORT=$1

if [ -z $PORT ]; then
    PORT="8444"
fi

echo "Starting HTTP dumper at http://localhost:$PORT"

docker run --rm -p "8444:8080" -it daime/http-dump:latest