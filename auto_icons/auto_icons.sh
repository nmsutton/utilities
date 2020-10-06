#!/bin/bash

base_dir="";
icon_file="";
find_results="";
starting_folder="";

sudo echo 'starting icons auto gen' #sudo because find uses sudo
if [ "$#" -eq 1 ]; 
then
    starting_folder=$1
else
    echo 'Please enter folder'
    read -r starting_folder
fi

addicon(){
  command="xargs -L1 echo";
  icon_file=$(eval $command);
  command="echo $icon_file | sed 's/^\(.*\)\/.*$/\1/'";
  base_dir=$(eval $command);
  if [ "$icon_file" != "" ]; then 
    if [ "$base_dir" != "" ]; then 
      command="gio set \"$base_dir\" metadata::custom-icon \"file://$icon_file\"";
      eval $command;
    fi
  fi
}

addcustomicon(){
  command="xargs -L1 echo";
  icon_file=$(eval $command);
  command="echo $icon_file | sed 's/^\(.*\)\/icon\/.*$/\1/'";
  base_dir=$(eval $command);
  if [ "$icon_file" != "" ]; then 
    if [ "$base_dir" != "" ]; then 
      command="gio set \"$base_dir\" metadata::custom-icon \"file://$icon_file\"";
      eval $command;
    fi
  fi
}

addvideothumbs(){
  test_ext="_thumb.jpg";
  test_dir="/icon/videos";
  command="xargs -L1 echo";
  icon_file=$(eval $command);
  command="echo $icon_file | sed 's/^\(.*\)\/icon\/videos\/.*$/\1/'";
  base_dir=$(eval $command);
  command="echo $icon_file | sed 's/^.*\/icon\/videos\/\(.*\)_thumb[.].*$/\1/'";
  icon_name_no_ext=$(eval $command);
  command2="find $starting_folder/* -regextype posix-awk -iregex '.*[.]mp4'";
  find_results2=$(eval $command2);
  for video_file in $find_results2
  do
    if [ "$icon_file" != "" ]; then 
      if [ "$base_dir" != "" ]; then 
          command="echo $video_file | sed 's/^\(.*\)\/.*$/\1/'";
          new_vid_dir=$(eval $command);
          command="echo $video_file | sed 's/^.*\/\(.*\)[.]mp4$/\/\1/'";
          new_vid_no_ext=$(eval $command);
          video_icon="$new_vid_dir$test_dir$new_vid_no_ext$test_ext"
          test_icon="$base_dir/icon/videos/$icon_name_no_ext$test_ext"
        if [ "$video_icon" = "$test_icon" ]; then 
          command="gio set \"$video_file\" metadata::custom-icon \"file://$icon_file\"";
          eval $command;
          #echo "FOUND";
        fi
      fi
    fi
  done
}

# general images
command="find $starting_folder -regextype posix-awk -iregex '.+(\.jpg|\.jpeg|\.png)'";
find_results=$(eval $command);
for line in $find_results
do
  echo \"$line\" | addicon
done

# images in icon folder
command="find $starting_folder/icon/* -regextype posix-awk -iregex '[a-zA-Z0-9._/]+/icon/[a-zA-Z0-9_]+[.]+[a-zA-Z0-9_]+'
";
find_results=$(eval $command);
for line in $find_results
do
  echo \"$line\" | addcustomicon
done

# images in videos folder
command="find $starting_folder/icon/videos/* -regextype posix-awk -iregex '.*[.]jpg'";
find_results=$(eval $command);
for line in $find_results
do
  echo \"$line\" | addvideothumbs
done