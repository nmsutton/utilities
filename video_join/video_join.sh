# reference: https://stackoverflow.com/questions/7333232/how-to-concatenate-two-mp4-files-using-ffmpeg

vid1=$1
vid2=$2
command="echo $1 | sed 's/^\(.*\/.*\)\/.*$/\1\//'";
base_dir=$(eval $command);
output_filename="joined_videos.mp4";
vid3=$base_dir$output_filename

#ffmpeg -i "concat:$vid1|$vid2" -c copy $vid3
#(echo file "$vid1" & echo file "$vid2") | ffmpeg -protocol_whitelist file,pipe -f concat -safe 0 -i pipe: -vcodec copy -acodec copy "$vid3"

echo file "$vid1" > $base_dir/temp_list.txt
echo file "$vid2" >> $base_dir/temp_list.txt
ffmpeg -f concat -safe 0 -i $base_dir/temp_list.txt -c copy $vid3
rm $base_dir/temp_list.txt
#	command="$command && ffmpeg -f concat -safe 0 -i $CURRENT_PATH/temp_list.txt -c copy $NEW_FILE_COMB"
#	command="$command && rm $NEW_VID && rm $NEW_FILE_REV" && rm $CURRENT_PATH/temp_list.txt

#echo "file $vid1" >~/list.txt    #single redirect creates or truncates file
#echo "file $vid2" >>~/list.txt   # double redirect appends
#echo "file fname3" >>$$.tmp   # do as many as you want.

#ffmpeg -f concat -i ~/list.txt -codec copy $vid3

#rm ~/list.txt  # just to clean up the temp file. 
           # For debugging, I usually leave this out.

