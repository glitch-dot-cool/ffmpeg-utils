#!/bin/bash

# convert current directory from wav (replace for whatever) to mp3
for f in *.wav ; do ffmpeg -i "$f" -acodec libmp3lame -b:a 320k "${f%.*}.mp3"; done
