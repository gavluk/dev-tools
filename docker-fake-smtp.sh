#!/bin/sh +x

docker run -p 5025:5025 -p 5080:5080 -p 5081:5081 --name fake-smtp -d gessnerfl/fake-smtp-server

