#!/bin/sh +x

docker run --name mysql -v mysql_data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=12345 -d -p 3306:3306 mysql:5.7

