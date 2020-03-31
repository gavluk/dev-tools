#!/bin/sh

ffmpeg -framerate 25 -f v4l2 -i /dev/video2 -thread_queue_size 2048 -f jack -i ffmpeg-rec -c:v libx264 -preset superfast -y $1

