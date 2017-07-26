<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GripTrip | TravelMaker</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.js"></script>
   <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/lightbox.css" rel="stylesheet"> 
    <link href="css/animate.min.css" rel="stylesheet"> 
   <link href="css/story/story2.css?ver=1" rel="stylesheet">
  <link href="css/responsive.css" rel="stylesheet">
   <link href="css/main.css" rel="stylesheet">
   <link rel="shortcut icon" href="images/ico/griptrip.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
     <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
   
   $(function() {
         $('#storyModal').on('shown.bs.modal',function(){
            google.maps.event.trigger(map,"resize");
            $(".pac-container").css("z-index", $("#storyModal").css("z-index"));
         })//on
      });//function
});
   function writeNewStory() {
      location.href="storyWrite.do?book_no=${book_no}";
   } 
   function writeStory() {
      location.href="storyWrite.do?book_no=${book_no}";
   }

   function deleteStory() {
      var delStoryNo = "";
      var storyChk = document.getElementsByName("deleteCheck");
      var indexid=false;
      for(i=0; i < storyChk.length; i++){
           if(storyChk[i].checked){ 
             delStoryNo += storyChk[i].value+"-";
             indexid=true;
            }   
        }
        if(!indexid){
            alert("삭제할 스토리를 체크해 주세요");
            return false;
         }
          if(confirm("선택한 스토리를 삭제하시겠습니까?")){
            location.href="deleteStory.do?storyNo="+delStoryNo+"&&book_no="+${book_no};
      }

   }
