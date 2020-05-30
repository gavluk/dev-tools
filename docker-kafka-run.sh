#!/bin/sh

docker network create kafka-net

docker run -d --name zookeeper \
    --network kafka-net \
    jplock/zookeeper

sleep 2

docker run -d --name kafka \
    -p 9092:9092 -p 7203:7203 \
    --network kafka-net \
    --env KAFKA_ADVERTISED_HOST_NAME=127.0.0.1 \
    --env ZOOKEEPER_IP=zookeeper \
    ches/kafka

sleep 5

# create some topic
docker run --rm --network kafka-net ches/kafka kafka-topics.sh \
--create \
--topic test \
--replication-factor 1 --partitions 1 \
--zookeeper zookeeper

# list of topics
docker run --rm --network kafka-net ches/kafka sh -c unset JMX_PORT
docker run --rm --network kafka-net ches/kafka kafka-topics.sh --list --zookeeper zookeeper

# more info at: https://hub.docker.com/r/ches/kafka/
