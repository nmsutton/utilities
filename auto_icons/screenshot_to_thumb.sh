#/bin/bash
# create thumbnail image from screenshot

screenshot=$1;

command="echo $1 | sed 's/^\(.*\)\/.*$/\1/'";
base_dir=$(eval $command);
command="mkdir $base_dir/icon/";
eval $command;
command="mkdir $base_dir/icon/videos/";
eval $command;
command="echo \"$screenshot\" | sed 's/\(.*\)\/\(.*\)_[0-9]*\(.jpg\|.png|\.jpeg\)$/\1\/icon\/videos\/\2_thumb\3/g'";
thumbname=$(eval $command);
#echo $thumbname;
move_cmd="mv $screenshot $thumbname";
resize_cmd="convert $thumbname -resize 1080 $thumbname";
crop_cmd="mogrify -crop 650x1080+250+0 $thumbname";
command="$move_cmd && $resize_cmd && $crop_cmd";
eval $command;
assign_cmd="gio set \"$screenshot\" metadata::custom-icon \"file://$thumbname\"";
eval $assign_cmd;