#!/bin/sh

ffmpeg -loglevel error -i $1 -codec:a libmp3lame -b:a 192k -ar 48000 "$1-smaller.mp3"
