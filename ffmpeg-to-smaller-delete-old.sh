#!/bin/sh

# exit on first failure
set -e

SOURCE=$1
TARGET=$1-smaller.mp4
SOURCE_SIZE=`du -m "${SOURCE}"`

echo "Starting:\t${SOURCE_SIZE}"


# ls -al "$1"

ffmpeg -loglevel error -i "${SOURCE}" -codec:v libx264 -vf "scale=ceil(iw*720/ih/2)*2:720" -codec:a libmp3lame -b:a 128k -r ntsc -ar 48000 "${TARGET}"

sync

TARGET_SIZE=`du -m "${TARGET}"`
echo "Finished:\t${TARGET_SIZE}"

rm "${SOURCE}"

echo "Deleted: ${SOURCE}"

