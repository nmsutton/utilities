#!/bin/bash

if [ "$#" -eq 1 ]; 
then
    filedir=$1
else
    echo 'Please enter video file directory'
    read -r filedir
fi

cd $filedir

command="ls"
files=$(eval $command);

for file in $files
do
	/general/software/utilities/mp4_conv/mp4_conv.sh "$file"
done