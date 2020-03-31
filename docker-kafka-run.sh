#!/bin/sh

docker network create kafka-net
docker run -d --name zookeeper --network kafka-net jplock/zookeeper
docker run -d --name kafka --network kafka-net --env ZOOKEEPER_IP=zookeeper ches/kafka

# create some topic
docker run --rm --network kafka-net ches/kafka kafka-topics.sh \
--create \
--topic test \
--replication-factor 1 --partitions 1 \
--zookeeper zookeeper

# list of topics
docker run --rm --network kafka-net ches/kafka kafka-topics.sh --list --zookeeper zookeeper

# more info at: https://hub.docker.com/r/ches/kafka/
