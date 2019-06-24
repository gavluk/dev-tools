#!/bin/sh

ffmpeg.exe -loglevel error -i $1 "$1-raw.wav"
