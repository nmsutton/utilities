#/bin/bash

echo 'Starting recursive thumbnails generator'
if [ "$#" -eq 1 ]; 
then
    starting_folder=$1
else
    echo 'Please enter folder'
    read -r starting_folder
fi

command="find $starting_folder -type d | sed 's/^[.]\(.*\)/\1/g'"
icon_prog="./auto_icons.sh"

for folder_to_process in $(eval $command); 
do
	$icon_prog $folder_to_process
done