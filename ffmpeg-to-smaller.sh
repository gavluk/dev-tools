#!/bin/sh



ffmpeg -loglevel error -i "$1" -codec:v libx264 -vf scale=-1:720 -codec:a libmp3lame -b:a 128k -qscale:v 2 -r ntsc -ar 48000 "$1-smaller.mp4"
