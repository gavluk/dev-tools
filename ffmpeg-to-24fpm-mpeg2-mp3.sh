#!/bin/sh

ffmpeg -i $1 -codec:v mpeg2video -codec:a libmp3lame -b:a 192k -qscale:v 2  -vf "fps=24/1.001" -ar 48000 $1-24fpm-mp3.mpg
