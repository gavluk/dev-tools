#!/bin/bash -e

if [[ -z $LOCAL_IP ]] ; then
    echo "LOCAL_IP env variable must be defined. Check your ifconfig command:" 1>&2
    ifconfig -a | grep -a1 inet
    printf "=========\nUse LOCAL_IP=XX.XX.XX.XX ./kafka-embed-zookeeper.sh\n==========\n" 1>&2
    exit 1
fi

SSL_DIR="/home/ogavliuk/projects/anonymization-library/anonymization-flink-test/src/main/resources/ssl"

docker stop kafka-embedded-zookeeper || true
docker container rm kafka-embedded-zookeeper || true

KEY=$(cat $SSL_DIR/localhost.key | sed -z 's/\n/\\n/g')
CRT=$(cat $SSL_DIR/localhost.crt | sed -z 's/\n/\\n/g')
CA=$(cat $SSL_DIR/rootCA.crt | sed -z 's/\n/\\n/g')

# 6.2.1 means Kafka 2.8.0, ZK: 3.5.9, see: https://www.buesing.dev/post/confluent-community-versions/
docker run -d --name kafka-embedded-zookeeper \
    -v $SSL_DIR:/opt/ssl \
    -p 9092:9092 \
    -p 9093:9093 \
    -p 9094:9094 \
    -p 9095:9095 \
    -p 2181:2181 \
    -e KAFKA_BROKER_ID=1 \
    -e KAFKA_ZOOKEEPER_CONNECT="localhost:2181" \
    -e KAFKA_LISTENERS="INTERNAL://:2092,NOT_SECURED://:9092,SSL_SECURED://:9093" \
    -e KAFKA_LISTENER_SECURITY_PROTOCOL_MAP="INTERNAL:PLAINTEXT,NOT_SECURED:PLAINTEXT,SSL_SECURED:SSL" \
    -e KAFKA_INTER_BROKER_LISTENER_NAME="INTERNAL" \
    -e KAFKA_ADVERTISED_LISTENERS="INTERNAL://localhost:2092,NOT_SECURED://localhost:9092,SSL_SECURED://localhost:9093" \
    -e KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1 \
    -e KAFKA_SSL_KEYSTORE_TYPE=PEM \
    -e KAFKA_SSL_KEYSTORE_KEY="$KEY" \
    -e KAFKA_SSL_KEYSTORE_CERTIFICATE_CHAIN="$CRT" \
    -e KAFKA_SSL_TRUSTSTORE_TYPE=PEM \
    -e KAFKA_SSL_TRUSTSTORE_CERTIFICATES="$CA" \
    confluentinc/cp-kafka:6.2.1

    # WORKING!!!
    # -e KAFKA_SSL_KEYSTORE_PASSWORD=testpass \
    # -e KAFKA_SSL_KEYSTORE_LOCATION=/opt/ssl/localhost.jks \
    # -e KAFKA_SSL_TRUSTSTORE_LOCATION=/opt/ssl/localhost.truststore.jks \
    # -e KAFKA_SSL_TRUSTSTORE_PASSWORD=testpass \
    # -e KAFKA_SSL_KEY_PASSWORD=testpass \

    # PEM NOT WORKING?!!???
    # -e KAFKA_SSL_KEYSTORE_TYPE=PEM \
    # -e KAFKA_SSL_KEYSTORE_KEY="$KEY" \
    # -e KAFKA_SSL_KEYSTORE_CERTIFICATE_CHAIN="$CRT" \
    # -e KAFKA_SSL_TRUSTSTORE_TYPE=PEM \
    # -e KAFKA_SSL_TRUSTSTORE_CERTIFICATES="$CA" \


    # -e KAFKA_SSL_KEYSTORE_KEY=/opt/ssl/localhost.key \
    # -e KAFKA_SSL_KEYSTORE_FILENAME=kafka.broker1.keystore.jks \
    # -e KAFKA_GROUP_INITIAL_REBALANCE_DELAY_MS=0 \
    # -e KAFKA_LOG_FLUSH_INTERVAL_MESSAGES=9223372036854775807 \
    # -e KAFKA_TRANSACTION_STATE_LOG_MIN_ISR=1 \

    # -e KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR=1 \
    # -e KAFKA_OFFSETS_TOPIC_NUM_PARTITIONS=1 \
    # -e KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1 \

docker exec -i kafka-embedded-zookeeper bash -c "echo 'clientPort=2181' > zookeeper.properties"
docker exec -i kafka-embedded-zookeeper bash -c "echo 'dataDir=/var/lib/zookeeper/data' >> zookeeper.properties"
docker exec -i kafka-embedded-zookeeper bash -c "echo 'dataLogDir=/var/lib/zookeeper/log' >> zookeeper.properties"
docker exec -i kafka-embedded-zookeeper bash -c "zookeeper-server-start zookeeper.properties &"

tee <<EOF
Container "kafka-embedded-zookeeper" started.
Ports:
- 9092: main Kafka port for working from your host
- 2181: zookeeper port

For next run use: 
 docker start kafka-embedded-zookeeper

Or after changes:
 docker container rm kafka-embedded-zookeeper
 ./kafka-embedded-zookeeper.sh
EOF
