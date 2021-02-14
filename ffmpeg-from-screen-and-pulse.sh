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

# trap_ctrlc()
# {
#     echo "Finishing grabbing. Please find result in ${FILE}"
#     exit 2
# }
# trap "trap_ctrlc" 2

pactl load-module module-null-sink sink_name=mix 
pactl load-module module-loopback sink=mix
pactl load-module module-loopback sink=mix

ffmpeg -video_size $RESOLUTION -framerate 10 -f x11grab -i :0.0+0,0 -thread_queue_size 2048 -f alsa -i pulse \
-c:v libx264 -preset superfast $FILE

echo "Cleaning pulse modules..."
pactl unload-module module-loopback
pactl unload-module module-null-sink

echo "Finishing grabbing. Please find result in ${FILE}"

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

