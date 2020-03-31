#!/bin/sh

docker run -d --name minio -p 9000:9000 \
-e MINIO_ACCESS_KEY=minioadmin \
-e MINIO_SECRET_KEY=minioadmin \
minio/minio server /data
