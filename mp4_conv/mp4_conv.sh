#!/bin/bash

if [ "$#" -eq 1 ]; 
then
    file="$1"
else
    echo 'Please enter video file'
    read -r file
fi

echo $file;

/general/software/utilities/rename_blanks/rename_blanks.sh "$file" &&

command="echo $file | sed 's/\(.*\).\(mp4\|avi\|mpg\|mpeg\|mov\|webm\|flv\|wmv\|f4v\|m4v\|mkv\)/\1/'";
file_no_ext=$(eval $command); 
new_ext="_2.mp4";
new_file=$file_no_ext$new_ext;

ffmpeg -i "$file" -preset slow -crf 15 -vcodec libx264 -acodec aac "$new_file"

trash-put "$file"
