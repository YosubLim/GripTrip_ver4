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

.col-sm-12, h1, h2, p {
	font-family: 'Jeju Gothic';
}
#profilePicture {
	width: 200px;
	height: 200px;
	-moz-border-radius: 100px;
	-webkit-border-radius: 100px;
	border-radius: 100px;
}

 /* 7/15 */
      
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
   input[type="password"] {
   font:small-caption;
   font-size:16px
   }
</style>
</head>
<!--/head-->
<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.js"></script>
<script type="text/javascript">
   $(function() {
      // 로그아웃 버튼 클릭 시 confirm
      $('#logoutA').click(function() {
         if (confirm("로그아웃 하시겠습니까?")) {
            alert("로그아웃되었습니다.")
            location.href = "logout.do";
             } else {
                return;
             }
       });

      /* -------------------------------------------------------------------------------------------------------------- */
         
      var foundNick = false;
      var repassMatch = true;
      var passwordLength = false;
      var nickLength = true;
         
         $('#repassword-group').hide();
         
         // 패스워드 길이 제한
        $('#password').keyup(function(){
           $('#repassword-group').show();
           repassMatch = false;
           
          var userinput = $(this).val();
           if(userinput.length < 5){
              $('span#passCheckResult').html('<font color=#FF5A5A>패스워드는 5 ~ 10자로 작성해주세요</font>')
              passwordLength = false
           }else if(userinput.length > 10){
              $('span#passCheckResult').html('<font color=#FF5A5A>패스워드는 5 ~ 10자로 작성해주세요</font>')
              passwordLength = false
           }else{
              $('span#passCheckResult').html('<font color=#00aeef>사용 가능한 패스워드입니다</font>')
              passwordLength = true;
           }
           
           var password = $('#password').val();
            var repassword = $('#repassword').val();
           if(repassword != password || repassword == ''){ // 비번 재확인이 비번과 다름
                $('span#repassCheckResult').html('<font color=#FF5A5A>패스워드와 일치하지 않습니다</font>');
                repassMatch = false;
             }else{ // 비번 재확인과 비번 일치
                $('span#repassCheckResult').html('<font color=#00aeef>패스워드와 일치합니다</font>');
                repassMatch = true;
          }
        });
         
        $('#repassword').keyup(function(){
           var password = $('#password').val();
            var repassword = $('#repassword').val();
            if(repassword != password || repassword == ''){ // 비번 재확인이 비번과 다름
                 $('span#repassCheckResult').html('<font color=#FF5A5A>패스워드와 일치하지 않습니다</font>');
                 repassMatch = false;
              }else{ // 비번 재확인과 비번 일치
                 $('span#repassCheckResult').html('<font color=#00aeef>패스워드와 일치합니다</font>');
                 repassMatch = true;
             }
         });
         
         // 닉네임 중복 확인
         $('input[id=nickname]').keyup(function(){
           foundNick = true;
            
            var userinput = $(this).val();
            if ($('#nickname').val() != '${mvo.nickname}'){
               nickLength = false;
               if(userinput.length > 6){
                  nickLength = false;
                  $('span#nickCheckResult').html('<font color=#FF5A5A>닉네임은 6자 이내로 작성해주세요</font>');
               }else{
                  nickLength = true;
                  $.ajax({
                     url: "isNicknameExist.do",
                     data: "nickname="+userinput,
                     type: "post",
                     
                     success: function(result){
                        foundNick = result.found;
                        //alert(result.found);
                        
                        if(foundNick == false){   // 닉네임 사용 가능
                           $('span#nickCheckResult').html('<font color=#00aeef>사용 가능한 닉네임입니다</font>');
                           foundNick = false;
                           
                        }else{   // 닉네임 사용 불가
                           $('span#nickCheckResult').html('<font color=#FF5A5A>사용 불가능한 닉네임입니다</font>');
                           foundNick = true;
                           return;
                        }
                     } // success
                  }); // ajax()
               }
            }else{
                $('span#nickCheckResult').html('');
                foundNick = false;
             }
        }); // keyup()
         
        // 패스워드 재확인
         $('#repassword').keyup(function(){
            var password = $('#password').val();
            var repassword = $('#repassword').val();
            
            if(repassword != password || repassword == ''){ // 비번 재확인이 비번과 다름
               $('span#repassCheckResult').html('<font color=#FF5A5A>패스워드와 일치하지 않습니다</font>');
            }else{ // 비번 재확인과 비번 일치
               $('span#repassCheckResult').html('<font color=#00aeef>패스워드와 일치합니다</font>');
               repassMatch = true;
            }
         }); // keyup()
        
         /* -------------------------------------------------------------------------------------------------------------- */

      
      /* 7/11 */

      $("#insertProfilePicture").on('change', function(){
         readURL(this);
      });//on
      
      // 7/12
      var isChange = false;
       $("input[type=text]").change(function() {
            isChange = true;
         });
       $("input[type=password]").change(function() {
          isChange = true;
        });
         $("input[type=file]").change(function() {
           isChange = true;
         });
   
         $(window).on("beforeunload", function() {
           if (isChange) {
                return "이 페이지를 벗어나면 작성된 내용은 저장되지 않습니다";
            }
        });

         // 회원 등록 하려할 때(submit 눌렀을 때)
        $('#updateFrm').submit(function() {
           if (isChange == false) {
              return true;
           }else{
              isChange = false;
              if(foundNick == true){
                  alert('닉네임 중복 확인해 주세요');
                   $('#nickname').val("");
                   $('#nickname').focus();
                    return false;
               }else if(repassMatch == false){
                   alert('패스워드 재확인 해주세요');
                  $('#repassword').val("");
                    $('#repassword').focus();
                   return false;
                }else if(passwordLength == false){
                   alert('패스워드를 다시 설정해주세요.');
                    $('#password').val("");
                    $('#password').focus();
                   return false;
             }else if(nickLength == false){
                  alert('닉네임을 다시 설정해주세요.');
                    $('#nickname').val("");
                   $('#nickname').focus();
                  return false;
               }else{
                  return true;
              }
           }
         });

        //update 취소버튼
        $('#updateProfileBtn').click(function() {
            location.href = "showMemberInfo.do?email=${sessionScope.mvo.email}";
        });


 
       $("#updateProfilePicture").on('change', function() {
            readURL(this);
         });//on
   }); // function()

      function readURL(input) {
         if (input.files && input.files[0]) {
            var reader = new FileReader();
   
            reader.onload = function(e) {
               $('#profilePicture').attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
         }//if
      }//readURL
      
      var xhr;
      function startRequest() {
         xhr = new XMLHttpRequest();
         xhr.onreadystatechange = callback;
         xhr.open("get","memberFileDelete.do?memberPictureUrl=${mvo.memberPictureUrl}&&email=${mvo.email}");
         xhr.send(null);
      }
   
      function callback() {
         if(xhr.readyState==4){
            if(xhr.status==200){
               document.getElementById("showUpdate").innerHTML =
                  "<input type='file' name='uploadFile' id='updateProfilePicture' class='form-control'><BR>"
            }
         }
      }
   
      // 7/11
      function readURL(input) {
         if (input.files && input.files[0]) {
            var reader = new FileReader();
   
            reader.onload = function (e) {
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
							<h1 class="title">프로필 수정</h1>
							<p>회원님의 개인 정보를 수정하십시오.</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--/#page-breadcrumb-->
	<!-- --------------------------------------------- [끝] 제목 Section --------------------------------------------- -->
	<form id="updateFrm" name="contact-form" method="post" action="updateMember.do" enctype="multipart/form-data">
		<section id="about-company" class="padding-top wow fadeInUp" data-wow-duration="400ms" data-wow-delay="400ms">
			<div class="container">
				<div class="row">
					<div class="col-sm-12 text-center">
						<!-- 7/11 -->
						<c:choose>
							<c:when test="${mvo.memberPictureUrl!=null}">
								<img src="upload/${mvo.memberPictureUrl}" class="margin-bottom" id="profilePicture">
							</c:when>
							<c:otherwise>
								<img src="images/default-profile.png" class="margin-bottom" id="profilePicture">
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</section>
		<!--/#about-company-->
		<div class="container">
			<div class="row">
				<div class="col-md-4 col-sm-12"></div>
				<div class="col-md-4 col-sm-12">
					<div class="contact-form bottom">
						<div class="form-group">
							<label for="email">EMAIL</label>
							<input type="text" name="email" id="email" class="form-control" placeholder="${mvo.email}" value="${mvo.email}" readonly="readonly"> <span id="emailCheckResult"></span>
						</div>
						 <div class="form-group">
		                     <label for="email">PASSWORD</label>
		                     <input type="password" name="password" id="password" class="form-control" value="${mvo.password}">
		                     <span id="passCheckResult"></span>
		                  </div>
		                  <div class="form-group" id="repassword-group">
		                     <label for="email">REPASSWORD</label> 
		                     <input type="password" name="repassword" id="repassword" class="form-control" placeholder="비밀번호 재확인"> <span id="repassCheckResult"></span>
		                  </div>
						<div class="form-group">
							<label for="email">NICKNAME</label> 
							<input type="text" name="nickname" id="nickname" class="form-control" value="${mvo.nickname}" placeholder="${mvo.nickname}"> <span id="nickCheckResult"></span>
						</div>
						<div class="form-group">
						<span id="showUpdate">
							<c:if test="${mvo.memberPictureUrl!=null}">
								<input type="text" class="form-control" placeholder="${mvo.memberPictureUrl}" style="width: 75%; float: left;"><a href="javascript:startRequest()">
								&nbsp;&nbsp;&nbsp;<input type="button" value="파일 삭제" ></a>
								<input class="form-control" type="hidden" name="memberPictureUrl" value="${mvo.memberPictureUrl}">
							</c:if>
							<c:if test="${mvo.memberPictureUrl==null}">
								<input type="file" name="uploadFile" id="updateProfilePicture" class="form-control">
							</c:if>
							</span>
						</div>
						<div class="form-group">
							<label for="email">NAME</label>
							<input type="text" name="username" id="username" class="form-control" value="${mvo.username}" placeholder="${mvo.username}">
						</div>
						<div class="form-group">
							<label for="email">ADDRESS</label>
							<input type="text" name="address" id="address" class="form-control" value="${mvo.address}" placeholder="${mvo.address}">
						</div>
						<div class="form-group">
							<input type="submit" name="submit" class="btn btn-common" value="수정" style="width: 49%; background-color: white;"> <input type="submit" id="updateProfileBtn" class="btn btn-common" value="취소" style="width: 49%; background-color: white;">
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
	
	<div class="col-md-12">
         <img src="images/home/footer.png" class="img-responsive inline" alt="" style="position: absolute; bottom: 0px; z-index: -1; min-width: 100%; margin-left: -13px; height: 600px;">
   </div>
   
</body>
</html>