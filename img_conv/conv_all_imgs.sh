#!/bin/bash

if [ "$#" -eq 1 ]; 
then
    filedir=$1
else
    echo 'Please enter image file directory'
    read -r filedir
fi

cd $filedir

/general/software/utilities/rename_blanks/rename_blanks.sh "$filedir" &&

command="ls"
files=$(eval $command);

for file in $files
do
	/general/software/utilities/img_conv/img_conv.sh "$file"
done