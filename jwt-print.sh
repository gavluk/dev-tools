#!/bin/bash

if [ -n "$1" ]; then
	echo $1 | jq -R 'split(".") | .[1] | @base64d | fromjson'
else
	cat | jq -R 'split(".") | .[1] | @base64d | fromjson'
fi
