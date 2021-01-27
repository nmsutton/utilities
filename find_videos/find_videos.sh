#!/bin/bash

base_dir="";
icon_file="";
find_results="";
starting_folder="";
video_ext="\.mp4|\.wmv|\.mov|\.avi|\.flv|\.mpg|\.mpeg|\.f4v|\.webm";
video_ext2="mp4\|wmv\|mov\|avi\|flv\|mpg\|mpeg\|f4v\|webm";
input_folder_name=$1;
output_folder=$2;
starting_folder=$3;
mkdir $output_folder;

addcustomicon(){
  command="xargs -L1 echo";
  args=$(eval $command);
  command="echo $args | cut -d' ' -f1";
  orig_file=$(eval $command);
  command="echo $args | cut -d' ' -f2";
  link_file=$(eval $command);
  #echo "$orig_file|$link_file";

  command="echo $orig_file | sed 's/^\(.*\/\)\(.*\)$/\1/'";
  orig_base_dir=$(eval $command);
  command="echo $orig_file | sed 's/^\(.*\/\)\(.*\)\..*$/\2/'";
  orig_file_name=$(eval $command);
  icon_dir="/icon/videos/";
  icon_ext="_thumb.jpg";
  #eval $command;
  orig_icon_file=$orig_base_dir$icon_dir$orig_file_name$icon_ext;

  command="gio set \"$link_file\" metadata::custom-icon \"file://$orig_icon_file\"";
  #echo $command;

  # check if file exists
  if [ -f $orig_icon_file ]; then 
      eval $command;
  fi
}

addlinks(){
  command="xargs -L1 echo";
  video_file=$(eval $command);

  command="echo $video_file | sed 's/^.*\/$input_folder_name\/\(.*\)$/\1/'";
  video_name=$(eval $command);
  #echo $video_name;
  #echo $video_file;
  command="ln -s $video_file $output_folder$video_name";
  #echo $command;

  eval $command;
  echo \"$video_file $output_folder$video_name\" | addcustomicon
}

# images in videos folder
command="find -L $starting_folder/*/$input_folder_name/* -regextype posix-awk -iregex '.+($video_ext)'";
find_results=$(eval $command);
for line in $find_results
do
  echo \"$line\" | addlinks
done

echo "test1";