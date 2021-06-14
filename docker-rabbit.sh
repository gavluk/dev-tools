#!/bin/sh +x

docker run \
    -d \
    --name rabbit \
    -v rabbit-data:/var/lib/rabbitmq \
    -h rabbit-local \
    -p 5672:5672 \
    -p 15672:15672 \
    -e RABBITMQ_DEFAULT_USER=guest -e RABBITMQ_DEFAULT_PASS=guest \
    rabbitmq:3-management

cat <<END
# Using client:

$ docker exec -it rabbit bash
root@f2a2d3d27c75:/# rabbitmqctl list_users
Listing users ...
guest   [administrator]
END
