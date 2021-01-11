#!/bin/bash

base_dir="";
icon_file="";
find_results="";
starting_folder="";
slash="/";
pic_ext="\.jpg|\.gif|\.png|\.jpeg|\.webp";

sudo echo 'starting icons auto gen' #sudo because find uses sudo
if [ "$#" -eq 1 ]; 
then
    starting_folder=$1
    #echo $starting_folder
else
    echo 'Please enter folder'
    read -r starting_folder
fi

#command="printf \'%s\n\' \"${starting_folder:(-1)}\"";
#last_char=$(eval $command);
#if [ $last_char=="/" ];
#then
#else
#    starting_folder=$starting_folder$slash;
#fi
#starting_folder=$starting_folder$slash;

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

path_icon="\/.+icon\/.+($pic_ext)";
path_icon2=$starting_folder$path_icon;
command="find $starting_folder -regextype posix-awk -iregex '$path_icon2'"
find_results=$(eval $command);
for line in $find_results
do
  echo \"$line\" | addcustomicon
done