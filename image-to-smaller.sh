#!/bin/sh

identify "$1"
convert "$1" -resize 1900\> "$1" 
identify "$1"
echo "-----"
