#!/bin/bash

single_file () {
    echo enter the path to the file you would like to upscale
    read FILE_PATH

    echo enter the factor you would like to scale the img
    read SCALE_FACTOR

    echo enter the filename you would like to save the output as.
    read OUTPUT_PATH

    ffmpeg -i $FILE_PATH -vf scale=iw*$SCALE_FACTOR:-1:flags=neighbor $OUTPUT_PATH
}

batch () {
    echo enter the path of the directory you would like to upscale
    read FOLDER_PATH

    echo enter the factor you would like to scale the images
    read SCALE_FACTOR

    echo enter the suffix you would like to append to the upscaled images
    read SUFFIX

    for FILE in $FOLDER_PATH/*; do
        NAME="$(basename "${FILE%.*}")"
        EXT="${FILE##*.}"
        ffmpeg -i "${FOLDER_PATH}/${NAME}.$EXT" -vf scale=iw*$SCALE_FACTOR:-1:flags=neighbor "${FOLDER_PATH}/${NAME}_${SUFFIX}.$EXT"
    done
}

declare -A OPTIONS=([1]="single file" [2]="batch folder")

ENTRY_OPTIONS=()
OPTIONS_COUNT=${#OPTIONS[@]}
MESSAGE="Would you like to upscale a single image or an entire directory of images?"

for option in "${!OPTIONS[@]}"; do
    ENTRY_OPTIONS+=("$option")
    ENTRY_OPTIONS+=("${OPTIONS[$option]}")
    ENTRY_OPTIONS+=("OFF")
done

SELECTION=$(whiptail --radiolist --title "Mode Select" "$MESSAGE" 20 78 $OPTIONS_COUNT -- "${ENTRY_OPTIONS[@]}" 3>&1 1>&2 2>&3)

if [ $SELECTION -eq 1 ];
then
    single_file
else
    batch
fi


                               