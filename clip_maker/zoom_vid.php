<html>
<!--
	Reference: https://stackoverflow.com/questions/8885701/play-local-hard-drive-video-file-with-html5-video-tag
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
			    var file = this.files[0]
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
			  var inputNode = document.querySelector('input')
			  inputNode.addEventListener('change', playSelectedFile, false)
			})()
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
	</head>
	<body>
<?php
echo "
<center>
	<table><tr><td><a href='zoom_vid.php' style='text-decoration:none;' class='text_color1'>Show video</a></td><td><textarea style='width:400px;height:30px;' name='original_file' id='original_file'>$original_file</textarea></td><td><label for='file-upload' class='custom-file-upload'><i class='fa fa-cloud-upload'></i> Browse</label><input id='file-upload' type='file' accept='video/*' /></td><td><input type='submit' name='submit' value='Update' onclick='javascript:print_source()' style='width:100px;' /><div id='message' style='display: none;'></div></td></tr></table>
	<video controls autoplay loop width='640' height='360' id='loaded_video' />
</center>";
?>
</form>
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
<center><iframe src="zoom_command.php" width="800" height="720" style="border: none;overflow: hidden;"></iframe></center>
</body>
</html>