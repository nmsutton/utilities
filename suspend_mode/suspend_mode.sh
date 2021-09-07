#!/bin/bash

echo "";
echo "";
echo "";
echo "";
echo "";
echo "";
echo "                               ____________________________________";
echo "                               |                                  |";
echo "                               |                                  |";
echo "                               |       Enter Suspend Mode?        |";
echo "                               |                                  |";
echo "                               |__________________________________|";
echo "";
echo "                                 Enter \"y\" to begin suspend mode."
echo "";
read user_input;
if [ $user_input = "y" ];
then
	sudo pm-suspend;
fi
