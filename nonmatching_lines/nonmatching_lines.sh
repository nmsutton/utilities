#/bin/bash
#
# outputs lines that don't match between two files
# usage: $ matching_lines.sh <file1> <file2> <output_file>
#
# for each line in file1 it is compared to file2. lines
# in file1 that are not in file2 are reported.
#

file1="$1";
file2="$2";
output_file="$3";
echo "" > $output_file;
line_found="false";
nonmatching="nonmatching lines: ";

i=0;
while read line1; do
	line_found="false";
	while read line2; do
		if [ "$line1" = "$line2" ];
		then
			line_found="true";
		fi
	done <$file2

	if [ "$line_found" = "false" ];
	then
		echo $line1 >> $output_file;
		i=$(expr $i + 1);
	fi
done <$file1

echo $nonmatching$i;