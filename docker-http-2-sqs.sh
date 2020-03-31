#!/bin/sh +x

docker run --name http_2_sqs -d -p 8001:8080 \
    -e SQS_QUEUE_URL=https://sqs.eu-west-1.amazonaws.com/398927077492/test1 \
    -e AWS_REGION=eu-west-1 \
    cxmcc/http2sqs