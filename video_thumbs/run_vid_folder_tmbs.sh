#/bin/bash

sudo echo 'Starting mp4 video screenshot and thumbnails generator' #sudo because find uses sudo
if [ "$#" -eq 1 ]; 
then
    starting_folder=$1
else
    echo 'Please enter folder'
    read -r starting_folder
fi

#gnome-terminal -e "sudo sh ./video_fold_tmbs.sh $starting_folder"
sudo sh ./video_fold_tmbs.sh $starting_folder
