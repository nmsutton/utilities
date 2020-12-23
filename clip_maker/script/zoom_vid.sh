
#!/bin/bash
#
# reference http://www.markbuckler.com/post/cutting-ffmpeg/
#
# crop
#ffmpeg -i in.mp4 -filter:v "crop=out_w:out_h:x:y" out.mp4
# trim
#ffmpeg -i input.mp4 -ss 01:10:27 -to 02:18:51 -c:v copy -c:a copy output.mp4
# slow
#ffmpeg -i input.mp4 -filter:v "setpts=2*PTS" output.mp4
#
# 1080: 1920 x 1080
# 4K: 3840 x 2160 landscape
# 4K: 2160 x 3840 portrait
# 4K: 1215 x 2160 portrait 1.78x zoom
#

orig_size_w=1920
orig_size_h=1080
time_limit=yes
time_start=4264
time_length=78
trim_start_x=0
trim_start_y=0
zoom=1
speed=1.00 # .5=2x slow down
portrait=n
keep_ss_vid=n
QUALITY=-preset slow -crf 15
video_ext="mp4|wmv|mov|avi|flv|mpg|mpeg|f4v|webm";

# size of output
#$((expression))
command="echo \"$orig_size_w / $zoom\" | bc"
out_w=$(eval $command);
command="echo \"$orig_size_h / $zoom\" | bc"
out_h=$(eval $command);
# starting x,y pixel
x=$trim_start_x
y=$trim_start_y
# starting time
s_t=$time_start
# length of clip
command="echo \"$time_length / $speed\" | bc"
l_t=$(eval $command);
# speed
command="echo \"1 / $speed\" | bc"
spd=$(eval $command);

# set variables
export TIME=$( date '+%F_%H_%M_%S' )
export FULL_PATH="$@"
export CURRENT_PATH=$PWD
command="echo ${FULL_PATH} | tr ' ' '_'"
export FULL_PATH2=$(eval ${command});
command="echo $FULL_PATH2 | sed 's/^.*\/\(.*\)./\1_${TIME}_zoom.mp4/g'";
export NEW_FILE_NAME=$(eval ${command});
command="echo $FULL_PATH | sed 's/^\(.*\/\).*./\1/g'";
export BASE_DIR=$(eval ${command});
export NEW_VID=${BASE_DIR}/${NEW_FILE_NAME}
command="echo $FULL_PATH2 | sed 's/^.*\/\(.*\)./\1_${TIME}_rev.mp4/g'";
export NEW_FILE_REV=${BASE_DIR}/$(eval ${command});
command="echo $FULL_PATH2 | sed 's/^.*\/\(.*\)./\1_${TIME}_zoom_rev.mp4/g'";
export NEW_FILE_COMB=${BASE_DIR}/$(eval ${command});

export vid=${FULL_PATH}

command="xterm -e \"ffmpeg -ss $s_t  -i ${vid} -t $l_t -filter:v crop=$out_w:$out_h:$x:$y,setpts=$spd*PTS $QUALITY ${NEW_VID}"
command="$command\""
$(eval $command);
command="mkdir ${BASE_DIR}/clips"
$(eval $command);
command="mv ${NEW_VID} ${BASE_DIR}/clips"
$(eval $command);
command="mv ${NEW_FILE_COMB} ${BASE_DIR}/clips"
$(eval $command);
command="mv ${SCREEN_SHOT_VID} ${BASE_DIR}/clips"
$(eval $command);

command="echo ${FULL_PATH} | sed 's/^.*\/\(.*\)./\1_${TIME}_orig_clip.mp4/g'";
export SCREEN_SHOT_VID_NEW_PATH=${BASE_DIR}/clips/$(eval ${command});
command="rm ${SCREEN_SHOT_VID_NEW_PATH}"
$(eval $command);
