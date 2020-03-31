#!/bin/sh

echo "Converting $1 ..."
dcraw -w -c "$1" | convert - "$1-converted.jpg"
echo "-----"
