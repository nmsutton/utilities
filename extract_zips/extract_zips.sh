#!/bin/sh

xterm -e "/general/software/utilities/extract_zips/unzip_all.sh \"$1\"";

mkdir $1/icon;
command="find $1/ -iname \"*.jpg\" | sort -h | head -n 1 | sed -n 1p";
icon_file=$(eval $command);
cp $icon_file ./icon;
