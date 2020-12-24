## Clip maker ##

This must be run on a php web server to work. Local web server is fine. 
zoom_vid.php is the correct page to open for running the operations.
zoom_vid.sh must have the correct access permissions. In linux these
can be set by $ sudo chmod 777 zoom_vid.sh && sudo chmod +x zoom_vid.sh.

Usage:
Open zoom_vid.php in a browser. Set the configuration wanted and press
"save file". That updates zoom_vid.sh. Use a file manager to open the
target video with the command "/var/www/html/general/zoom/script/zoom_vid.sh %F".
That will launch xterm which runs ffmpeg to make the clip. A video can
be viewed with the zoom_vid.php page, but there is not yet functionality
to extract position locations from playing the video into the clip
configuration.

Requirements:
ffmpeg
xterm
gnome-terminal
