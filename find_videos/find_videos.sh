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
vidsfldr="/videos";
#self_link=$base_folder$slash$input_folder_name$slash$input_folder_name;
mkdir $base_folder$slash$input_folder_name;
mkdir $base_folder$slash$input_folder_name$iconfldr;
mkdir $output_folder;
mkdir $output_folder$picsfldr;
mkdir $output_folder$iconfldr;
mkdir $output_folder$iconfldr$vidsfldr;

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

  # copy icon
  command="cp $orig_icon_file $output_folder$iconfldr$slash$vidsfldr$slash$orig_file_name$icon_ext";
  eval $command;
}

addlinks(){
  command="xargs -L1 echo";
  video_file="$(eval $command)";
  command="echo $video_file | sed 's/^\(.*\/\)\(.*\)$/\1/'";
  orig_base_dir=$(eval $command);
  command2="$rename_blanks_script $orig_base_dir"; #rename blanks

  command="echo $video_file | sed 's/^.*\/\(.*\)$/\1/'";
  video_name="$(eval $command)";
  if [[ "$output_folder$video_name" != "*$video_name$slash$video_name*" ]];
  then
    if [ -e "$output_folder$video_name" ]; 
    then
      # avoid duplicate link generation
      skip_this_section = "y";
    else
      command3="ln -s \"$video_file\" \"$output_folder$video_name\"";
    fi
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
    sleep 3 # slow processing down to do other things while software runs
  done
}

#
# make folder links
#
picfolder(){
  command="xargs -L1 echo";
  picsdir=$(eval $command);
  command="find -L $picsdir/* -maxdepth 0 -regextype posix-awk -iregex '.+($image_ext)'";
  pics=$(eval $command);
  for pic in $pics
  do
    if [ $softlink_pics = "y" ];
    then
      command="echo $folder | sed 's/^.*\/\(.*\)$/\1/'";
      pic_search_name=$(eval $command);
      command="ln -s $pic $output_folder$picsfldr$pic_search_name";
      eval $command;
    else
      command="cp $pic $output_folder$picsfldr";
      eval $command;
    fi
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

  if [[ "$output_folder$folder_search_name" != "*$folder_search_name$slash$folder_search_name*" ]];
  then
    if [ -e "$output_folder$folder_search_name" ]; 
    then
      # avoid duplicate link generation
      skip_this_section = "y";
    else
      command="ln -s \"$folder\" \"$output_folder$folder_search_name\"";
      eval $command;

      command="$icon_folder_script \"$output_folder$folder_search_name\"";
      eval $command;
    fi
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
    if [[ "$output_folder$folder_search_name" != "*$folder_search_name$slash$folder_search_name*" ]];
    then
      if [ -e "$output_folder$folder_search_name" ]; 
        then
          # avoid duplicate link generation
          skip_this_section = "y";
        else
          command="ln -s \"$folder\" \"$output_folder$folder_search_name\"";
          eval $command;

          command="gio set \"$output_folder$folder_search_name\" metadata::custom-icon \"file://$icon_image\"";
          eval $command;
        fi
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
        done
      fi
    fi
  done
}

#trash-put $self_link;
#ln -s "/dummy/link" $self_link; # link to avoid self-link issues with icon targets
command="$starting_folder/$input_folder_name/" && \
echo \"$command\" | process_folder_links && \
command="$starting_folder*/$input_folder_name/" && \
echo \"$command\" | process_folder_links && \
command="$starting_folder*/*/$input_folder_name/" && \
echo \"$command\" | process_folder_links && \
command="$starting_folder*/*/*/$input_folder_name/" && \
echo \"$command\" | process_folder_links && \
command="$starting_folder*/*/*/*/$input_folder_name/" && \
echo \"$command\" | process_folder_links && \
command="$starting_folder*/*/*/*/*/$input_folder_name/" && \
echo \"$command\" | process_folder_links

command="$starting_folder/$input_folder_name/*" && \
echo \"$command\" | process_video_links && \
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

#trash-put $self_link;