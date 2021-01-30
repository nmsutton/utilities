#!/bin/bash

#
# This software finds videos and creates links to them in one central location.
# It also assigns custom icons to the videos and attempts to create those if
# it is detected that they do not already exist.
#

base_dir="";
icon_file="";
find_results="";
starting_folder="";
rename_blanks_script="/general/software/utilities/rename_blanks/rename_blanks.sh";
video_icons_script="/general/software/general/links/run_vid_folder_tmbs_30sec.sh";
video_ext="\.mp4|\.wmv|\.mov|\.avi|\.flv|\.mpg|\.mpeg|\.f4v|\.webm";
video_ext2="mp4\|wmv\|mov\|avi\|flv\|mpg\|mpeg\|f4v\|webm";
input_folder_name=$1;
output_folder=$2;
starting_folder=$3;
clips_folder=$4;
mkdir $output_folder;

addcustomicon(){
  command="xargs -L1 echo";
  args=$(eval $command);
  command="echo $args | cut -d' ' -f1";
  orig_file=$(eval $command);
  command="echo $args | cut -d' ' -f2";
  link_file=$(eval $command);

  command="echo $orig_file | sed 's/^\(.*\/\)\(.*\)$/\1/'";
  orig_base_dir=$(eval $command);
  command="echo $orig_file | sed 's/^\(.*\/\)\(.*\)\..*$/\2/'";
  orig_file_name=$(eval $command);
  icon_dir="/icon/videos/";
  icon_ext="_thumb.jpg";

  orig_icon_file=$orig_base_dir$icon_dir$orig_file_name$icon_ext;

  command="gio set \"$link_file\" metadata::custom-icon \"file://$orig_icon_file\"";
  command2="$video_icons_script \"$orig_base_dir\"";

  # check if file exists
  if [ -f $orig_icon_file ]; 
  then 
      eval $command;
  else
  	  eval $command2 && eval $command;
  fi
}

addlinks(){
  command="xargs -L1 echo";
  video_file=$(eval $command);
  command="echo $video_file | sed 's/^\(.*\/\)\(.*\)$/\1/'";
  orig_base_dir=$(eval $command);
  #rename blanks
  command2="$rename_blanks_script $orig_base_dir";

  command="echo $video_file | sed 's/^.*\/\(.*\)$/\1/'";
  video_name=$(eval $command);
  command3="ln -s \"$video_file\" \"$output_folder$video_name\"";

  command4="$command2 && sleep 3 && $command3"; # sleep is to allow rename blanks to complete before creating link
  eval $command4 && echo \"$video_file $output_folder$video_name\" | addcustomicon
}

command="find -L $starting_folder*/$input_folder_name/* -regextype posix-awk -iregex '.+($video_ext)'";
find_results=$(eval $command);
for line in $find_results
do
  echo \"$line\" | addlinks
  sleep 3 # slow processing down to do other things while software runs
done