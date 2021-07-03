#!/bin/bash

i=0; # file index
start=0; # starting file index
end=1000; # ending file index
folder1= # output directory
folder2= # input directory
find_videos_script=/general/software/utilities/find_videos/find_videos.sh
custom_folder_name=""; # specify a particular folder for input
if [ "$#" -eq 1 ]; 
then
    custom_folder_name=$1
fi
delete_new_output_folder="yes"; # Remove previously created new output folder. The folder will be recreated.
softlink_pics="no";

# clear folder
if [[ $delete_new_output_folder == "yes" ]];
then
	if [[ $custom_folder_name != "" ]];
	then
		trash-put $folder1/$custom_folder_name/combined/
	else
		command="ls -d $folder1/*";
		folders=$(eval $command);
		for folder in $folders
		do
			command="echo \"$folder\" | sed 's/^.*\/\(.*\)$/\1/'";
			folder_name=$(eval $command);
			if [ $folder_name != "aab_groups" ] && [ $folder_name != "classic" ] && [ $folder_name != "favorites" ];
		    then
		    	if [[ $i -ge $start ]] && [[ $i -le $end ]];
		    	then
					trash-put $folder1/$folder_name/combined/
		  		fi
		  		((i=i+1))		  		
			fi
		done
	fi
fi

findmedia(){
	command="xargs -L1 echo";
    args=$(eval $command);
    command="echo $args | cut -d' ' -f1";
    input_folder_name=$(eval $command);
    command="echo $args | cut -d' ' -f2";
    output_folder=$(eval $command);
    command="echo $args | cut -d' ' -f3";
    starting_folder=$(eval $command);
	command="$find_videos_script $input_folder_name $output_folder $starting_folder $folder1 $softlink_pics";
	eval $command;
}

processfolder(){
	command="xargs -L1 echo";
    input_folder_name=$(eval $command);
	output_folder="$folder1/$input_folder_name/combined/";
	starting_folder="$folder2/";
	echo \"$input_folder_name $output_folder $starting_folder\" | findmedia
	starting_folder="$folder1";
	echo \"$input_folder_name $output_folder $starting_folder\" | findmedia
}

i=0;

if [[ ! $custom_folder_name == "" ]];
then	
	echo \"$custom_folder_name\" | processfolder
fi

if [[ $custom_folder_name == "" ]];
then
	command="ls -d $folder1/*";
	folders=$(eval $command);
	for folder in $folders
	do
		command="echo \"$folder\" | sed 's/^.*\/\(.*\)$/\1/'";
		folder_name=$(eval $command);
		if [ $folder_name != "aab_groups" ] && [ $folder_name != "classic" ] && [ $folder_name != "favorites" ];
	    then
	    	if [[ $i -ge $start ]] && [[ $i -le $end ]];
	    	then
				echo \"$folder_name\" | processfolder
	  		fi
	  		((i=i+1))	 
		fi
	done
fi