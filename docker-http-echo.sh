#!/bin/sh +x

docker run --name http_echo -d -p 8000:8080 jmalloc/echo-server