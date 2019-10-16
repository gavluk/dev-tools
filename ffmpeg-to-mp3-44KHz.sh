#!/bin/sh

ffmpeg -loglevel error -i $1 -codec:a libmp3lame -b:a 192k -ar 44100 "$1-smaller.mp3"
