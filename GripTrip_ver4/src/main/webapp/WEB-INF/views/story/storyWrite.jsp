<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<meta charset="UTF-8">
<title>GripTrip | TravelMaker</title>
	<link rel="shortcut icon" href="images/ico/griptrip.ico">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/flick/jquery-ui.css">
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/story/story2.css?ver=1" rel="stylesheet">
	<link href="css/main.css" rel="stylesheet">
	<link href="css/story/style.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/jejugothic.css);

.col-sm-12, h1, h2, #info {
	font-family: 'Jeju Gothic';
}
</style>
<script type="text/javascript">
$(function() {
	$('#writeFrm').submit(function(){
	    if($('input[name=storyTitle]').val().length > 20){
	       alert('제목은 20자 이내여야 합니다.');
	       return false;
	    }
	});
});
</script>
</head>
<body>
<div id="info" style="width: 93%; height: auto; border: 2px solid #EEEEEE">
	<div>
	<form action="insertStoryInfo.do" name="storyFrm" method="post" enctype="multipart/form-data" id="writeFrm">
	<input type="hidden" name="book_no" value="${book.book_no}">
	<input type="hidden" name="bookmark" value="false">
	<div class="row">
		<div class="col-md-5">
		<input type="text" name="storyTitle" required="required" placeholder="제목" style="width: 333px;" class="form-control"><p><p>
		<input type="file" name="uploadFile" placeholder="파일" style="width: 333px;" class="form-control"><p><p>
		<textarea rows="20" cols="30" name="storyContent" required="required" style="height: 360px; width: 333px" class="form-control"></textarea>
		</div>
		<div class="col-md-7">
			<div id="mapLayout" style="float:left; width: 50%; margin-top:80px; margin-left: 20px; padding-bottom: 20px;">
			SEARCH LOCATION
			<input id="pac-input" class="controls" type="text" placeholder="Enter a location">
			<div id="map" style="width:420px; height:300px;"></div>
			</div>
			<div class="tripDate">
				<input type="text" id="storyTripDate" name="storyTripDate" readonly="readonly" placeholder="날짜" class="tripDate22"><p><p>
			</div>
			<div class="location">
				<input type="text" name="storyLocation" id="storyLocation" style="width: 250px;" placeholder="Enter the location" class="form-control">
			</div>
		</div>
	</div>
	<div>
	<hr>
	<div id="public">
	    <input id="radio-1" class="radio-custom" name="storyIsPublic" value="public" type="radio" checked>
	    <label for="radio-1" class="radio-custom-label">공개</label>
	    <input id="radio-2" class="radio-custom" name="storyIsPublic" value="private" type="radio">
	    <label for="radio-2" class="radio-custom-label">비공개</label>
	<input class="btn btn-common" type="submit" value="등록" style="width: 100px;margin-left: 350px; background: white;">
	</div>
	</div>
	</form>
	</div>
</div><br><br>
</body>
<script type="text/javascript" src="js/story/story.js"></script>
<link rel="stylesheet" href="css/story/story.css">
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAmXUJ7uh8JaGb0kNQGwPPOAUogVORYuj4&libraries=places&callback=initMap" async defer></script>
</html>