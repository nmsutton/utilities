# 
# Sync files in Linux accross local network
#
# Author: Nate Sutton, 2021
#
# See local_to_rem_sync.sh for references
#

if [ $1 = "--help" ];
then
	echo "how to run: sync_files.sh push_source push_dest pull_source pull_dest";
fi

REMOTE_SERVER="pi@192.168.0.68:";
PUSH_SOURCE="$1";
PUSH_DESTINATION="$REMOTE_SERVER$2";
PULL_SOURCE="$3";
PULL_DESTINATION="$REMOTE_SERVER$4";

# See local_to_rem_sync.sh for options descriptions

# Push SOURCE to DESTINATION
rsync -au --info=progress2 --size-only -e ssh $PUSH_SOURCE $PUSH_DESTINATION;

# Pull DESTINATION to SOURCE
rsync -au --info=progress2 --size-only -e ssh $PULL_DESTINATION $PULL_SOURCE;

#echo "remote to local sync completed.";