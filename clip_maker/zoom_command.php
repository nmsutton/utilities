<html>
<!--
	Reference: https://stackoverflow.com/questions/8885701/play-local-hard-drive-video-file-with-html5-video-tag
	https://stackoverflow.com/questions/7333232/how-to-concatenate-two-mp4-files-using-ffmpeg
	-->
<head>
	<script>
		function save() {
			var text_string='test';
			text_string+=document.getElementsByName('owid')[0].value;
			text_string+='test';
			document.getElementsByName('command')[0].value = text_string;

			var file = fopen("/var/www/html/general/zoom/script/zoom_vid.sh", 3);// opens the file for writing
			fwrite(file, text_string);// str is the content that is to be written into the file.
			fclose(file);
		}
		function change_textbox(textboxname, selectname) {
			var select_val = document.getElementsByName(selectname)[0].value;
			if (select_val == '3840x2160') {
				document.getElementsByName('owid')[0].value = '3840';
				document.getElementsByName('ohei')[0].value = '2160';
			}
			else if (select_val == '1920x1080') {
				document.getElementsByName('owid')[0].value = '1920';
				document.getElementsByName('ohei')[0].value = '1080';
			}
			else if (select_val != 'Presets') {
				document.getElementsByName(textboxname)[0].value = select_val;
			}			
		}
		function update_start() {
			var start_val = document.getElementsByName('ud_start')[0].value;
			var sv_parsed = start_val.split(":");
			var updated_sv = parseInt(sv_parsed[0]*3600) + parseInt(sv_parsed[1]*60) + parseInt(sv_parsed[2]);
			document.getElementsByName('start')[0].value = updated_sv;
		}		
		function update_end() {
			var end_val = document.getElementsByName('ud_end')[0].value;
			var ev_parsed = end_val.split(":");
			var updated_ev = parseInt(ev_parsed[0]*3600) + parseInt(ev_parsed[1]*60) + parseInt(ev_parsed[2]);
			var updated_ln = updated_ev - parseInt(document.getElementsByName('start')[0].value);
			document.getElementsByName('length')[0].value = updated_ln;
		}
	</script>
	<style type="text/css">
	body {
		background-color: black;
		color: #3a4472;
		font-size: 20px;
		font-family: arial;
	}
	textarea {
		background-color: black;
		color: #3a4472;
		font-size: 20px;
		font-family: arial;
		overflow:hidden;
		border: 3px rgb(55,55,55) solid;
	}
	input[type=submit] {
		padding: 2px 4px;
		background-color: rgb(25,25,25);
		color: #3a4472;
		font-size: 20px;
		font-family: arial;
		border: 3px rgb(55,55,55) solid;
		width:650px;
	}
	.text_color1 {
		/*padding: 2px 4px;
		background-color: rgb(25,25,25);*/
		color: #3a4472;
		font-size: 20px;
		font-family: arial;
		/*border: 3px rgb(55,55,55) solid;
		width:650px;*/
	}
	.select-css {
		padding: 2px 4px;
		background-color: rgb(25,25,25);
		color: #3a4472;
		font-size: 20px;
		font-family: arial;
		border: 3px rgb(55,55,55) solid;
		width:200px;
		text-align: center;
	}
  	</style>
  	<title>Video zoom</title>
<link rel="icon" href="https://cdn.pixabay.com/photo/2012/04/11/11/26/lens-27549_1280.png"> <!-- royalty free image -->
	</head>
	<body>
<?php
echo "<form method='post' action='zoom_command.php'>";

