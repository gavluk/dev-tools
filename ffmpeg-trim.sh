#!/bin/sh

ffmpeg -ss 00:00:00.0 -i $1 -c copy -t $2 "${1}_trimmed.mp4"

