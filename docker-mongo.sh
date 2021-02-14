#!/bin/sh

docker run --name mongo -v mongo_data:/data/db -p 27017:27017 -d mongo:latest

