#!/bin/bash

fs_root="/var/www/html/";
command="echo $1 | sed 's/^\(.*\)\/.*$/\1/'";
base_folder=$(eval $command);

caja $fs_root$base_folder