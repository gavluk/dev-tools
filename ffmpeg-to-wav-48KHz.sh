#!/bin/sh

ffmpeg -loglevel error -i "$1" \
    -af aresample=resampler=soxr:osr=48000:cutoff=0.990:dither_method=none \
    -f wav "$1-48KHz.wav"
#-ar 44100 "$1-smaller.mp3"
