#!/bin/bash

command="echo $1 | sed 's/^\(.*\)\/.*$/\1/'";
base_folder=$(eval $command);
slash="/";
file_name="new_aspect_ratio.mp4";

xterm -e "ffmpeg -i $1 -aspect 1.334 -codec:a copy $base_folder$slash$file_name"

# ratios
# 1.777 16:9
# 1.334 4:3
