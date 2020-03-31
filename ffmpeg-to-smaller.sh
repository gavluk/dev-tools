#!/bin/sh

TARGET=$1-smaller.mp4
echo "Starting $TARGET"

# ls -al "$1"

ffmpeg -loglevel error -i "$1" -codec:v libx264 -vf "scale=ceil(iw*720/ih/2)*2:720" -codec:a libmp3lame -b:a 128k -qscale:v 2 -r ntsc -ar 48000 "$TARGET"

echo "Finished $TARGET"
