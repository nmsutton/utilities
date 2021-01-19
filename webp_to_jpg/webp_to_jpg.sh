#!/bin/bash

if [ "$#" -eq 1 ]; 
then
    webp_file=$1
else
    echo 'Please enter webp file'
    read -r webp_file
fi

echo $webp_file;

command="echo $webp_file | sed 's/\(.*\).webp/\1/'";
file_no_ext=$(eval $command); 
jpg_ext=".jpg";
jpg_file=$file_no_ext$jpg_ext;

convert $webp_file $jpg_file
