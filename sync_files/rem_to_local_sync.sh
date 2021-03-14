# 
# Sync files in Linux accross local network
#
# Author: Nate Sutton, 2021
#
# See local_to_rem_sync.sh for references
#

REMOTE_SERVER="pi@192.168.0.68:";
SOURCE="$1";
DESTINATION="$REMOTE_SERVER$2";

# See local_to_rem_sync.sh for options descriptions

# Pull DESTINATION to SOURCE
rsync -au --info=progress2 --size-only -e ssh $DESTINATION $SOURCE 

#echo "remote to local sync completed.";