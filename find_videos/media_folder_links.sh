#!/bin/bash

delete_new_output_folder="y"; # Remove previously created new output folder. The folder will be recreated.
softlink_pics="n";

i=1 #folder index
base_dir="/general/software/general/medialink/basedir2";
comb_cmd="Select folder: ______";
and_cmd=" && \t ";
quote="\"";
space=" ";
sudo="sudo ";
echo_cmd="echo -e ";
select="Selection: ";
fldr_select="0";
find_vids_prog="/general/software/general/scripts/links_config1.sh";
find_vids_prog2="/general/software/general/scripts/links_config2.sh";

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
		command="echo \"[$i] $folder __________________________\" | cut -c1-21";
		upd_folder=$(eval $command);
		new_command="\t\t $upd_folder ";
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

command=$echo_cmd$quote$comb_cmd$quote;
eval $command;

echo "";
echo "Please select a number. Type \"other\" for a new folder. Type \"options\" for software options.";
read -r fldr_select;

i=1 #folder index

read_folders;
echo $select$fldr_select;

if [ "$fldr_select" == "other" ];
then
	echo "Please type a new folder name.";
	read -r fldr_select;
fi

if [ "$fldr_select" == "options" ];
then
	echo "Delete original folder (y or n)?";
	read -r delete_new_output_folder;
	echo "Create image softlinks (y or n)?";
	read -r softlink_pics;
	echo "Please select a number. Type \"other\" for a new folder.";
	read -r fldr_select;

	if [ "$fldr_select" == "other" ];
	then
		echo "Please type a new folder name.";
		read -r fldr_select;
	fi
fi

command=$find_vids_prog$space$fldr_select$space$delete_new_output_folder$space$softlink_pics;
eval $command;
command=$find_vids_prog2$space$fldr_select$space$delete_new_output_folder$space$softlink_pics;
eval $command;
echo $select$fldr_select;

echo "processing completed";