function save_file($file_content) {
	$myFile2 = "/var/www/html/general/zoom/script/zoom_vid.sh";
	$myFileLink2 = fopen($myFile2, 'w') or die("Can't open file.");
	fwrite($myFileLink2, $file_content);
	fclose($myFileLink2);
}
$file_content="
#!/bin/bash
#
# reference http://www.markbuckler.com/post/cutting-ffmpeg/
#
# crop
#ffmpeg -i in.mp4 -filter:v \"crop=out_w:out_h:x:y\" out.mp4
# trim
#ffmpeg -i input.mp4 -ss 01:10:27 -to 02:18:51 -c:v copy -c:a copy output.mp4
# slow
#ffmpeg -i input.mp4 -filter:v \"setpts=2*PTS\" output.mp4
#
# 1080: 1920 x 1080
# 4K: 3840 x 2160 landscape
# 4K: 2160 x 3840 portrait
# 4K: 1215 x 2160 portrait 1.78x zoom
#

orig_size_w=";
$owid=$_REQUEST['owid'];
$ohei=$_REQUEST['ohei'];
if ($_REQUEST['portrait']=='y') {
	if ($ohei==2160) {
		$owid=1080;
	}
	else if ($ohei==1080) {
		$owid=608;
	}
	else {
		$owid=1080;
	}
}
$file_content=$file_content.$owid."
orig_size_h=".$_REQUEST['ohei']."
time_limit=".$_REQUEST['time_limit']."
time_start=".$_REQUEST['start']."
time_length=".$_REQUEST['length']."
trim_start_x=".$_REQUEST['start_x']."
trim_start_y=".$_REQUEST['start_y']."
zoom=".$_REQUEST['zoom']."
speed=".$_REQUEST['speed']." # .5=2x slow down
portrait=".$_REQUEST['portrait']."
keep_ss_vid=".$_REQUEST['keep_ss_vid']."
QUALITY=".$_REQUEST['QUALITY']."
video_ext=\"mp4|wmv|mov|avi|flv|mpg|mpeg|f4v|webm\";

# size of output
#\$((expression))
command=\"echo \\\"\$orig_size_w / \$zoom\\\" | bc\"
out_w=\$(eval \$command);
command=\"echo \\\"\$orig_size_h / \$zoom\\\" | bc\"
out_h=\$(eval \$command);
# starting x,y pixel
x=\$trim_start_x
y=\$trim_start_y
# starting time
s_t=\$time_start
# length of clip
command=\"echo \\\"\$time_length / \$speed\\\" | bc\"
l_t=\$(eval \$command);
# speed
command=\"echo \\\"1 / \$speed\\\" | bc\"
spd=\$(eval \$command);

# set variables
export TIME=$( date '+%F_%H_%M_%S' )
export FULL_PATH=\"\$@\"
export CURRENT_PATH=\$PWD
command=\"echo \${FULL_PATH} | tr ' ' '_'\"
export FULL_PATH2=\$(eval \${command});
command=\"echo \$FULL_PATH2 | sed 's/^.*\/\(.*\).$video_ext/\\"."1"."_\${TIME}_zoom.mp4/g'\";
export NEW_FILE_NAME=\$(eval \${command});
command=\"echo \$FULL_PATH | sed 's/^\(.*\/\).*.$video_ext/\\"."1"."/g'\";
export BASE_DIR=\$(eval \${command});
export NEW_VID=\${BASE_DIR}/\${NEW_FILE_NAME}
command=\"echo \$FULL_PATH2 | sed 's/^.*\/\(.*\).$video_ext/\\1_\${TIME}_rev.mp4/g'\";
export NEW_FILE_REV=\${BASE_DIR}/\$(eval \${command});
command=\"echo \$FULL_PATH2 | sed 's/^.*\/\(.*\).$video_ext/\\1_\${TIME}_zoom_rev.mp4/g'\";
export NEW_FILE_COMB=\${BASE_DIR}/\$(eval \${command});

export vid=\${FULL_PATH}

