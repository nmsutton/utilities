# reference: https://ourcodeworld.com/articles/read/1231/how-to-stack-horizontally-2-videos-with-different-resolutions-using-ffmpeg

vid1=$1
vid2=$2
command="echo $1 | sed 's/^\(.*\/.*\)\/.*$/\1\//'";
base_dir=$(eval $command);
output_filename="comb_videos.mp4";
vid3=$base_dir$output_filename

ffmpeg -n -i $vid1 -i $vid2 -filter_complex "[0:v][1:v]hstack=inputs=2[v]; [0:a][1:a]amerge[a]" -map "[v]" -map "[a]" -ac 2 $vid3
