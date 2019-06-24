#!/bin/sh

ffmpeg.exe -i $1 -codec:v libx264 -codec:a libmp3lame -b:a 192k -qscale:v 2 -r ntsc -ar 48000 $1-30fpm-mp3.mp4
