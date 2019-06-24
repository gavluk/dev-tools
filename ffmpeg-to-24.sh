#!/bin/sh

ffmpeg.exe -i "$1" -vsync cfr -c:v libx264 -pix_fmt yuv420p -profile:v high -preset veryfast -tune fastdecode -crf 20 -x264opts keyint=60 -c:a aac -b:a 256k  -y   "$2"


# https://forum.videohelp.com/threads/356314-How-to-batch-convert-multiplex-any-files-with-ffmpeg
# -vf scale=-1:720
