#!/bin/sh

ffmpeg -i $1 -codec:v libx264 -codec:a libmp3lame -b:a 192k -crf 18 -r ntsc -ar 48000 $1-30fpm-mp3.mp4
