#/bin/bash

slash="/";
echo 'Starting mp4 video screenshot and thumbnails generator';
if [ "$#" -eq 1 ]; 
then
    starting_folder=$1$slash;
else
    echo 'Please enter folder';
    read -r starting_folder;
    starting_folder=$starting_folder$slash;
fi

/general/software/utilities/rename_blanks/rename_blanks.sh $starting_folder;
command1="gnome-terminal -e \"sudo sh /media/veracrypt10/other/General/software/auto_scsh_tmbs/video_fold_tmbs_2sec_nocrop.sh ";
command2="\"";
eval $command1$starting_folder$command2;
#sudo sh /media/veracrypt10/other/General/software/auto_scsh_tmbs/video_fold_tmbs_2sec.sh $starting_folder
only_video_thumbs.sh $starting_folder;