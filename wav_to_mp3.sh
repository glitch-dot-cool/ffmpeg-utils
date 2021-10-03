#!/bin/bash

# convert current directory from wav (replace for whatever) to mp3
for f in *.wav ; do ffmpeg -i "$f" -acodec libmp3lame -q:a 2 "${f%.*}.mp3"; done
