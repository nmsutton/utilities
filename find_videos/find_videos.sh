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
image_ext="\.jpg|\.jpeg|\.png|\.gif";
icon_folder_script="/general/software/utilities/auto_icons/only_video_thumbs.sh";
input_folder_name=$1;
output_folder=$2;
starting_folder=$3;
base_folder=$4;
softlink_pics=$5;
underscore="_";
slash="/";
picsfldr="/pics";
iconfldr="/icon";
mkdir $base_folder$slash$input_folder_name;
mkdir $base_folder$slash$input_folder_name$iconfldr;
mkdir $output_folder;
mkdir $output_folder$picsfldr;

#
# create video links
#
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
  video_file="$(eval $command)";
  command="echo $video_file | sed 's/^\(.*\/\)\(.*\)$/\1/'";
  orig_base_dir=$(eval $command);
  command2="$rename_blanks_script $orig_base_dir"; #rename blanks

  command="echo $video_file | sed 's/^.*\/\(.*\)$/\1/'";
  video_name="$(eval $command)";
  if [ "$video_file" != "$output_folder$video_name" ];
  then
    command3="ln -s \"$video_file\" \"$output_folder$video_name\"";
  fi

  command4="$command2 && sleep 3 && $command3"; # sleep is to allow rename blanks to complete before creating link
  eval $command4 && echo \"$video_file $output_folder$video_name\" | addcustomicon
}

process_video_links(){
  command="xargs -L1 echo";
  video_folder_search="$(eval $command)";
  command="find -L $video_folder_search -regextype posix-awk -iregex '.+($video_ext)'"
  find_results="$(eval $command)";
  for result in $find_results
  do
    echo \"$result\" | addlinks
    #echo \"$result\"
    sleep 3 # slow processing down to do other things while software runs
  done
}

#
# make folder links
#
picfolder(){
  command="xargs -L1 echo";
  picsdir=$(eval $command);
  #echo $picsdir;
  command="find -L $picsdir/* -maxdepth 0 -regextype posix-awk -iregex '.+($image_ext)'";
  pics=$(eval $command);
  for pic in $pics
  do
    if [ $softlink_pics = "yes" ];
    then
      command="echo $folder | sed 's/^.*\/\(.*\)$/\1/'";
      pic_search_name=$(eval $command);
      command="ln -s $pic $output_folder$picsfldr$pic_search_name";
      eval $command;
    else
      command="cp $pic $output_folder$picsfldr";
      eval $command;
    fi
    #echo $pic;
  done
}

folderlinks(){
  command="xargs -L1 echo";
  args=$(eval $command);
  command="echo $args | cut -d' ' -f1";
  folder=$(eval $command);
  command="echo $args | cut -d' ' -f2";
  folder_search_name=$(eval $command);
  command="echo $args | cut -d' ' -f3";
  output_folder=$(eval $command);

  if [ "$folder" != "$output_folder$folder_search_name" ] && [ "$folder" != "$base_folder$slash$input_folder_name" ];
  then
    command="ln -s \"$folder\" \"$output_folder$folder_search_name\"";
    eval $command;

    command="$icon_folder_script \"$output_folder$folder_search_name\"";
    eval $command;
  fi
}

foldericonrandom(){
  command="xargs -L1 echo";
  args=$(eval $command);
  command="echo $args | cut -d' ' -f1";
  folder=$(eval $command);
  command="echo $args | cut -d' ' -f2";
  folder_search_name=$(eval $command);
  command="echo $args | cut -d' ' -f3";
  output_folder=$(eval $command);

  command="find -L $folder/* -maxdepth 0 -regextype posix-awk -iregex '.+($image_ext)'";
  icon_results=$(eval $command);
  for icon_image in $icon_results
  do
    if [ "$output_folder$folder_search_name" != "$base_folder$slash$input_folder_name$slash$input_folder_name" ];
    then
      command="ln -s \"$folder\" \"$output_folder$folder_search_name\"";
      eval $command;

      command="gio set \"$output_folder$folder_search_name\" metadata::custom-icon \"file://$icon_image\"";
      eval $command;
    fi
  done
}

process_folder_links(){
  command="xargs -L1 echo";
  pic_folder_search=$(eval $command);
  command="find $pic_folder_search -type d"
  folders=$(eval $command);
  for folder in $folders
  do
    #echo "processing folder: $folder";
    command="echo $folder | sed 's/^.*\/\(.*\)$/\1/'";
    folder_search_name=$(eval $command);
    if [ "$folder_search_name" != "icon" ] && [ "$folder_search_name" != "videos" ] \
    && [ "$folder_search_name" != "combined" ] && [ "$folder_search_name" != "vids" ] \
    && [ "$folder_search_name" != "clips" ] && [ "$folder_search_name" != "thumbnails" ];
    then
      if [ "$folder_search_name" == "" ]; 
      then
        command="echo $folder | sed 's/^.*\/\(.*\)\/$input_folder_name\/$/\1/'";
        folder_search_name=$(eval $command);
        folder_search_name="$folder_search_name$underscore$input_folder_name";

        echo "$folder" | picfolder
        #echo "$folder";
        echo \"$folder $folder_search_name $output_folder\" | folderlinks;
      else
        echo \"$folder $folder_search_name $output_folder\" | foldericonrandom;
      fi
    fi
    
    # set base folder icon
    if [ "$folder_search_name" == "icon" ];
    then
      if [[ $folder != $base_folder$slash$input_folder_name* ]];
      then
        command="find -L $folder/* -maxdepth 0 -regextype posix-awk -iregex '.+($image_ext)'";
        icon_results=$(eval $command);
        for icon_image in $icon_results
        do
          command="gio set \"$output_folder\" metadata::custom-icon \"file://$icon_image\"";
          eval $command;
          #echo $icon_image;
        done
      fi
    fi
  done
}

test_mode="true";
ln -s "/dummy/link" $base_folder$slash$input_folder_name$slash$input_folder_name;
#if [ $test_mode = "false" ];
#then
command="$starting_folder*/$input_folder_name/" && \
echo \"$command\" | process_folder_links && \
command="$starting_folder*/*/$input_folder_name/" && \
echo \"$command\" | process_folder_links && \
command="$starting_folder*/*/*/$input_folder_name/" && \
echo \"$command\" | process_folder_links #&& \
command="$starting_folder*/*/*/*/$input_folder_name/" && \
echo \"$command\" | process_folder_links && \
command="$starting_folder*/*/*/*/*/$input_folder_name/" && \
echo \"$command\" | process_folder_links

command="$starting_folder*/$input_folder_name/*" && \
echo \"$command\" | process_video_links && \
command="$starting_folder*/*/$input_folder_name/*" && \
echo \"$command\" | process_video_links && \
command="$starting_folder*/*/*/$input_folder_name/*" && \
echo \"$command\" | process_video_links && \
command="$starting_folder*/*/*/*/$input_folder_name/*" && \
echo \"$command\" | process_video_links && \
command="$starting_folder*/*/*/*/*/$input_folder_name/*" && \
echo \"$command\" | process_video_links
#fi

trash-put $base_folder$slash$input_folder_name$slash$input_folder_name;
#echo $base_folder$slash$input_folder_name$slash$input_folder_name;