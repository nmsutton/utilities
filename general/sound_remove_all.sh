/general/software/utilities/rename_blanks/rename_blanks.sh $PWD
ls -1 *.mp4 | xargs -n 1 bash -c 'sound_remove.sh "$0"'