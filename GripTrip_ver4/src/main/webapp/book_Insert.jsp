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
			
			//제목 미리보기			
			$('input[name=book_title]').keyup(function() {
				var book_title = $('input[name=book_title]').val();
				
				$.ajax({
					type : "get",
					url : "previewTitle.do",
					data : "book_title="+ book_title,
			
					success : function(data) {
						//alert(data);
				        $('#insert_book_title').html(data.book_title);
					} //callback
				}); //ajax
			});//keyup
			
			//표지 미리보기 			
			$(function() {
		    	$("#insert_book_picture_inp").on('change', function(){
		            readURL(this);
		   		});//on
		   	});//function
				
			/* 표지 미리보기 */
		    function readURL(input) {
		    	if (input.files && input.files[0]) {
		    		var reader = new FileReader();

		    		reader.onload = function (e) {
		   				$('#insertBookPicture').attr('src', e.target.result);
		        	}

		            reader.readAsDataURL(input.files[0]);
		        }//if
		   	}//readURL
			
		   	$('#insert-book-button').click(function() {
		   		$(location).attr('href', 'returnToMyBookList.do');
			});//click
			
		});//function
		
</script>

<style type="text/css">

@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);

@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);

@import url(http://fonts.googleapis.com/earlyaccess/jejumyeongjo.css);

@import url(http://fonts.googleapis.com/earlyaccess/jejugothic.css);

@import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);

@import url(http://fonts.googleapis.com/earlyaccess/jejugothic.css);

.col-sm-12, h1, h2, #warning, p {
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
	

.insert-book {
	display: inline-block;
	box-shadow: 5px 5px 20px #333;
	margin: 10px;
	position: relative;
}

.insert-book-title {
	position: absolute;
	width: 100%;
	min-height: 25%;
	top: 0px;
	background-color: #949596;
	opacity: 0.5;
	font-size: 25px;
	/* font-size: 30px; 나눔손글씨*/
}

.insert-book-title p {
	margin-top: 10px;
	margin-left: 30px;
	margin-right: 30px;
	margin-buttom: 10px;
	line-height: 120%;
	/* font-family: 'Noto Sans KR', sans-serif; */
	/* font-family: 'Jeju Myeongjo', serif; */
	font-family: 'Jeju Gothic', serif;
	/* font-family: 'Nanum Pen Script', serif; */
	/* font-family: 'Nanum Gothic', serif; */
	opacity: 1;
	color: #000000;
	z-index: 100;
}

.insert-book img {
	vertical-align: middle;
	width: 297px;
	height: 420px;
	object-fit: cover;
	/* border: 0.5px solid #5a2d18; */
}

.insert-book:after{
	content: '';
	position: absolute;
	top: 0;
	left: 1.5rem;
	bottom: 0;
	width: .2rem;
	background: rgba(0, 0, 0, .06);
	box-shadow: 1px 0 3px rgba(255, 255, 255, .1);
}

/* 공개 비공개 */
.insert-book-public {
  /* position: absolute; */
  top: 50%;
  left: 0;
  right: 0;
  /* text-align: center; */
  /* padding: 1em; */
  /* padding-left: 30px; */
  -webkit-transform: translateY(-50%);
          transform: translateY(-50%);
  font-family: 'Gloria Hallelujah';
  color: rgba(0, 0, 66, 0.8);
  font-size: 130%;
  line-height: 1.9;
  -webkit-user-select: none;
     -moz-user-select: none;
      -ms-user-select: none;
          user-select: none;
}

input[name=book_is_public] {
  display: none;
}
input[name=book_is_public] + span {
  display: inline-block;
  position: relative;
  white-space: nowrap;
  color: rgba(0, 0, 66, 0.4);
  -webkit-transition: color 300ms ease-in;
  transition: color 300ms ease-in;
  cursor: pointer;
}
input[name=book_is_public] + span::after {
  position: absolute;
  display: block;
  content: '';
  top: 65%;
  left: -5%;
  width: 110%;
  height: .1em;
  border-radius: .05em;
  background-color: rgba(150, 0, 0, 0.8);
  -webkit-transform-origin: 0% 0%;
          transform-origin: 0% 0%;
  -webkit-transform: rotateZ(-6deg);
          transform: rotateZ(-6deg);
  opacity: 1;
  -webkit-transition: width 300ms ease-in;
  transition: width 300ms ease-in;
}
input[name=book_is_public]:checked + span {
  color: rgba(0, 0, 66, 0.8);
  cursor: default;
}
input[name=book_is_public]:checked + span::after {
  width: 0%;
  opacity: 0;
  -webkit-transition: opacity 150ms ease-out, width 0ms linear 200ms;
  transition: opacity 150ms ease-out, width 0ms linear 200ms;
}



/* 전체 폼 */
.book-insert {
  z-index: 100;
  width: 50%;
  min-width: 100%;
  /* height: 100%;
  min-height: 100%; */
  background: 0 0 #ffffff;
  border-radius: 8px;
  border: 1px solid #dedede;
  margin: 15px 0 0 0;
  display: block;
}

.book-insert-info {
  
  padding: 15px;
  text-align: center;
  background: #EEF2F4;
  color: #5D6F78;
  font-size: 13px;
  font-weight: 300;
  border-bottom: 1px solid #DEDEDE;
  border-top-left-radius: 8px;
  border-top-right-radius: 8px;
}




</style>

</head>
<body>
	<!-- --------------------------------------------- [시작] Header --------------------------------------------- -->
	<c:choose>
		<c:when test="${sessionScope.mvo == null}">
			<header id="header">
				<div class="navbar navbar-inverse" role="banner">
					<div class="container">
						<div class="navbar-header">
							<button type="button" class="navbar-toggle"
								data-toggle="collapse" data-target=".navbar-collapse">
								<span class="sr-only">Toggle navigation</span> <span
									class="icon-bar"></span> <span class="icon-bar"></span> <span
									class="icon-bar"></span>
							</button>

							<a class="navbar-brand" href="index.jsp">
								<h1>
									<img src="images/griptrip_logo.png" alt="logo"
										style="margin-right: 500px;">
								</h1>
							</a>

						</div>
						<div class="collapse navbar-collapse">
							<ul class="nav navbar-nav navbar-right">
								<li class="active"><a href="index.jsp">Home</a></li>
								<li class="dropdown"><a href="getAllList.do">스토리북 구경</a></li>
							</ul>
						</div>
					</div>
				</div>
			</header>
		</c:when>
		<c:otherwise>
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
                            <h1 class="title">스토리북 작성</h1>
                            <p>회원님의 여행을 스토리북으로 등록해보세요.</p>
                        </div>
                     </div>
                </div>
            </div>
        </div>
   </section>
   <!-- --------------------------------------------- [끝] 제목 Section --------------------------------------------- -->
	<p><br><br><br><br>
	
	<div class="container">
		<div class="col-md-12">
			<div class="row">
				
				<div class="col-md-2"></div>
				
				<div class="col-md-4" align="center"  style="display: inline;">	
					<div class="insert-books">
						<span class="insert-book">
							<img class="insertBookPicture" id="insertBookPicture" src="" />
							<div class="insert-book-title">
								<p id="insert_book_title" style="text-align: left;">제목을 지어주세요</p>
							</div>
						</span>
					</div>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;
				</div>
								
				<div class="col-md-4" align="center" style="display: inline; padding:0 35px 0 35px; margin-left: 40px;">
					
					<div class="book-insert">
						<div class="book-insert-info">
							<h4><b>스토리북 작성</b></h4>
						</div>
						<form action="insertWriteBook.do" id="inserWriteBookFrm" method="post" enctype="multipart/form-data">
							
							<div class="input-group" id="inserWriteBookInput" style="margin: 25px 8px 25px 8px;">
									               					               				
	               				<span class="input-group-addon">제목</span>
	               				<input type="text" class="form-control" placeholder="제목을 지으세요" name="book_title" required="required" >
	         				</div>
	         				
							<div class="input-group" id="inserWriteBookInput" style="margin: 25px 8px 5px 8px;">
								
								<span class="input-group-addon">표지</span>
								
								<input type="file" class="form-control" id="insert_book_picture_inp" name="uploadFile" required="required" 
								/>
								
							</div>
							<div id="warning" style="margin: -7px 125px 5px 0;">
								<h6>* PNG | GIF | JPEG 파일만 가능</h6>
							</div>
							<br>			

							<div class="insert-book-public">	
 								<label style="display: inline;">스토리를</label>
  								<label for="public"><input type="radio" name="book_is_public" id="public" value="public" checked><span>공개</span></label>
 								<label for="private"><input type="radio" name="book_is_public" id="private" value="private"><span>비공개</span></label> 
								<label style="display: inline;">합니다</label>
							</div>
								         				
							<div style="border: 2px solid #E1E1E1;"></div>
							<br>
							<div class="input-group" style="display: inline-block; margin-bottom: 20px;">
								<input type="submit" class="btn btn-common" value="등록"
									style="width: 80px; height: 50px; margin-right: 2px; background: #fff;">
															
								<input type="button" class="btn btn-common" id="insert-book-button" value="취소"
								style="width: 80px; height: 50px; margin-left: 2px; background: #fff;">
							</div>
						</form>
						</div>
						
					</div>
				<div class="col-md-2"></div>
				</div>
		</div>
	</div>
		
	<p><br><br><br><br>
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