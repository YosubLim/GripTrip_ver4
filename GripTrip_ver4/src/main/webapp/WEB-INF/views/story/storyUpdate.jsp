<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>GripTrip | TravelMaker</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet"> 
    <link href="css/lightbox.css" rel="stylesheet"> 
   <link href="css/main.css" rel="stylesheet">
   <link href="css/responsive.css" rel="stylesheet">

    <!--[if lt IE 9]>
       <script src="js/html5shiv.js"></script>
       <script src="js/respond.min.js"></script>
    <![endif]-->       
    <link rel="shortcut icon" href="images/ico/griptrip.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">
    
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAmXUJ7uh8JaGb0kNQGwPPOAUogVORYuj4&libraries=places&callback=initMap" async defer></script>
   <script type="text/javascript" src="js/story/story.js"></script>
   <link rel="stylesheet" href="css/story/story.css">
   <link rel="stylesheet" href="css/story/style.css">
    
    <!-- Book 이미지 hover -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    
    <script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.js"></script>
<script type="text/javascript">
$(function(){
    // 로그아웃 버튼 클릭 시 confirm
     $('#logoutA').click(function(){
        if(confirm("로그아웃 하시겠습니까?")){
             alert("로그아웃되었습니다.")
             location.href="logout.do";
          }else{
             return;
          }
     });
});
var xhr;
function startRequest() {
	xhr = new XMLHttpRequest();
	xhr.onreadystatechange = callback;
	xhr.open("get","fileDelete.do?storyPictureUrl=${story.storyPictureUrl}&&storyNo=${story.storyNo}");
	xhr.send(null);
}

function callback() {
	if(xhr.readyState==4){
		if(xhr.status==200){
			document.getElementById("showUpdate").innerHTML =
				"<input type='file' name='uploadFile'><BR>"
		}
	}
}
</script>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/jejugothic.css);
h1, h2, #page-breadcrumb,  #avatar, .storyupdate {
	font-family: 'Jeju Gothic';
}
.profile-img {
		/* margin-top: 8px; */
		margin: 5px;
	}
	.profile-img img {
		width: 45px;
		height: 45px;
		max-width: 45px;
		max-height: 45px;
		border-radius: 50%;
		padding: 4px;
		box-shadow: 0px 0px 10px rgba(21, 21, 21, 0.15);
	}
</style>
</head>
<body>
<!-- --------------------------------------------- [시작] Header --------------------------------------------- -->
	<c:choose>
		<c:when test="${sessionScope.mvo != null}">
			<header id="header">      
	        <div class="navbar navbar-inverse" role="banner">
	            <div class="container">
	                <div class="navbar-header">
	                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
	                        <span class="sr-only">Toggle navigation</span>
	                        <span class="icon-bar"></span>
	                        <span class="icon-bar"></span>
	                        <span class="icon-bar"></span>
	                    </button>
	
	                    <a class="navbar-brand" href="getMyBookList.do">
	                    	<h1><img src="images/griptrip_logo.png" alt="logo"></h1>
	                    </a>
	                    
	                </div>
	                <div class="collapse navbar-collapse">
	                    <ul class="nav navbar-nav navbar-right">
	                        
	                        <li class="active"><a href="getMyBookList.do">Home</a></li>
	                        <li class="dropdown"><a href="getOtherBookList.do">스토리북 구경</a></li>
	                        
	                        <li class="dropdown">
	                        	<a href="">${sessionScope.mvo.nickname} <i class="fa fa-angle-down"></i></a>
                            	<ul role="menu" class="sub-menu">
                            		<li><a href="showMemberInfo.do?email=${sessionScope.mvo.email}">프로필</a></li>
                                	<li><a href="getOrderListOfMember.do">주문내역</a></li>
                                	<li><a href="getBookmarks.do?email=${sessionScope.mvo.email}">북마크</a></li>
                                	<li><a id="logoutA">로그아웃</a></li>
                            	</ul>
                            </li>
                            <li>
	                        <figure class="profile-img">
										<c:choose>
											<c:when test="${sessionScope.mvo.memberPictureUrl!=null}">
												<img src="upload/${sessionScope.mvo.memberPictureUrl}" class="margin-bottom" id="profilePicture">
											</c:when>
											<c:otherwise>
												<img src="images/default-profile.png" class="margin-bottom" id="profilePicture">
											</c:otherwise>
										</c:choose>
									</figure>
  							</li>
	                    </ul>
	                </div>
	            </div>
	        </div>
	    </header>
		</c:when>
		<c:otherwise>
		</c:otherwise>
	</c:choose>
	<!-- --------------------------------------------- [끝] Header --------------------------------------------- -->
