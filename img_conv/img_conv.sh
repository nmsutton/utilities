#!/bin/bash

if [ "$#" -eq 1 ]; 
then
    file="$1"
else
    echo 'Please enter video file'
    read -r file
fi

echo $file;

command="echo $file | sed 's/\(.*\).\(jpg\|jpeg\|JPG\|Jpg\|JPEG\|Jpeg\|png\|Png\|PNG\|gif\|Gif\|GIF\|webp\|Webp\|WEBP\)/\1_2.\2/'";
renamed_file=$(eval $command); 

convert "$file" "$renamed_file"

trash-put "$file"