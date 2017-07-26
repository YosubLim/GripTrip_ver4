<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
   <html lang="en">
   <head>
       <meta charset="utf-8">
       <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <meta name="description" content="">
       <meta name="author" content="">
       <title>GripTrip | TravelMaker</title>
       <link href="css/bootstrap.min.css" rel="stylesheet">
       <link href="css/font-awesome.min.css" rel="stylesheet">
       <link href="css/lightbox.css" rel="stylesheet"> 
       <link href="css/animate.min.css" rel="stylesheet"> 
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


<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/jejugothic.css);

.col-sm-12, h1, h2 {
	font-family: 'Jeju Gothic';
}

.btn-common {
	background-color: white;
	width: 100%;
}

#profilePicture {
	width: 200px;
	height: 200px;
	-moz-border-radius: 100px;
	-webkit-border-radius: 100px;
	border-radius: 100px;
}

input[type="password"] {
	font: small-caption;
	font-size: 14px;
}

input[type="password"]::-webkit-input-placeholder {
  font-family: 'Jeju Gothic';
}

</style>

</head><!--/head-->
   <script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.js"></script>
   <script type="text/javascript">
				$(function() {
					var foundEmail = true;
					var foundNick = true;
					var repassMatch = false;
					var passwordLength = false;
					var nickLength = false;

					$('input[id=email]')
							.keyup(
									function() {
										// 이메일 중복 확인
										var userinput = $(this).val();

										$
												.ajax({
													url : "isEmailExist.do",
													data : "email=" + userinput,
													type : "post",

													success : function(result) {
														foundEmail = result.found;

														if (foundEmail == false) { // 이멜 사용 가능
															var str = $(
																	'#email')
																	.val();

															var at = "@";
															var dot = ".";
															var lat = str
																	.indexOf(at);
															var lstr = str.length;
															var ldot = str
																	.indexOf(dot);

															if (str.indexOf(at) == -1) { // 여기부터 이멜 형식 확인
																$(
																		'span#emailCheckResult')
																		.html(
																				'<font color=#FF5A5A>이메일 형식을 지켜주세요</font>');
																foundEmail = true;
																return false;
															} else if (str
																	.indexOf(at) == -1
																	|| str
																			.indexOf(at) == 0
																	|| str
																			.indexOf(at) == lstr) {
																$(
																		'span#emailCheckResult')
																		.html(
																				'<font color=#FF5A5A>이메일 형식을 지켜주세요</font>');
																foundEmail = true;
																return false;
															} else if (str
																	.indexOf(dot) == -1
																	|| str
																			.indexOf(dot) == 0
																	|| str
																			.indexOf(dot) == lstr) {
																$(
																		'span#emailCheckResult')
																		.html(
																				'<font color=#FF5A5A>이메일 형식을 지켜주세요</font>');
																foundEmail = true;
																return false;
															} else if (str
																	.indexOf(
																			at,
																			(lat + 1)) != -1) {
																$(
																		'span#emailCheckResult')
																		.html(
																				'<font color=#FF5A5A>이메일 형식을 지켜주세요</font>');
																foundEmail = true;
																return false;
															} else if (str
																	.substring(
																			lat - 1,
																			lat) == dot
																	|| str
																			.substring(
																					lat + 1,
																					lat + 2) == dot) {
																$(
																		'span#emailCheckResult')
																		.html(
																				'<font color=#FF5A5A>이메일 형식을 지켜주세요</font>');
																foundEmail = true;
																return false;
															} else if (str
																	.indexOf(
																			dot,
																			(lat + 2)) == -1) {
																$(
																		'span#emailCheckResult')
																		.html(
																				'<font color=#FF5A5A>이메일 형식을 지켜주세요</font>');
																foundEmail = true;
																return false;
															} else if (str
																	.indexOf(" ") != -1) {
																$(
																		'span#emailCheckResult')
																		.html(
																				'<font color=#FF5A5A>이메일 형식을 지켜주세요</font>');
																foundEmail = true;
																return false;
															} else {
																$(
																		'span#emailCheckResult')
																		.html(
																				'<font color=#00aeef>사용 가능한 이메일입니다</font>');
																foundEmail = false;
															}
															/* $('span#emailCheckResult').html('<font color=#00aeef>사용 가능한 이메일입니다</font>');   
															 foundEmail = false; */
														} else { // 이멜 사용 불가
															$(
																	'span#emailCheckResult')
																	.html(
																			'<font color=#FF5A5A>사용 불가능한 이메일입니다</font>');
															foundEmail = true;
															return;
														}
													} // success
												}); // ajax()
									}); // keyup()

					// 이메일 붙여넣기
					$("input[id=email]")
							.bind(
									'paste',
									function(e) {
										var userinput = $(this).val();

										$
												.ajax({
													url : "isEmailExist.do",
													data : "email=" + userinput,
													type : "post",

													success : function(result) {
														foundEmail = result.found;

														if (foundEmail == false) { // 이멜 사용 가능
															var str = $(
																	'#email')
																	.val();

															var at = "@";
															var dot = ".";
															var lat = str
																	.indexOf(at);
															var lstr = str.length;
															var ldot = str
																	.indexOf(dot);

															if (str.indexOf(at) == -1) { // 여기부터 이멜 형식 확인
																$(
																		'span#emailCheckResult')
																		.html(
																				'<font color=#FF5A5A>이메일 형식을 지켜주세요</font>');
																foundEmail = true;
																return false;
															} else if (str
																	.indexOf(at) == -1
																	|| str
																			.indexOf(at) == 0
																	|| str
																			.indexOf(at) == lstr) {
																$(
																		'span#emailCheckResult')
																		.html(
																				'<font color=#FF5A5A>이메일 형식을 지켜주세요</font>');
																foundEmail = true;
																return false;
															} else if (str
																	.indexOf(dot) == -1
																	|| str
																			.indexOf(dot) == 0
																	|| str
																			.indexOf(dot) == lstr) {
																$(
																		'span#emailCheckResult')
																		.html(
																				'<font color=#FF5A5A>이메일 형식을 지켜주세요</font>');
																foundEmail = true;
																return false;
															} else if (str
																	.indexOf(
																			at,
																			(lat + 1)) != -1) {
																$(
																		'span#emailCheckResult')
																		.html(
																				'<font color=#FF5A5A>이메일 형식을 지켜주세요</font>');
																foundEmail = true;
																return false;
															} else if (str
																	.substring(
																			lat - 1,
																			lat) == dot
																	|| str
																			.substring(
																					lat + 1,
																					lat + 2) == dot) {
																$(
																		'span#emailCheckResult')
																		.html(
																				'<font color=#FF5A5A>이메일 형식을 지켜주세요</font>');
																foundEmail = true;
																return false;
															} else if (str
																	.indexOf(
																			dot,
																			(lat + 2)) == -1) {
																$(
																		'span#emailCheckResult')
																		.html(
																				'<font color=#FF5A5A>이메일 형식을 지켜주세요</font>');
																foundEmail = true;
																return false;
															} else if (str
																	.indexOf(" ") != -1) {
																$(
																		'span#emailCheckResult')
																		.html(
																				'<font color=#FF5A5A>이메일 형식을 지켜주세요</font>');
																foundEmail = true;
																return false;
															} else {
																$(
																		'span#emailCheckResult')
																		.html(
																				'<font color=#00aeef>사용 가능한 이메일입니다</font>');
																foundEmail = false;
															}
															/* $('span#emailCheckResult').html('<font color=#00aeef>사용 가능한 이메일입니다</font>');   
															 foundEmail = false; */
														} else { // 이멜 사용 불가
															$(
																	'span#emailCheckResult')
																	.html(
																			'<font color=#FF5A5A>사용 불가능한 이메일입니다</font>');
															foundEmail = true;
															return;
														}
													} // success
												}); // ajax()
									});

					// 패스워드 길이 제한
					$('#password')
							.keyup(
									function() {
										var userinput = $(this).val();
										if (userinput.length < 5) {
											$('span#passCheckResult')
													.html(
															'<font color=#FF5A5A>패스워드는 5 ~ 10자로 작성해주세요</font>')
										} else if (userinput.length > 10) {
											$('span#passCheckResult')
													.html(
															'<font color=#FF5A5A>패스워드는 5 ~ 10자로 작성해주세요</font>')
										} else {
											$('span#passCheckResult')
													.html(
															'<font color=#00aeef>사용 가능한 패스워드입니다</font>')
											passwordLength = true;
										}

										var password = $('#password').val();
										var repassword = $('#repassword').val();
										if (repassword != password
												|| repassword == '') { // 비번 재확인이 비번과 다름
											$('span#repassCheckResult')
													.html(
															'<font color=#FF5A5A>패스워드와 일치하지 않습니다</font>');
										} else { // 비번 재확인과 비번 일치
											$('span#repassCheckResult')
													.html(
															'<font color=#00aeef>패스워드와 일치합니다</font>');
											repassMatch = true;
										}
									});

					// 닉네임 중복 확인
					$('input[id=nickname]')
							.keyup(
									function() {
										var userinput = $(this).val();

										if (userinput.length > 6) {
											nickLength = false;
											$('span#nickCheckResult')
													.html(
															'<font color=#FF5A5A>닉네임은 6자 이내로 작성해주세요</font>');
										} else {
											nickLength = true;
											$
													.ajax({
														url : "isNicknameExist.do",
														data : "nickname="
																+ userinput,
														type : "post",

														success : function(
																result) {
															foundNick = result.found;
															//alert(result.found);

															if (foundNick == false) { // 이멜 사용 가능
																$(
																		'span#nickCheckResult')
																		.html(
																				'<font color=#00aeef>사용 가능한 닉네임입니다</font>');

															} else { // 이멜 사용 불가
																$(
																		'span#nickCheckResult')
																		.html(
																				'<font color=#FF5A5A>사용 불가능한 닉네임입니다</font>');
																return;
															}
														} // success
													}); // ajax()
										}
									}); // keyup()

					// 패스워드 재확인
					$('#repassword')
							.keyup(
									function() {
										var password = $('#password').val();
										var repassword = $('#repassword').val();

										if (repassword != password
												|| repassword == '') { // 비번 재확인이 비번과 다름
											$('span#repassCheckResult')
													.html(
															'<font color=#FF5A5A>패스워드와 일치하지 않습니다</font>');
										} else { // 비번 재확인과 비번 일치
											$('span#repassCheckResult')
													.html(
															'<font color=#00aeef>패스워드와 일치합니다</font>');
											repassMatch = true;
										}
									}); // keyup()

					// 회원 등록 하려할 때(submit 눌렀을 때)
					$('#regFrm').submit(function() {
						if (foundEmail == true) {
							alert('이메일 중복 확인해 주세요');
							$('#email').val("");
							$('#eamil').focus();
							return false;
						} else if (foundNick == true) {
							alert('닉네임 중복 확인해 주세요');
							$('#nickname').val("");
							$('#nickname').focus();
							return false;
						} else if (repassMatch == false) {
							alert('패스워드 재확인 해주세요');
							$('#repassword').val("");
							$('#repassword').focus();
							return false;
						} else if (passwordLength == false) {
							alert('패스워드를 다시 설정해주세요.');
							$('#password').val("");
							$('#password').focus();
							return false;
						} else if (nickLength == false) {
							alert('닉네임을 다시 설정해주세요.');
							$('#nickname').val("");
							$('#nickname').focus();
							return false;
						} else {
							return true;
						}
					});
				}); // function()
				/* 7/11 */
				$(function() {
					$("#insertProfilePicture").on('change', function() {
						readURL(this);
					});//on
				});//function

				function readURL(input) {
					if (input.files && input.files[0]) {
						var reader = new FileReader();

						reader.onload = function(e) {
							$('#profilePicture').attr('src', e.target.result);
						}

						reader.readAsDataURL(input.files[0]);
					}//if
				}//readURL
			</script>
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

                    <a class="navbar-brand" href="index.jsp">
                       <h1><img src="images/griptrip_logo.png" alt="logo"
                       style="margin-right: 500px;"></h1>
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
                            <h1 class="title">회원가입</h1>
                            <p>GripTrip에 오신 것을 환영합니다. GripTrip의 가족이 되어 주세요.</p>
                        </div>
                     </div>
                </div>
            </div>
        </div>
   </section>
    <!--/#page-breadcrumb-->
    <!-- --------------------------------------------- [끝] 제목 Section --------------------------------------------- -->
   <!-- <form id="regFrm" name="contact-form" method="post" action="registerMember.do" enctype="multipart/form-data"> -->
    <section id="about-company" class="padding-top wow fadeInUp" data-wow-duration="400ms" data-wow-delay="400ms">
        <div class="container">
            <div class="row">    
                <div class="col-sm-12 text-center">
                <!-- 7/11 -->        
                    <img src="images/default-profile.png" id="profilePicture" class="margin-bottom">
                    <!-- <input type="file" name="uploadFile" id="insertProfilePicture"> -->
                
                    <h2>회원님의 프로필 사진을 등록해주세요!</h2>
                </div>
            </div>
        </div>
    </section>
    <!--/#about-company-->
   <br/>
   <br/>
   <div class="container">
      <div class="row">
         <div class="col-md-4 col-sm-12"></div>
         <div class="col-md-4 col-sm-12">
            <div class="contact-form bottom">
              <form id="regFrm" name="contact-form" method="post" action="registerMember.do" enctype="multipart/form-data">
                  <div class="form-group">
                     <input type="text" name="email" id="email" class="form-control" required="required" placeholder="이메일">
                     <span id="emailCheckResult"></span>
                  </div>
                  <div class="form-group">
                     <input type="password" name="password" id="password" class="form-control" required="required" placeholder="비밀번호">
                     <span id="passCheckResult"></span>
                  </div>
                  <div class="form-group">
                     <input type="password" name="repassword" id="repassword" class="form-control" required="required" placeholder="비밀번호 재확인">
                     <span id="repassCheckResult"></span>
                  </div>
                  <div class="form-group">
                     <input type="text" name="nickname" id="nickname" class="form-control" required="required" placeholder="닉네임">
                     <span id="nickCheckResult"></span>
                  </div>
                  
                  <div class="form-group">
                     <input type="file" name="uploadFile" id="insertProfilePicture" class="form-control">
                  </div>
                  
                  <div class="form-group">
                     <input type="text" name="username" id="username" class="form-control" required="required" placeholder="이름">
                  </div>
                  <div class="form-group">
                     <input type="text" name="address" id="address" class="form-control" required="required" placeholder="주소">
                  </div>
                  <div class="form-group">
                     <input type="submit" name="submit" class="btn btn-common" value="회원가입" >
                  </div>
               </form>
            </div>
         </div>
         <div class="col-md-4 col-sm-12"></div>
      </div>
   </div>
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
   <div class="col-md-12">
      <img src="images/home/footer.png" class="img-responsive inline" alt="" style="position: absolute; bottom: 0px; z-index: -1; min-width: 100%; margin-left: -13px; height: 600px;">
   </div>
   <!-- --------------------------------------------- [끝] Footer --------------------------------------------- -->

    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/lightbox.min.js"></script>
    <script type="text/javascript" src="js/wow.min.js"></script>
    <script type="text/javascript" src="js/jquery.countTo.js"></script>
    <script type="text/javascript" src="js/main.js"></script>   
   
</body>
</html>