#!/bin/bash

JOB_ID=$(curl -s http://localhost:8081/jobs | jq -r '.jobs[0].id')

echo "Job ID is ${JOB_ID}"

curl -s http://localhost:8081/jobs/${JOB_ID}/accumulators | jq

