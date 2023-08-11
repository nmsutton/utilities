!#bin/bash

command="echo \"$1\" | sed 's/.mkv//'";
export NEW_FILE_NAME=$(eval ${command});
command="echo \"$NEW_FILE_NAME\" | sed 's/ /_/'";
export NEW_FILE_NAME2=$(eval ${command});

ffmpeg -i "$1" -codec copy "$NEW_FILE_NAME2.mp4"

trash-put "$1"