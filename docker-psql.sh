#!/bin/sh +x

docker run --name postgres -v pgdata:/var/lib/postgresql/data -e POSTGRES_PASSWORD=12345 -d -p 5432:5432 postgres

