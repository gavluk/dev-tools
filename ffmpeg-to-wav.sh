#!/bin/sh

ffmpeg -loglevel error -i $1 "$1-raw.wav"
