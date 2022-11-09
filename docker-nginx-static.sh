#!/bin/sh +x

docker run -v $1:/usr/share/nginx/html:ro -d -p 80:80 nginx