</script>
<style type="text/css">
   #bookBackground{
      background-image: url("${initParam.root}upload/${bookPicture}");
      background-size: cover;
      background-repeat: no-repeat;
      background-attachment: fixed;
   }
   
    .bookbackc{
        width: 100%;
        height: 100%;
       /*   background-color: rgba(0, 0, 0, 0.1);  */
       background-color: rgba(255, 255, 255, 0.4);  
   }
   
   @import url(http://fonts.googleapis.com/earlyaccess/jejugothic.css);
h1, h2, h5, #page-breadcrumb, #avatar, #bookBackground {
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
                            		<li><a href="showMemberInfo.do?email=${sessionScope.mvo.email}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;프로필</a></li>
                                	<li><a href="getOrderListOfMember.do">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;주문내역</a></li>
                                	<li><a href="getBookmarks.do?email=${sessionScope.mvo.email}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;북마크</a></li>
                                	<li><a id="logoutA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;로그아웃</a></li>
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
                     <h1 class="title">"${book.book_title}" 의 스토리들</h1>
                     <p>이 스토리북의 스토리들을 감상해보세요.</p>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </section>
   <!-- --------------------------------------------- [끝] 제목 Section --------------------------------------------- -->
<div id="bookBackground">
<div class="bookbackc">
<c:choose>
   <c:when test="${storyList=='[]'}">
   	<div style="background: white; height: 450px;" align="center">
   	<br><br><br><br>
   		<img src="images/no-story.png">
    <br><br>
    </div>
   </c:when>
   <c:otherwise>
      <c:choose>
      <c:when test="${sessionScope.mvo.email!=storyList[0].member.email}">
         <c:forEach items="${storyList}" var="storyList" varStatus="count">
         <c:if test="${storyList.storyIsPublic=='public'}">
         <section id="blog" class="padding-bottom ">
        <div class="container">
            <div class="row">
                <div class="timeline-blog overflow padding-top">
                    <div class="timeline-date text-center">
                        <a href="#" class="btn btn-common uppercase" style="font-family: 'Jeju Gothic';">${storyList.storyCreateDate}</a>
                    </div>
                    <c:choose>
                       <c:when test="${storyList.storyPictureUrl!=null}">
                          <div class="timeline-divider overflow padding-bottom">
                        <div class="col-sm-6 padding-left wow fadeInLeft" data-wow-duration="1000ms" data-wow-delay="300ms">
                            <div class="single-blog timeline" id="storyList">
                                <div class="post-content overflow">
                                   <div class="row">
                                      <div class="col-md-6" style="border-right: 1px solid #eeeeee;">
                                          <h2 class="post-title bold">
                                          <a href="showStory.do?storyNo=${storyList.storyNo}&&book_no=${book_no}"><b>${storyList.storyTitle}</b></a><br>
                                          </h2>
                                          <h5 class="post-author" style="font-family: 'Jeju Gothic';">${storyList.member.nickname}</h5>
                                          ${storyList.storyLocation}<p><p>
                                              <img src="upload/${storyList.storyPictureUrl}" width="320" height="250">
                                       </div>
                                     <div class="col-md-6">                                       
                                          <p class="storyContent">${storyList.storyContent}</p>
                                     </div>
                                   </div>
                                   <div class="post-bottom overflow">
                              <span class="post-date pull-left">${storyList.storyCreateDate}</span>
                              <span class="comments-number pull-right"><a href="#">${storyList.countComment} comments</a></span>
                           </div>                           
                                </div>
                            </div>
                        </div>
                    </div>
                       </c:when>
                       <c:otherwise>
                          <div class="timeline-divider overflow padding-bottom">
                        <div class="col-sm-6 padding-left wow fadeInLeft" data-wow-duration="1000ms" data-wow-delay="300ms">
                            <div class="single-blog timeline" id="storyList">
                                <div class="post-content overflow">
                                    <h2 class="post-title bold"><a href="showStory.do?storyNo=${storyList.storyNo}&&book_no=${book_no}"><b>${storyList.storyTitle}</b></a></h2>
                                    <h5 class="post-author" style="font-family: 'Jeju Gothic';">${storyList.member.nickname}</h5>
                                    <p>${storyList.storyContent}</p>
                                    <div class="post-bottom overflow">
                              <span class="post-date pull-left">${storyList.storyCreateDate}</span>
                              <span class="comments-number pull-right"><a href="#">${storyList.countComment} comments</a></span>
                           </div>
                                </div>
                            </div>
                        </div>
                    </div>
                       </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </section>
       </c:if>
      </c:forEach>
      </c:when>
      <c:otherwise>
         <center>
         <div class="padding-top">
         <img alt="" src="${initParam.root}images/add.png" width="100" height="100" data-toggle="modal" data-target="#storyModal">
         </div>
         </center>
         <c:forEach items="${storyList}" var="storyList" varStatus="count">
         <section id="blog" class="padding-bottom ">
        <div class="container">
            <div class="row">
                <div class="timeline-blog overflow padding-top">
                    <div class="timeline-date text-center">
                        <a href="#" class="btn btn-common uppercase" style="font-family: 'Jeju Gothic';">${storyList.storyCreateDate}</a>
                    </div>
                    <c:choose>
                       <c:when test="${storyList.storyPictureUrl!=null}">
                          <div class="timeline-divider overflow padding-bottom">
                        <div class="col-sm-6 padding-left wow fadeInLeft" data-wow-duration="1000ms" data-wow-delay="300ms">
                            <div class="single-blog timeline" id="storyList">
                                <div class="post-content overflow">
                                   <div class="row">
                                      <div class="col-md-6" style="border-right: 1px solid #eeeeee;">
                                          <h2 class="post-title bold">
                                          <a href="showStory.do?storyNo=${storyList.storyNo}&&book_no=${book_no}">${storyList.storyTitle}</a><br>
                                          </h2>
                                          
                                          <h5 class="post-author" style="font-family: 'Jeju Gothic';">${storyList.member.nickname}</h5>
                                          ${storyList.storyLocation}<p><p>
                                              <img src="upload/${storyList.storyPictureUrl}" width="320" height="250">
                                       </div>
                                       <div class="col-md-6">
                                        <span class="comments-number pull-right">
                                        <input type="checkbox" name="deleteCheck" value="${storyList.storyNo}">&nbsp;&nbsp;
                                        <a href="javascript:deleteStory()"><i class="fa fa-trash" aria-hidden="true"></i></a>&nbsp;&nbsp;
                                        <c:if test="${storyList.storyIsPublic=='private'}">
                                        <i class="fa fa-lock" aria-hidden="true"></i>
                                        </c:if>
                                        </span>                                 
                                          <p class="storyContent">${storyList.storyContent}</p>
                                       </div>
                                   </div>
                                   <div class="post-bottom overflow">
                              <span class="post-date pull-left">${storyList.storyCreateDate}</span>
                              <span class="comments-number pull-right"><a href="#">${storyList.countComment} comments</a></span>
                           </div>                           
                                </div>
                            </div>
                        </div>
                    </div>
                       </c:when>
                       <c:otherwise>
                          <div class="timeline-divider overflow padding-bottom">
                        <div class="col-sm-6 padding-left wow fadeInLeft" data-wow-duration="1000ms" data-wow-delay="300ms">
                            <div class="single-blog timeline" id="storyList">
                                <div class="post-content overflow">
                                <span class="comments-number pull-right">
                                    <input type="checkbox" name="deleteCheck" value="${storyList.storyNo}">&nbsp;&nbsp;
                                     <a href="javascript:deleteStory()"><i class="fa fa-trash" aria-hidden="true"></i></a>&nbsp;&nbsp;
                                     <c:if test="${storyList.storyIsPublic=='private'}">
                                     <i class="fa fa-lock" aria-hidden="true"></i>
                                     </c:if>
                                    </span>
                                    <h2 class="post-title bold"><a href="showStory.do?storyNo=${storyList.storyNo}&&book_no=${book_no}">${storyList.storyTitle}</a></h2>
                                    <h5 class="post-author" style="font-family: 'Jeju Gothic';">${storyList.member.nickname}</h5>
                                    <p>${storyList.storyContent}</p>
                                    <div class="post-bottom overflow">
                                        <span class="post-date pull-left">${storyList.storyCreateDate}</span>
                                        <span class="comments-number pull-right"><a href="#">${storyList.countComment} comments</a></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                       </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </section>
      </c:forEach>
      </c:otherwise>
   </c:choose>
   </c:otherwise>
</c:choose>


<!-- -------------------- Stroy Write Modal ------------------------------- -->
<div class="modal fade" id="storyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content modal-lg">
      <div class="modal-header" style="background-color: #555; color: #fff;">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Story 작성</h4>
      </div>
      <div class="modal-body">
         <jsp:include page="storyWrite.jsp"></jsp:include>
      </div>
      <!-- <div class="modal-footer"></div> -->
    </div>
  </div>
</div>
</div>
</div>
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
                     <p id="avatar">
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
   <!-- --------------------------------------------- [끝] Footer --------------------------------------------- -->

   <!-- <script type="text/javascript" src="js/jquery.js"></script> -->
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