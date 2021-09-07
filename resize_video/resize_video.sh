#!/bin/bash

w=3840 #3600 #2880
h=1920 #1800 #1440
time_limit="";
#lime_limit="-t 00:00:30";

video_name_ext=".*";
input_vid=$1
resize="_resized_1080.";
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
