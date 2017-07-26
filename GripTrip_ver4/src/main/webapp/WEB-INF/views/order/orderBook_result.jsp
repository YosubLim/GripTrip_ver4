<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<link rel="apple-touch-icon-precomposed" sizes="144x144"
	href="images/ico/apple-touch-icon-144-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114"
	href="images/ico/apple-touch-icon-114-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72"
	href="images/ico/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed"
	href="images/ico/apple-touch-icon-57-precomposed.png">

<script type="text/javascript"
	src="http://code.jquery.com/jquery-3.2.1.js"></script>
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
			
			if(${p} == false){
				alert('비번이 일치하지 않으니 다시 입력하렴');
				$('#password').val('');
				$('#password').focus();
			}
			$('#checkPassForRemoveFrm').submit(function() {
				if(confirm("정말 탈퇴하시겠습니까?")) return true;
				else return false;
			});//submit
		});//function
	</script>

<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/jejugothic.css);

.col-sm-12, h1, h2, h5, p {
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
	

.order-book-result {
	max-width: 100%;
	background-color: transparent;
	border-collapse: collapse;
	border-spacing: 0;
	width: 100%;
	margin-bottom: 20px;
}

.order-book-result thead th, .order-book-result tbody td {
	padding: 10px 10px;
	line-height: 100%;
	text-align: center;
	vertical-align: middle;
	border-top: 1px solid #dddddd;
	border-bottom: 1px solid #dddddd;
}

.order-book-result tbody td {
	font-size: 13px;
}

.order-book-result thead th {
	background: #eeeeee;
	vertical-align: bottom;
	font-size: 13px;
}
#startTable {
	border-top: 2px solid #dddddd;
}


/* 북사진 */
.order-book-picture {
	display: inline-block;
	box-shadow: 5px 5px 20px #333;
	margin: 10px;
	position: relative;
}

.order-book-picture-title {
	position: absolute;
	width: 100%;
	min-height: 25%;
	top: 0px;
	background-color: #949596;
	opacity: 0.5;
	font-size: 12px;
	/* font-size: 30px; 나눔손글씨*/
}

.order-book-picture-title p {
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

.order-book-picture img {
	vertical-align: middle;
	width: 170px;
	height: 220px;
	object-fit: cover;
	/* border: 0.5px solid #5a2d18; */
}

.order-book-picture:after {
	content: '';
	position: absolute;
	top: 0;
	left: 1.5rem;
	bottom: 0;
	width: .2rem;
	background: rgba(0, 0, 0, .06);
	box-shadow: 1px 0 3px rgba(255, 255, 255, .1);
}

.order-book-picture {
	display: inline-block;
	box-shadow: 3px 3px 10px #333;
	margin: 5px;
	position: relative;
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
							<h1 class="title">결제 완료</h1>
							<p>주문 결과입니다.</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- --------------------------------------------- [끝] 제목 Section --------------------------------------------- -->
	<br>
	<section>
		<div class="container">
			<div class="col-md-1"></div>
			<div class="col-md-10">
				<div class="row">
					<div style="margin-left: 3.5em;">
						<h5><strong style="color: ">${sessionScope.mvo.username}</strong>님의 결제가 정상적으로 완료되었습니다.</h5>
					</div>

					<div id="startTable" align="center">
						<br>
						<div>
							<span class="order-book-picture"> <img
								class="updateBookPicture" id="order-book-picture-title"
								src="upload/${rvo.book.book_picture_url}" />
								<div class="order-book-picture-title">
									<p id="order-book-picture-title" style="text-align: left;">${rvo.book.book_title }</p>
								</div>
							</span>
						</div>
						<br>
						<div>
							<table class="order-book-result">
								<colgroup>
									<col width="*" />
									<col width="*" />
									<col width="*" />
									<col width="*" />
									<col width="*" />
									<col width="*" />
								</colgroup>
								<thead >
									<tr >
										<th>주문번호</th>
										<th>주문일</th>
										<th>제목</th>
										<th>수량</th>
										<th>합계</th>
										<th>주문상태</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>${rvo.orderNo }</td>
									
										<td>${rvo.orderCreateDate }</td>
									
										<td>${rvo.book.book_title }</td>
									
										<td>${rvo.quantity}</td>
									
										<td>${rvo.totalPrice}원</td>
										
										<td style="color: red;">결제완료</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-1"></div>
		</div>
	</section>



	<br />
	<br />
	<br />
	<br />
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



