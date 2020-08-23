#!/bin/sh

PREFIX=$1
RESOLUTION=$2

if [ -z $RESOLUTION ]; then
	RESOLUTION="1920x1080"
#	RESOLUTION=`xrandr | grep '*' | head -n 1 | awk '{ print $1; }'`
echo "No resolution as second parameter provided. Using ${RESOLUTION}"
fi

TS=`date +"%Y-%m-%d_%H%M"`
FILE="${PREFIX}_screencast-${TS}.mp4"

trap_ctrlc()
{
    echo "Finishing grabbing. Please find result in ${FILE}"
    exit 2
}
trap "trap_ctrlc" 2

ffmpeg -video_size $RESOLUTION -framerate 10 -f x11grab -i :0.0+0,0 -thread_queue_size 2048 -f jack -i ffmpeg-rec \
-c:v libx264 -preset superfast $FILE
#-c:v zlib -c:a mp3 -b:a 128K $FILE
#-c:v libx264 -preset ultrafast -crf 0 -c:a mp3 -b:a 128K $FILE
#-c:v utvideo -c:a mp3 -b:a 128K $FILE
# Works well:
#-c:v png -c:a mp3 -b:a 128K $FILE
#-c:v ffv1 -c:a mp3 -b:a 128K $FILE
#-c:v huffyuv -c:a mp3 -b:a 128K $FILE
# BEST size-quality
# -c:v libx264 -preset ultrafast -c:a mp3 -b:a 128K $FILE
#-c:v flashsv -c:a mp3 -b:a 128K $FILE

