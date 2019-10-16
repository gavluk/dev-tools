#!/bin/sh

# stop it if exists
docker stop redocly
docker rm redocly

# run it
docker run -p $1:80 --name redocly -e SPEC_URL=$2 -d redocly/redoc

# open it
xdg-open http://localhost:$1/


