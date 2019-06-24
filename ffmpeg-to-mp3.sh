#!/bin/sh

ffmpeg.exe -loglevel error -i $1 -codec:a libmp3lame -b:a 192k "$1-smaller.mp3"
