command="find $1 -iname '*.webp'"
files=$(eval $command);

for file in $files
do
	/general/software/utilities/webp_to_png/webp_to_png.sh $file &&
	rm $file
done