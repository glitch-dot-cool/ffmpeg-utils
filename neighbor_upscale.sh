#!/bin/bash

echo enter the path to the file you would like to upscale
read FILE_PATH

echo enter the factor you would like to scale the img
read SCALE_FACTOR

echo enter the filename you would like to save the output as.
read OUTPUT_PATH

ffmpeg -i $FILE_PATH -vf scale=iw*$SCALE_FACTOR:-1:flags=neighbor $OUTPUT_PATH
                               