#!/bin/bash

#image=$1

image_orig=$1;
#replace_text="/media/veracrypt10/collection/General/scripts/show_img/replace_text.php";
#command="php \"$replace_text\" \"$image_orig\"";
#image=$(eval $command);

command="echo \"$image_orig\" | sed \"s/http\:\/\/localhost/\/var\/www\/html\//\"";
image=$(eval $command);

command="echo $image | sed 's/^\(.*\)\/.*$/\1/'";
base_dir=$(eval $command);
command="echo $image | sed 's/^.*\/\(.*\)$/\1/'";
image_name=$(eval $command);
icon_dir="/icon";
slash="/";
image_icon="$base_dir$icon_dir$slash$image_name";
resize_cmd="convert $image_icon -resize 512 $image_icon";
crop_cmd="mogrify -crop 308x512+85+0 $image_icon";
adj_icon="$resize_cmd && $crop_cmd";

mkdir $base_dir$icon_dir
cp $image $base_dir$icon_dir && eval $adj_icon;