command=\"xterm -e \\\"ffmpeg ";
$time_limit='no';
if (isset($_REQUEST['time_limit'])) {$time_limit=$_REQUEST['time_limit'];}
if ($time_limit=='yes') {$file_content=$file_content."-ss \$s_t ";}
$file_content=$file_content." -i \${vid} ";
if ($time_limit=='yes') {$file_content=$file_content."-t \$l_t ";}
$file_content=$file_content."-filter:v crop=\$out_w:\$out_h:\$x:\$y,setpts=\$spd*PTS \$QUALITY \${NEW_VID}\"";
if ($_REQUEST['rev_end']=='y') {
	$file_content=$file_content."
	command=\"\$command && ffmpeg -i \$NEW_VID -vf reverse -af areverse \$QUALITY \$NEW_FILE_REV\"
	command=\"\$command && echo file '\${NEW_VID}' > \$CURRENT_PATH/mylist.txt\"
	command=\"\$command && echo file '\$NEW_FILE_REV' >> \$CURRENT_PATH/mylist.txt\"
	command=\"\$command && ffmpeg -f concat -safe 0 -i \$CURRENT_PATH/mylist.txt -c copy \$NEW_FILE_COMB\"
	command=\"\$command && rm \$NEW_VID && rm \$NEW_FILE_REV\" && rm \$CURRENT_PATH/mylist.txt";
}
$file_content=$file_content."
command=\"\$command\\\"\"
\$(eval \$command);";
$length = $_REQUEST['length'];
$file_content=$file_content."
command=\"mkdir \${BASE_DIR}/clips\"
\$(eval \$command);";
if (isset($_REQUEST['screen_s'])) {$screen_s=$_REQUEST['screen_s'];}
if ($screen_s=='y') {

$file_content=$file_content."
command=\"echo \$FULL_PATH | sed 's/^.*\/\(.*\).$video_ext/\\1_\${TIME}_orig_clip.mp4/g'\";
export SCREEN_SHOT_VID=\${BASE_DIR}\$(eval \${command});
command=\"xterm -e \\\"sleep 3s && ffmpeg ";
if ($time_limit='yes') {$file_content=$file_content."-ss \$s_t";}
$file_content=$file_content." -i \$vid ";
if ($time_limit='yes') {$file_content=$file_content." -t ".$length;}
$file_content=$file_content." \$SCREEN_SHOT_VID\\\"\";
\$(eval \$command);";
$file_content=$file_content."
command=\"mkdir \${BASE_DIR}/clips/screen_shots\"
\$(eval \$command);
command=\"echo \$FULL_PATH | sed 's/^.*\/\(.*\).$video_ext/\\1_\${TIME}_zoom_1sec.jpg/g'\";
export SS_PATH1=\$(eval \${command});
eval \"ffmpeg -y -itsoffset -1 -i \$SCREEN_SHOT_VID -vcodec mjpeg -vframes 1 -an -f rawvideo \${BASE_DIR}\${SS_PATH1}\";
command=\"mv \${BASE_DIR}\${SS_PATH1} \${BASE_DIR}/clips/screen_shots\"
\$(eval \$command);";
if ($length>=5) {
$file_content=$file_content."command=\"echo \$FULL_PATH | sed 's/^.*\/\(.*\).$video_ext/\\1_\${TIME}_zoom_5sec.jpg/g'\";
export SS_PATH2=\$(eval \${command});
eval \"ffmpeg -y -itsoffset -5 -i \$SCREEN_SHOT_VID -vcodec mjpeg -vframes 1 -an -f rawvideo \${BASE_DIR}\${SS_PATH2}\";
command=\"mv \${BASE_DIR}\${SS_PATH2} \${BASE_DIR}/clips/screen_shots\"
\$(eval \$command);";
}	
if ($length>=10) {
$file_content=$file_content."command=\"echo \$FULL_PATH | sed 's/^.*\/\(.*\).$video_ext/\\1_\${TIME}_zoom_10sec.jpg/g'\";
export SS_PATH3=\$(eval \${command});
eval \"ffmpeg -y -itsoffset -10 -i \$SCREEN_SHOT_VID -vcodec mjpeg -vframes 1 -an -f rawvideo \${BASE_DIR}\${SS_PATH3}\";
command=\"mv \${BASE_DIR}\${SS_PATH3} \${BASE_DIR}/clips/screen_shots\"
\$(eval \$command);";
}	
if ($length>=20) {
$file_content=$file_content."command=\"echo \$FULL_PATH | sed 's/^.*\/\(.*\).$video_ext/\\1_\${TIME}_zoom_20sec.jpg/g'\";
export SS_PATH4=\$(eval \${command});
eval \"ffmpeg -y -itsoffset -20 -i \$SCREEN_SHOT_VID -vcodec mjpeg -vframes 1 -an -f rawvideo \${BASE_DIR}\${SS_PATH4}\";
command=\"mv \${BASE_DIR}\${SS_PATH4} \${BASE_DIR}/clips/screen_shots\"
\$(eval \$command);";
}	
if ($length>=30) {
$file_content=$file_content."command=\"echo \$FULL_PATH | sed 's/^.*\/\(.*\).$video_ext/\\1_\${TIME}_zoom_30sec.jpg/g'\";
export SS_PATH5=\$(eval \${command});
eval \"ffmpeg -y -itsoffset -30 -i \$SCREEN_SHOT_VID -vcodec mjpeg -vframes 1 -an -f rawvideo \${BASE_DIR}\${SS_PATH5}\";
command=\"mv \${BASE_DIR}\${SS_PATH5} \${BASE_DIR}/clips/screen_shots\"
\$(eval \$command);";
}
if ($length>=45) {
$file_content=$file_content."command=\"echo \$FULL_PATH | sed 's/^.*\/\(.*\).$video_ext/\\1_\${TIME}_zoom_45sec.jpg/g'\";
export SS_PATH6=\$(eval \${command});
eval \"ffmpeg -y -itsoffset -45 -i \$SCREEN_SHOT_VID -vcodec mjpeg -vframes 1 -an -f rawvideo \${BASE_DIR}\${SS_PATH6}\";
command=\"mv \${BASE_DIR}\${SS_PATH6} \${BASE_DIR}/clips/screen_shots\"
\$(eval \$command);";
}
//$file_content=$file_content."command=\"SCREEN_SHOT_VID\"";
$file_content=$file_content."
command=\"mkdir \${BASE_DIR}/clips/icon\"
\$(eval \$command);
command=\"mkdir \${BASE_DIR}/clips/screen_shots/icon\"
\$(eval \$command);
command=\"cp -n \${BASE_DIR}/clips/screen_shots/\${SS_PATH1} \${BASE_DIR}/clips/icon/pic.jpg && sleep 1 && convert \${BASE_DIR}/clips/icon/pic.jpg -resize 400x711^ -gravity center -extent 400x711 \${BASE_DIR}/clips/icon/pic.jpg\"
\$(eval \$command);
command=\"cp -n \${BASE_DIR}/clips/icon/pic.jpg \${BASE_DIR}/clips/screen_shots/icon/\"
\$(eval \$command);

";

}

