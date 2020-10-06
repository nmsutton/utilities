#!/bin/bash

sudo echo 'Starting mp4 video screenshot and thumbnails generator' #sudo because find uses sudo
if [ "$#" -eq 1 ]; 
then
    starting_folder=$1
else
    echo 'Please enter folder'
    read -r starting_folder
fi

# resume where previously left off? "n" will
# not overwrite prior files created
resume_prior_ops="n"; # "y" for yes and "n" for no

find_results="";
command="find $starting_folder -regextype posix-awk -iregex '.+(\.mp4)'";
find_results=$(eval $command);
for video_file_orig in $find_results
do
  fullpath=`realpath $video_file_orig`;
  pathonly=`dirname $fullpath`;
  add_star="/*";
  command="echo $video_file_orig | sed 's/^\/\(.*\)[.]mp4$/\/\1/'";
  video_file=$(eval $command);
  command="echo $video_file_orig | sed 's/^.*\/\(.*\)[.]mp4$/\/\1/'";
  video_name_no_ext=$(eval $command);
  icon_folder="$pathonly/icon";
  thumbpath="$pathonly/icon/videos";
  thumb_ext="_thumb.jpg";
  thumb_path_name="$thumbpath$video_name_no_ext$thumb_ext";
  eval "mkdir $icon_folder";
  eval "mkdir $thumbpath";
  # 60 sec
  resize_cmd="convert $thumb_path_name -resize 1080 $thumb_path_name";
  crop_cmd="mogrify -crop 650x1080+250+0 $thumb_path_name";
  command="ffmpeg -$resume_prior_ops -itsoffset -60 -i $video_file_orig -vcodec mjpeg -vframes 1 -an -f rawvideo $thumb_path_name && $resize_cmd && $crop_cmd";
  echo $command;
  eval $command;
  /usr/bin/gio set "$video_file_orig" metadata::custom-icon "file://$thumb_path_name";
  echo "changing permissions";
  command="sudo chmod -R 777 $thumbpath$add_star";
  eval $command;
  echo $command;
done
