input_file="$1"
command="basename $1 .mp4"
output_file="$(eval $command)_nosound.mp4";

ffmpeg -i "$input_file" -c copy -an "$output_file" &&
trash-put $1
