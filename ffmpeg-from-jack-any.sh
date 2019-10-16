#!/bin/sh

ffmpeg -f jack -i ffmpeg-$1 -y $1.wav
