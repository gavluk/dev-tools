#!/bin/sh

ps auxw | grep [g]photo2 | awk {'print $2'} | xargs kill -9

sudo modprobe v4l2loopback devices=2 exclusive_caps=1
gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -vf "fps=24/1.001" -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video3

