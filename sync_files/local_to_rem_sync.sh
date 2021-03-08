# 
# Sync files in Linux accross local network
#
# Author: Nate Sutton, 2021
#
# References: https://www.digitalocean.com/community/tutorials/how-to-use-rsync-to-sync-local-and-remote-directories
# https://www.tecmint.com/sync-new-changed-modified-files-rsync-linux/
# https://www.atlantic.net/vps-hosting/how-to-use-rsync-copy-sync-files-servers/
#

SOURCE="/home/nmsutton/Dropbox/CompNeuro/gmu/research";
DESTINATION="pi@192.168.0.68:/home/pi/Dropbox/CompNeuro/gmu";

#
# Options
#
# -a = archive. syncs recursively and preserves symbolic links, special and device files, modification times, group, owner, and permissions.
# -u = update only different/changed/added files from the SOURCE to the DESTINATION. 
# --delete = the option --delete will remove any files from the DESTINATION that the SOURCE may no longer have.
# --info=progress2 --size-only = show percent progress
# -e = execute command
# ssh = run through ssh
#

# Push SOURCE to DESTINATION
rsync -au --info=progress2 --size-only -e ssh $SOURCE $DESTINATION

echo "local to remote sync completed.";