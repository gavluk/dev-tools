#!/bin/sh +x

docker run --name http_echo2 -d -p 8002:8080 kennship/http-echo
