<html>
<!--
	Reference: https://stackoverflow.com/questions/8885701/play-local-hard-drive-video-file-with-html5-video-tag
	https://www.codespeedy.com/convert-seconds-to-hh-mm-ss-format-in-javascript/
	-->
<head>
	<script>	
		window.onload=function(){(  
			function localFileVideoPlayer() {
				'use strict'
			  var URL = window.URL || window.webkitURL
			  var displayMessage = function (message, isError) {
			    var element = document.querySelector('#message')
			    element.innerHTML = message
			    element.className = isError ? 'error' : 'info'
			  }
			  var playSelectedFile = function (event) {
			    /*var file = this.files[0]*/
			    var file = '';
			    var type = file.type
			    var videoNode = document.querySelector('video')
			    var canPlay = videoNode.canPlayType(type)
			    if (canPlay === '') canPlay = 'no'
			    var message = 'Can play type "' + type + '": ' + canPlay
			    var isError = canPlay === 'no'
			    displayMessage(message, isError)

			    if (isError) {
			      return
			    }

			    var fileURL = URL.createObjectURL(file)
			    videoNode.src = fileURL
			  }
			  //playSelectedFile();
				var videocontainer = document.getElementById('loaded_video');
				var videosource = document.getElementById('video_source');
				var videocontainer2 = document.getElementById('previewvideo');
				var videosource2 = document.getElementById('video_source2');				
				<?php
					if (isset($_REQUEST['original_file'])) {
						$_REQUEST['video_url'] = $_REQUEST['original_file'];
					}
					if (isset($_REQUEST['video_url'])) {
						echo "document.getElementById('original_file').value = '".$_REQUEST['video_url']."';";
						$_REQUEST['original_file'] = $_REQUEST['video_url'];
					}
				?>
				var newmp4 = document.getElementById('original_file').value;
				var newposter = 'images/video-cover.jpg';
				 
				var videobutton = document.getElementById("videolink1");				 
				videobutton.addEventListener("click", function(event) {
					newmp4 = document.getElementById('original_file').value;
					let newurl = newmp4.replace("\/var\/www\/html", "");
					document.getElementById('original_file').value = newurl;
				    videocontainer.pause();
				    videosource.setAttribute('src', newurl);
				    videocontainer.load();
				    videocontainer.play();
				}, false);

				var previewbutton = document.getElementById("previewlink");
				previewbutton.addEventListener("click", function(event) {
					var startTime = parseInt(document.getElementById("start").innerHTML);
					var endTime = startTime + parseInt(document.getElementById("length").innerHTML);					
					newmp4 = document.getElementById('original_file').value;
					let newurl = newmp4.replace("\/var\/www\/html", "");
					document.getElementById('original_file').value = newurl;
					newurl = newurl+"#t="+startTime+","+endTime;
				    videocontainer2.pause();
				    videosource2.setAttribute('src', newurl);
				    videocontainer2.load();
				    //videocontainer2.play();
				    play_video_preview();
				}, false);
				<?php
					if (isset($_REQUEST['video_url']) || isset($_REQUEST['original_file'])) {
						echo "
						newmp4 = document.getElementById('original_file').value;
					    videocontainer.pause();
					    videosource.setAttribute('src', newmp4);
					    videocontainer.load();
					    videocontainer.play();
						";
					}
				?>
			  var inputNode = document.querySelector('input')
			  inputNode.addEventListener('change', playSelectedFile, false)
			})()
    	}
    	function gettime(){
		  var video= document.getElementById("loaded_video");
		  console.log(video.currentTime);
		  var time = Math.floor(video.currentTime);
		  var measuredTime = new Date(null);
		  measuredTime.setSeconds(time); // specify value of SECONDS
		  var MHSTime = measuredTime.toISOString().substr(11, 8);
		  var time_report = MHSTime;
		  document.getElementById("ud_start").innerHTML= time_report;
		}
		function settime(){
		  var video=document.getElementById("loaded_video");
		  video.currentTime=parseInt(document.getElementById("start").innerHTML);
		}
		function gettimeend(){
		  var video= document.getElementById("loaded_video");
		  console.log(video.currentTime);
		  var time = Math.floor(video.currentTime);
		  var measuredTime = new Date(null);
		  measuredTime.setSeconds(time); // specify value of SECONDS
		  var MHSTime = measuredTime.toISOString().substr(11, 8);
		  var time_report = MHSTime;
		  document.getElementById("ud_end").innerHTML= time_report;
		}
		function settimeend(){
		  var video=document.getElementById("loaded_video");
		  video.currentTime=parseInt(document.getElementById("start").innerHTML)+parseInt(document.getElementById("length").innerHTML);
		}
		function settimeend(){
		  var video= document.getElementById("loaded_video");
		  console.log(video.currentTime);
		  var time = Math.floor(video.currentTime);
		  var measuredTime = new Date(null);
		  measuredTime.setSeconds(time); // specify value of SECONDS
		  var MHSTime = measuredTime.toISOString().substr(11, 8);
		  var time_report = MHSTime;
		  document.getElementById("ud_end").innerHTML= time_report;
		}
		function play_video_preview() {
			var startTime = parseInt(document.getElementById("start").innerHTML);
			var endTime = startTime + parseInt(document.getElementById("length").innerHTML);
	       var videoplayer = document.getElementById("previewvideo");  //get your videoplayer

	       videoplayer.currentTime = startTime; //not sure if player seeks to seconds or milliseconds
	       videoplayer.play();

	       //call function to stop player after given intervall
	       var stopVideoAfter = (endTime - startTime) * 1000;  //* 1000, because Timer is in ms
	       setTimeout(function(){
	           //videoplayer.stop();
	           videoplayer.currentTime = startTime;
	       }, stopVideoAfter);
		}
		/*var videoplayer = document.getElementById("previewvideo");  //get your videoplayer
		videoplayer.addEventListener("playing", function(event) {
			if (videoplayer.currentTime == 5) {
				videoplayer.currentTime = 2;
			}
		}, false);*/
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
	video,
	input {
	  display: block;
	}

	input {
	  width: 100%;
	}

	.info {
	  background-color: aqua;
	}

	.error {
	  background-color: red;
	  color: white;
	}
	input[type="file"] {
	    display: none;
	}
	.custom-file-upload {
	    display: inline-block;
	    padding: 2px 4px;
	    background-color: rgb(25,25,25);
		color: #3a4472;
		font-size: 20px;
		font-family: arial;
		border: 3px rgb(55,55,55) solid;
		width:100px;
		text-align: center;
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
  	</style>
  	<title>Video zoom</title>
<link rel="icon" href="https://cdn.pixabay.com/photo/2012/04/11/11/26/lens-27549_1280.png"> <!-- royalty free image -->
<script>
		function save() {
			var text_string='test';
			text_string+=document.getElementsByName('owid')[0].value;
			text_string+='test';
			document.getElementsByName('command')[0].value = text_string;

			var file = fopen("/var/www/html/general/zoom/script/zoom_vid.clpmkr", 3);// opens the file for writing
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
			else if (select_val == '1280x720') {
				document.getElementsByName('owid')[0].value = '1280';
				document.getElementsByName('ohei')[0].value = '720';
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
	</head>
	<body>
<?php
if (isset($_REQUEST['original_file'])) {$original_file=$_REQUEST['original_file'];}
echo "<form method='post' action='zoom_vid.php'>";
echo "
<center>
	<table><tr><td><a href='zoom_vid.php' style='text-decoration:none;' class='text_color1'>Show video</a></td><td><textarea style='width:400px;height:30px;' name='original_file' id='original_file'>$original_file</textarea></td><td><a href=\"#\" id=\"videolink1\" class='text_color1 custom-file-upload' style='text-decoration:none'>Update</a><label for='file-upload' class='custom-file-upload'><i class='fa fa-cloud-upload'></i> Browse</label><input id='file-upload' type='file' accept='video/*' /><div id='message' style='display: none;'></div></td></tr></table>
	<span>
		<video controls autoplay loop width='640' height='360' id='loaded_video' style='display: inline-block;'>
		<source id=\"video_source\" src=\"\" type=\"video/mp4\"  />
		</video>
		<video controls autoplay loop width='640' height='360' id='previewvideo' style='display: inline-block;'>
		<source id=\"video_source2\" src=\"\" type=\"video/mp4\"  />
		</video>
	</span>
</center>";
?>
<center>
 <a href="javascript:gettime()" class='text_color1 custom-file-upload' style='text-decoration:none;'>Get Start</a>
 <a href="javascript:settime()" class='text_color1 custom-file-upload' style='text-decoration:none;'>Set Start</a>
<a href="javascript:gettimeend()" class='text_color1 custom-file-upload' style='text-decoration:none;'>Get End</a>
 <a href="javascript:settimeend()" class='text_color1 custom-file-upload' style='text-decoration:none;'>Set End</a>
 <a href='#' id='previewlink' class='text_color1 custom-file-upload' style='text-decoration:none;width:150px;'>Load Preview</a>
</center>
<script>
	// tell the embed parent frame the height of the content
	if (window.parent && window.parent.parent){
	  window.parent.parent.postMessage(["resultsFrame", {
	    height: document.body.getBoundingClientRect().height,
	    slug: "cCCZ2"
	  }], "*")
	}

	// always overwrite window.name, in case users try to set it manually
	window.name = "result"
</script>
<!--center><iframe src="zoom_vid.php" width="800" height="720" style="border: none;overflow: hidden;"></iframe></center-->
<?php
echo "<input type='hidden' id='video_url' name='video_url' value='";
if (isset($_REQUEST['video_url'])) {
	echo $_REQUEST['video_url'];
}
echo "'></input>";
function save_file($file_content) {
	$myFile2 = "/var/www/html/general/zoom/script/zoom_vid.clpmkr";
	$myFileLink2 = fopen($myFile2, 'w') or die("Can't open file.");
	fwrite($myFileLink2, $file_content);
	fclose($myFileLink2);
}
#echo $file_content;
$original_file='';
$owid=1920;
$ohei=1080;
$time_limit='yes';
$start=0;
$length=3.0;
$start_x=0;
$start_y=0;
$zoom=1.0;
$speed=1.0;
$portrait='n';
$rev_end='n';
$screen_s='n';
$keep_ss_vid='n';
$QUALITY='-preset slow -crf 15';
$sharpen='n';
$network_file='n';
$fast_resize='n';
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
if (isset($_REQUEST['sharpen'])) {$sharpen=$_REQUEST['sharpen'];}
if (isset($_REQUEST['network_file'])) {$network_file=$_REQUEST['network_file'];}
if (isset($_REQUEST['fast_resize'])) {$fast_resize=$_REQUEST['fast_resize'];}
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
sharpen=".$_REQUEST['sharpen']."
network_file=".$_REQUEST['network_file']."
network_local=/run/user/1000/gvfs/smb-share:server=192.168.0.195,share=videos/
fast_resize=".$_REQUEST['fast_resize']."
video_ext=\"mp4|wmv|mov|avi|flv|mpg|mpeg|f4v|webm|mkv\";

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
export FULL_PATH=\"".$_REQUEST['video_url']."\"
command=\"echo \$FULL_PATH | sed 's/^\/general\/\(.*\)/\/var\/www\/html\/general\/\\1/g'\";
export FULL_PATH=\$(eval \${command});
#command=\"echo \$FULL_PATH | sed 's/^http:\/\/localhost\/\(.*\)/\/var\/www\/html\/\\1/g'\";
#export FULL_PATH=\$(eval \${command});
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
if ($fast_resize=='n') {
$file_content=$file_content."-filter:v crop=\$out_w:\$out_h:\$x:\$y,setpts=\$spd*PTS \$QUALITY";
}
else if ($fast_resize=='y') {
	$file_content=$file_content."-codec copy";
}
$file_content=$file_content." \${NEW_VID}\"";
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
//echo "<center><table><tr><td style='width:600px'>Video original size width</td><td><textarea style='width:200px;height:30px;' name='owid'>$owid</textarea></td></tr>";
echo "<center><table><tr><td style='width:600px'>Video original size width</td><td><textarea style='width:200px;height:30px;' name='owid'>$owid</textarea></td><td><select class='select-css' name='owid-select' onchange=\"javascript:change_textbox('owid','owid-select')\"><option>Presets</option><option value='3840x2160'>3840x2160</option><option value='1920x1080'>1920x1080</option><option value='1280x720'>1280x720</option><option value='3840'>3840</option><option value='1920'>1920</option><option value='1280'>1280</option></select></td></tr>";
//echo "<tr><td>Video original size height</td><td><textarea style='width:200px;height:30px;' name='ohei'>$ohei</textarea></td></tr>";
echo "<tr><td>Video original size height</td><td><textarea style='width:200px;height:30px;' name='ohei'>$ohei</textarea></td><td><select class='select-css' name='ohei-select' onchange=\"javascript:change_textbox('ohei','ohei-select')\"><option>Presets</option><option value='2160'>2160</option><option value='1080'>1080</option></select></td></tr>";
echo "<tr><td>Time limit</td><td><select class='select-css' name='time_limit' onchange=\"javascript:change_textbox('time_limit','time_limit')\"><option value='yes'";
if ($time_limit=='yes') {echo " selected";}
echo ">yes</option><option value='no'";
if ($time_limit=='no') {echo " selected";}
echo ">no</option></select></td></tr>";
echo "<tr><td>Video track start time</td><td><textarea style='width:200px;height:30px;' name='ud_start' id='ud_start'>00:00:00</textarea></td><td><input type='button' name='ud_start_btn' value='Update' style='width:200px;' class='text_color1 custom-file-upload' onclick='javascript:update_start()'></input></td></tr>";
echo "<tr><td>Video track end time</td><td><textarea style='width:200px;height:30px;' name='ud_end' id='ud_end'>00:00:00</textarea></td><td><input type='button' name='ud_end_btn' value='Update' style='width:200px;' class='text_color1 custom-file-upload' onclick='javascript:update_end()'></input></td></tr>";
echo "<tr><td>Time start</td><td><textarea style='width:200px;height:30px;' name='start' id='start'>$start</textarea></td><td> 1min = 60</td></tr>";
echo "<tr><td>Time length</td><td><textarea style='width:200px;height:30px;' name='length' id='length'>$length</textarea></td><td>1.6 = 1.6 seconds</td></tr>";
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
echo "<tr><td>Sharpen</td><td><select name='sharpen' class='select-css'><option value='y'"; 
if ($sharpen=='y') {echo " selected";}
echo ">yes</option><option value='n'";
if ($sharpen=='n') {echo " selected";}
echo ">no</option></select></td></tr>";
echo "<tr><td>Network vid</td><td><select name='network_vid' class='select-css'><option value='y'"; 
if ($network_vid=='y') {echo " selected";}
echo ">yes</option><option value='n'";
if ($network_vid=='n') {echo " selected";}
echo ">no</option></select></td></tr>";
echo "<tr><td>Fast resize</td><td><select name='fast_resize' class='select-css'><option value='y'"; 
if ($fast_resize=='y') {echo " selected";}
echo ">yes</option><option value='n'";
if ($fast_resize=='n') {echo " selected";}
echo ">no</option></select></td></tr>";
echo "</table>";
//$current_folder = str_replace("http://localhost", "", $_REQUEST['video_url']);
$current_folder = str_replace("\/var\/www\/html", "", $_REQUEST['video_url']);
$current_folder = str_replace("general", "var/www/html/general", $_REQUEST['video_url']);
//http://localhost/var/www/html/general/medialink/medialink/dir/dir/
//$current_folder = preg_replace('localhost', '/file\:\/\/', $_REQUEST['video_url']);
//$current_folder = str_replace("general", "var/www/html", $_REQUEST['video_url']);
preg_match('/(.*)\/.*.mp4/', $current_folder, $matches);
$current_folder = $matches[1]."/clips/";
echo "<br><input type='hidden' id='save_file' name='save_file' value='y'></input><input type='submit' name='submit' value='Save File' style='width:113px'></input><a href=\"http://localhost/general/zoom/script/zoom_vid.clpmkr\" id=\"runlink\" class='text_color1 custom-file-upload' style='text-decoration:none'>Run</a><a href=\"".$current_folder."\" id=\"clipsfolde1link\" class='text_color1 custom-file-upload' style='text-decoration:none'>ClipsFolder</a><br><br><center><a href='zoom_vid.php' style='text-decoration: none' class='text_color1'>Zoom Video Page Reload</a></center>";
?>
</center>
</form>
</body>
</html>