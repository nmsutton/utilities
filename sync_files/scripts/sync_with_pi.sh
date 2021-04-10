#!/bin/bash

psites=("exampe_folder_name1" "example_folder_name2")
DELETE_OPT="DELETE_ON";
PUSH_OPT="PUSH_ONLY";

syncfldrs(){
	command="xargs -L1 echo";
	args=$(eval $command);
	command="echo $args | cut -d' ' -f1";
	fl1=$(eval $command);
	command="echo $args | cut -d' ' -f2";
	fr1=$(eval $command);
	command="echo $args | cut -d' ' -f3";
	fl2=$(eval $command);	
	command="echo $args | cut -d' ' -f4";
	fr2=$(eval $command);
	command="echo $args | cut -d' ' -f5";
	DELETE_OPT=$(eval $command);
	command="echo $args | cut -d' ' -f6";
	PUSH_OPT=$(eval $command);

	if [[ $PUSH_OPT != "PUSH_ONLY" ]]; then
		command="rem_to_local_sync $fl2 $fr2";
		#echo $command;
		eval $command;
	fi
	command="local_to_rem_sync $fl1 $fr1 $DELETE_OPT";
	#echo $command;
	eval $command;
}

for psite in "${psites[@]}"
do
	fl1="/media/nmsutton/StorageDrive6/ExtraFiles/";
	fl1=$fl1$psite;
	fr1="/media/pi/StorageDrive5/ExtraFiles/";
	fl2="/media/nmsutton/StorageDrive6/ExtraFiles/";
	fr2="/media/pi/StorageDrive5/ExtraFiles/";
	fr2=$fr2$psite;

	echo \"$fl1 $fr1 $fl2 $fr2 $DELETE_OPT $PUSH_OPT\" | syncfldrs;
done

fl1="/media/example_folder/ExtraFiles";
fr1="/media/example_folder/";
fl2="/media/example_folder/";
fr2="/media/example_folder/ExtraFiles";

echo \"$fl1 $fr1 $fl2 $fr2 $DELETE_OPT $PUSH_OPT\" | syncfldrs;