$file_content=$file_content."
command=\"mv \${NEW_VID} \${BASE_DIR}/clips\"
\$(eval \$command);
command=\"mv \${NEW_FILE_COMB} \${BASE_DIR}/clips\"
\$(eval \$command);
command=\"mv \${SCREEN_SHOT_VID} \${BASE_DIR}/clips\"
\$(eval \$command);
";
if ($_REQUEST['keep_ss_vid']=='n') {
$file_content=$file_content."
command=\"echo \${FULL_PATH} | sed 's/^.*\/\(.*\).$video_ext/\\1_\${TIME}_orig_clip.mp4/g'\";
export SCREEN_SHOT_VID_NEW_PATH=\${BASE_DIR}/clips/\$(eval \${command});
command=\"rm \${SCREEN_SHOT_VID_NEW_PATH}\"
\$(eval \$command);
";
}
if ($_REQUEST['save_file']=='y') {
	save_file($file_content);
}
$original_file='';
$owid=3840;
$ohei=2160;
$time_limit='yes';
$start=122;
$length=3.0;
$start_x=0;
$start_y=0;
$zoom=1;
$speed=0.5;
$portrait='n';
$rev_end='y';
$screen_s='n';
$keep_ss_vid='n';
$QUALITY='-preset slow -crf 15';
if (isset($_REQUEST['original_file'])) {$original_file=$_REQUEST['original_file'];}
if (isset($_REQUEST['owid'])) {$owid=$_REQUEST['owid'];}
if (isset($_REQUEST['ohei'])) {$ohei=$_REQUEST['ohei'];}
if (isset($_REQUEST['time_limit'])) {$time_limit=$_REQUEST['time_limit'];}
if (isset($_REQUEST['start'])) {$start=$_REQUEST['start'];}
if (isset($_REQUEST['length'])) {$length=$_REQUEST['length'];}
if (isset($_REQUEST['start_x'])) {$start_x=$_REQUEST['start_x'];}
if (isset($_REQUEST['start_y'])) {$start_y=$_REQUEST['start_y'];}
if (isset($_REQUEST['zoom'])) {$zoom=$_REQUEST['zoom'];}
if (isset($_REQUEST['speed'])) {$speed=$_REQUEST['speed'];}
if (isset($_REQUEST['portrait'])) {$portrait=$_REQUEST['portrait'];}
if (isset($_REQUEST['rev_end'])) {$rev_end=$_REQUEST['rev_end'];}
if (isset($_REQUEST['screen_s'])) {$screen_s=$_REQUEST['screen_s'];}
if (isset($_REQUEST['keep_ss_vid'])) {$keep_ss_vid=$_REQUEST['keep_ss_vid'];}
if (isset($_REQUEST['QUALITY'])) {$QUALITY=$_REQUEST['QUALITY'];}
//echo "<center><table><tr><td style='width:600px'>Video original size width</td><td><textarea style='width:200px;height:30px;' name='owid'>$owid</textarea></td></tr>";
echo "<center><table><tr><td style='width:600px'>Video original size width</td><td><textarea style='width:200px;height:30px;' name='owid'>$owid</textarea></td><td><select class='select-css' name='owid-select' onchange=\"javascript:change_textbox('owid','owid-select')\"><option>Presets</option><option value='3840x2160'>3840x2160</option><option value='1920x1080'>1920x1080</option><option value='3840'>3840</option><option value='1920'>1920</option></select></td></tr>";
//echo "<tr><td>Video original size height</td><td><textarea style='width:200px;height:30px;' name='ohei'>$ohei</textarea></td></tr>";
echo "<tr><td>Video original size height</td><td><textarea style='width:200px;height:30px;' name='ohei'>$ohei</textarea></td><td><select class='select-css' name='ohei-select' onchange=\"javascript:change_textbox('ohei','ohei-select')\"><option>Presets</option><option value='2160'>2160</option><option value='1080'>1080</option></select></td></tr>";
echo "<tr><td>Time limit</td><td><select class='select-css' name='time_limit' onchange=\"javascript:change_textbox('time_limit','time_limit')\"><option value='yes'";
if ($time_limit=='yes') {echo " selected";}
echo ">yes</option><option value='no'";
if ($time_limit=='no') {echo " selected";}
echo ">no</option></select></td></tr>";
echo "<tr><td>Video track start time</td><td><textarea style='width:200px;height:30px;' name='ud_start'>00:00:00</textarea></td><td><input type='button' name='ud_start_btn' value='Update' style='width:200px;' onclick='javascript:update_start()'></input></td></tr>";
echo "<tr><td>Video track end time</td><td><textarea style='width:200px;height:30px;' name='ud_end'>00:00:00</textarea></td><td><input type='button' name='ud_end_btn' value='Update' style='width:200px;' onclick='javascript:update_end()'></input></td></tr>";
echo "<tr><td>Time start</td><td><textarea style='width:200px;height:30px;' name='start'>$start</textarea></td><td> 1min = 60</td></tr>";
echo "<tr><td>Time length</td><td><textarea style='width:200px;height:30px;' name='length'>$length</textarea></td></tr>";
echo "<tr><td>Trim start x</td><td><textarea style='width:200px;height:30px;' name='start_x'>$start_x</textarea></td></tr>";
echo "<tr><td>Time start y</td><td><textarea style='width:200px;height:30px;' name='start_y'>$start_y</textarea></td></tr>";
//echo "<tr><td>Zoom</t style='width:200px;height:30px;' name='owid'd><td><textarea style='width:200px;height:30px;' name='zoom'>$zoom</textarea></td></tr>";
echo "<tr><td>Zoom</td><td><textarea style='width:200px;height:30px;' name='zoom'>$zoom</textarea></td><td><select class='select-css' name='zoom-select' onchange=\"javascript:change_textbox('zoom','zoom-select')\"><option>Presets</option><option value='1.00'>1.00</option><option value='1.50'>1.50</option><option value='2.00'>2.00</option></select></td></tr>";
echo "<tr><td>Speed</td><td><textarea style='width:200px;height:30px;' name='speed'>$speed</textarea></td><td><select class='select-css' name='speed-select' onchange=\"javascript:change_textbox('speed','speed-select')\"><option>Presets</option><option value='1.00'>1.00</option><option value='0.50'>0.50</option><option value='0.25'>0.25</option></select></td></tr>";
//echo "<tr><td>Portrait</td><td><textarea style='width:200px;height:30px;' name='portrait'>$portrait</textarea></td></tr>";
echo "<tr><td>Portrait</td><td><select name='portrait' class='select-css'><option value='y'"; 
if ($portrait=='y') {echo " selected";}
echo ">yes</option><option value='n'";
if ($portrait=='n') {echo " selected";}
echo ">no</option></select></td></tr>";
//echo "<tr><td>Reverse at end</td><td><textarea style='width:200px;height:30px;' name='rev_end'>$rev_end</textarea></td></tr>";
echo "<tr><td>Reverse at end</td><td><select name='rev_end' class='select-css'><option value='y'"; 
if ($rev_end=='y') {echo " selected";}
echo ">yes</option><option value='n'";
if ($rev_end=='n') {echo " selected";}
echo ">no</option></select></td></tr>";
//echo "<tr><td>Screen shots</td><td><textarea style='width:200px;height:30px;' name='screen_s'>$screen_s</textarea></td></tr>";
echo "<tr><td>Screen shots</td><td><select name='screen_s' class='select-css'><option value='y'"; 
if ($screen_s=='y') {echo " selected";}
echo ">yes</option><option value='n'";
if ($screen_s=='n') {echo " selected";}
echo ">no</option></select></td></tr>";
//echo "<tr><td>Keep screen shot vid</td><td><textarea style='width:200px;height:30px;' name='keep_ss_vid'>$keep_ss_vid</textarea></td></tr>";
echo "<tr><td>Keep screen shot vid</td><td><select name='keep_ss_vid' class='select-css'><option value='y'"; 
if ($keep_ss_vid=='y') {echo " selected";}
echo ">yes</option><option value='n'";
if ($keep_ss_vid=='n') {echo " selected";}
echo ">no</option></select></td></tr>";
echo "<tr><td>Quality</td><td><textarea style='width:200px;height:30px;' name='QUALITY'>$QUALITY</textarea></td><td> \"default\" for use default</td></tr>";
echo "</table>";
echo "<br><input type='hidden' id='save_file' name='save_file' value='y'></input><input type='submit' name='submit' value='Save File'></input><br><br><center><a href='zoom_command.php' style='text-decoration: none' class='text_color1'>Zoom Video Page Reload</a></center>";
?>
</center>
</form>
</body>
</html>