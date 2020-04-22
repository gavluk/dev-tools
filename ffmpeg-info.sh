#!/bin/sh

ffprobe -print_format json -show_format -v quiet -show_streams "$1" | python3 $HOME/dev-tools/parse-ffmpeg-info.py
