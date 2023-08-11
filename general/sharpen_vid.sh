!#bin/bash

command="echo \"$1\" | sed 's/.mp4//'";
export NEW_FILE_NAME=$(eval ${command});
command="echo \"$NEW_FILE_NAME\" | sed 's/ /_/'";
export NEW_FILE_NAME2=$(eval ${command});
export NEW_FILE_NAME3="_sharpened.mp4";
export NEW_FILE_NAME4=$NEW_FILE_NAME2$NEW_FILE_NAME3;

ffmpeg -i "$1" -vf unsharp "$NEW_FILE_NAME4"