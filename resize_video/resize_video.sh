#!/bin/bash

w=3600 #2880
h=1800 #1440
time_limit="" #"-t 00:00:10";

video_name_ext=".*";
input_vid=$1
resize="_resized.";
slash="/";
command="echo $input_vid | sed 's/^\/.*[.]\($video_name_ext\)$/\1/'";
extension=$(eval $command);
echo $command;
echo $extension;
command="echo $input_vid | sed 's/^\/\(.*\)[.]$video_name_ext$/\1/'";
file_no_ext=$(eval $command);
echo $command;
output_vid=$slash$file_no_ext$resize$extension;

ffmpeg -i $input_vid -vf scale=$w:$h $time_limit $output_vid;
