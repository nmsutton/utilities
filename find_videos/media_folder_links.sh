#!/bin/bash

i=1 #folder index
base_dir="/general/software/general/medialink/basedir2";
comb_cmd="";
and_cmd=" && ";
quote="\"";
space=" ";
sudo="sudo ";
select="Selection: ";
fldr_select="0";
find_vids_prog="/general/software/general/scripts/links_config1.sh";

command="cd $base_dir";
eval $command;

read_folders(){
	command="ls"
	folders=$(eval $command);
	for folder in $folders
	do
	command="echo $folder | sed 's/^.*\/\(.*\)$/\1/'";
	folder_search_name=$(eval $command);
	if [ "$folder_search_name" != "icon" ] && [ "$folder_search_name" != "videos" ] \
	&& [ "$folder_search_name" != "combined" ] && [ "$folder_search_name" != "vids" ] \
	&& [ "$folder_search_name" != "clips" ] && [ "$folder_search_name" != "thumbnails" ] \
	&& [ "$folder_search_name" != "favorites" ];
	then
		new_command="[$i] $folder ";
		comb_cmd=$comb_cmd$new_command;

		if [ "$fldr_select" == "$i" ];
		then
			fldr_select="$folder";
		fi

		((i=i+1))
	fi
	done
}

read_folders;

echo_cmd="echo ";
command=$echo_cmd$quote$comb_cmd$quote;
eval $command;

echo "";
echo "Please select a number. Type \"other\" for a new folder.";
read -r fldr_select;

i=1 #folder index

read_folders;
echo $select$fldr_select;

if [ "$fldr_select" == "other" ];
then
	echo "Please type a new folder name.";
	read -r fldr_select;
fi

command=$find_vids_prog$space$fldr_select;
eval $command;
echo $select$fldr_select;

echo "processing completed";