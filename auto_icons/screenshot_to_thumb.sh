#/bin/bash
# create thumbnail image from screenshot

screenshot=$1;

command="echo \"$screenshot\" | sed 's/\(.*\)\/\(.*\)_[0-9]*\(.jpg\|.png|\.jpeg\)$/\1\/icon\/videos\/\2_thumb\3/g'";
thumbname=$(eval $command);
#echo $thumbname;
command="mv $screenshot $thumbname";
eval $command;
resize_cmd="convert $thumbname -resize 1080 $thumbname";
eval $resize_cmd;
crop_cmd="mogrify -crop 650x1080+250+0 $thumbname";
eval $crop_cmd;