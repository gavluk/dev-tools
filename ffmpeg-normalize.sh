#!/bin/sh

# See http://peterforgacs.github.io/2018/05/20/Audio-normalization-with-ffmpeg/


# http://k.ylo.ph/2016/04/04/loudnorm.html
ffmpeg -i "$1" -af loudnorm=I=-16:TP=-1.5:LRA=11  -ar 48k -y "$1_normalized.mp4"

#ffmpeg -i "$1" -af loudnorm=I=-23:LRA=7:tp=-2:print_format=json -f null -

#ffmpeg -i "$1" -af loudnorm=I=-23:LRA=7:tp=-2:measured_I=-30:measured_LRA=1.1:measured_tp=-11  -ar 48k -y "$1_normalized.mp4"