<!-- --------------------------------------------- [시작] 제목 Section --------------------------------------------- -->
   <section id="page-breadcrumb">
      <div class="vertical-center sun">
         <div class="container">
            <div class="row">
               <div class="action">
                  <div class="col-sm-12">
                     <h1 class="title">스토리 수정하기</h1>
                     <p>스토리를 수정할 수 있습니다.</p>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </section>
   <!-- --------------------------------------------- [끝] 제목 Section --------------------------------------------- -->
   
   <br><br>
   
      <div class="storyupdate" style="margin-left: 200px; margin-right: 200px; border: 2px solid #EEEEEE; box-shadow: 4px 4px 3px #EEEEEE; height: 580px;">         
         <div class="form-group" style="float:left; width: 33%; margin:30px;">
            <form action="updateStory.do" name="storyFrm" method="post" enctype="multipart/form-data">
            <input type="hidden" name="storyNo" value="${story.storyNo}">
            <input type="hidden" name="book_no" value="${book_no}">
            
            제목 <input class="form-control" type="text" name="storyTitle" required="required" value="${story.storyTitle}" style="width: 398px;"><br>
            <span id="showUpdate">
            <c:choose>
               <c:when test="${story.storyPictureUrl!=null}">
                  사진 : ${story.storyPictureUrl}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:startRequest()"><input type="button" value="파일 삭제" ></a><br><br>
                  <input class="form-control" type="hidden" name="storyPictureUrl" value="${story.storyPictureUrl}">
               </c:when>
               <c:otherwise>
                  <input class="form-control" type="file" name="uploadFile"><p>
               </c:otherwise>
            </c:choose>
            </span><br>
            내용 <textarea  class="form-control" rows="20" cols="30" name="storyContent" style="height: 180px; width: 400px">${story.storyContent}</textarea><br>                                      
            
            장소 <input class="form-control" type="text" name="storyLocation" value="${story.storyLocation}" style="width: 398px;"><br>
            
            <c:if test="${story.storyIsPublic=='public'}">
            	<input id="radio-1" class="radio-custom" name="storyIsPublic" value="public" type="radio" checked>
            	<label for="radio-1" class="radio-custom-label">공개</label>
            	<input id="radio-2" class="radio-custom" name="storyIsPublic" value="private" type="radio">
            	<label for="radio-2" class="radio-custom-label">비공개</label>
            </c:if>
            <c:if test="${story.storyIsPublic=='private'}">
            	<input id="radio-1" class="radio-custom" name="storyIsPublic" value="public" type="radio">
            	<label for="radio-1" class="radio-custom-label">공개</label>
            	<input id="radio-2" class="radio-custom" name="storyIsPublic" value="private" type="radio" checked>
            	<label for="radio-2" class="radio-custom-label">비공개</label>
            </c:if>
            <br><br><br><br><br>
            <input type="submit" class="btn btn-common" style="width: 70%; margin-left: 320px; background: white;" id="updateBtn" value="수정">
         </div>
         
         <div id="mapLayout" style="float:left; width: 33%; margin-top:30px; margin-left: 115px;">
            SEARCH LOCATION
            <input id="pac-input" class="controls" type="text" placeholder="Enter a location">
            <div id="map" style="width:420px; height:450px;">
            </div><br><br>
         </div>
      </div>
   
   <br/>
   <br/>
   <br/>
   <br/>
   <br/>
   <br/>
   <br/>
   <br/>
<!-- --------------------------------------------- [시작] Footer --------------------------------------------- -->

   <footer id="footer" style="width: 100%;">
      <div class="container" style="border-top: 3px solid #ffcccc;">
         <div class="row">
            <!-- <div class="col-md-1"></div> -->
            <div class="col-md-6" style="text-align: right;padding-top: 20px;padding-right: 30px;">
                  <h2>
                     Project <b>GripTrip</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     Team <b>TravelMaker</b>
                  </h2>
            </div>
            <!-- <div class="col-md-1"></div> -->
            <div class="col-md-6" style="text-align: left;">
               <br />
               <div class="contact-info bottom">
                  
                  <div style="text-align: left;">
                     <img src="images/avatar-ahn.png" width="50px" height="50px" class="img-circle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                     <img src="images/avatar-yo.png" width="50px" height="50px" class="img-circle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                     <img src="images/avatar-hyun.png" width="50px" height="50px" class="img-circle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                     <img src="images/avatar-dong.png" width="50px" height="50px" class="img-circle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                     <img src="images/avatar-seo.png" width="50px" height="50px" class="img-circle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                     <img src="images/avatar-ha.png" width="50px" height="50px" class="img-circle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                     <img src="images/avatar-woo.png" width="50px" height="50px" class="img-circle">
                     <br/>
                     <p>
                     안득호&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     임요섭&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     이태현&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     이동근&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     조서윤&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     서하람&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     김우정
            		 </p>
                  </div>
               </div>
            </div>
         </div>
         <div class="row">
            <!-- <div class="col-md-2"></div> -->
            <div class="col-md-12" style="text-align: center;">
               <div class="contact-info bottom"  style="color: white;">
                  <h3><b>Contact Info</b></h3>
                  <!-- <h3>Address</h3> -->
                     E-mail: <a>annualring4@gmail.com</a> Phone: 010-4112-9040<br />
                     670, Daewangpangyo-ro, Bundang-gu, Seongnam-si, Gyeonggi-do, Republic of Korea
               </div>
            </div>
            <!-- <div class="col-md-6">
               <div class="contact-info bottom">
                  <h3>Address</h3>
                     670, Daewangpangyo-ro, Bundang-gu, Seongnam-si, Gyeonggi-do, Republic of Korea
               </div>
            </div> -->
         </div>
         <!-- <div class="row" style="height: 10px;"></div> -->
      </div>
   </footer>
   <!--/#footer-->
   <!-- --------------------------------------------- [끝] Footer --------------------------------------------- -->

   <script type="text/javascript" src="js/jquery.js"></script>
   <script type="text/javascript" src="js/bootstrap.min.js"></script>
   <script type="text/javascript" src="js/lightbox.min.js"></script>
   <script type="text/javascript" src="js/wow.min.js"></script>
   <script type="text/javascript" src="js/jquery.countTo.js"></script>
   <script type="text/javascript" src="js/main.js"></script>
   
   <div class="col-md-12">
         <img src="images/home/footer.png" class="img-responsive inline" alt="" style="position: absolute; bottom: 0px; z-index: -1; min-width: 100%; margin-left: -13px; height: 600px;">
   </div>
</body>
</html>