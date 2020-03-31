#!/bin/sh

VIDEO_RES=`ffprobe "$1" 2>&1 | grep "Video:" | awk '{print $11}'`
AUDIO_FREQ=`ffprobe "$1" 2>&1 | grep "Audio:" | awk '{print $9}'`
SIZE=`du -m "$1" | awk '{print $1}'`

echo "$SIZE\t$VIDEO_RES\t$AUDIO_FREQ\t'$1'"
