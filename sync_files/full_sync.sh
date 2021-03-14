#
# Full sync of files
#
# Sync Dropbox files without needing to connect
# remote computer to dropbox.
#
# Author: Nate Sutton, 2021
#

/general/software/utilities/sync_files/local_to_rem_sync.sh "/home/nmsutton/Dropbox/CompNeuro/gmu/research" "/home/pi/Dropbox/CompNeuro/gmu" && \
/general/software/utilities/sync_files/rem_to_local_sync.sh "/home/nmsutton/Dropbox/CompNeuro/gmu" "/home/pi/Dropbox/CompNeuro/gmu/research"