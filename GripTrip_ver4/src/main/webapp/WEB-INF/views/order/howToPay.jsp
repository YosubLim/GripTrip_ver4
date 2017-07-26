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
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<!-- <script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-x.y.z.js"></script> -->

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

		/* if(${p} == false){
			alert('비번이 일치하지 않으니 다시 입력하렴');
			$('#password').val('');
			$('#password').focus();
		}; */

		$('#checkPassForRemoveFrm').submit(function() {
			if (confirm("정말 탈퇴하시겠습니까?"))
				return true;
			else
				return false;
		});//submit

		$('#submit').click(function() {
			var radio = $('input[type=radio]').val();
			swal({
				title : "OK!",
				text : radio + "로 결제 완료.",
			//imageUrl: "images/thumbs-up.jpg"
			});
			return true;
		});//click

		
		/* 결제 화면 변경 */
		
		/* 카드결제 */
		if($('#creditCardDiv-1').is(":hidden")){
			$("#creditCardDiv-1").show();
		}
		
		$(".payment-radios-1 span").on(
				"click",
				function() {
					var radio = $(this).index();

					$(".creditCardDiv").css("display", "none").eq(radio).css(
							"display", "block");
				});
		
		
		/* 현금 결제 */
		if($('#cashDiv-1').is(":hidden")){
			$("#cashDiv-1").show();
		}
		
		$(".payment-radios-2 span").on(
				"click",
				function() {
					var radio = $(this).index();

					$(".cashDiv").css("display", "none").eq(radio).css(
							"display", "block");
				});
		
		/* 간편결제 */
		if($('#simpleDiv-1').is(":hidden")){
			$("#simpleDiv-1").show();
		}
		
		$(".payment-radios-3 span").on("click",function() {
					
					var radio = $(this).index();
					
					$(".simpleDiv").css("display", "none").eq(radio).css(
							"display", "block");
				});
		
		/* 기타결제 */
		if($('#otherDiv-1').is(":hidden")){
			$("#otherDiv-1").show();
		}
		
		$(".payment-radios-4 span").on("click", function() {
					
					var radio = $(this).index();
					
					$(".otherDiv").css("display", "none").eq(radio).css(
							"display", "block");
				});
		
		/* radio checkbox */
		 $(".with-font").change(function() {
		        $(this).parent().addClass('active');
		        $(this).parent().children('.radio, .checkbox').each(function() {
		            var input = $(this).children('input');
		            if (!input.prop('checked')) {
		                $(this).parent().removeClass('active');
		            } 
		        });
		    });

	});//function
	
	/* 결제 넘어가는 */
	function orderResult() {
		/* IMP.init('iamport');
		IMP.request_pay({
		    pg : 'html5_inicis',
		    pay_method : 'card',
		    merchant_uid : 'merchant_' + new Date().getTime(),
		    name : '주문명:결제테스트',
		    amount : 14000,
		    buyer_email : 'iamport@siot.do',
		    buyer_name : '구매자이름',
		    buyer_tel : '010-1234-5678',
		    buyer_addr : '서울특별시 강남구 삼성동',
		    buyer_postcode : '123-456'
		}, function(rsp) {
		    if ( rsp.success ) {
		        var msg = '결제가 완료되었습니다.';
		        msg += '고유ID : ' + rsp.imp_uid;
		        msg += '상점 거래ID : ' + rsp.merchant_uid;
		        msg += '결제 금액 : ' + rsp.paid_amount;
		        msg += '카드 승인번호 : ' + rsp.apply_num;
		    } else {
		        var msg = '결제에 실패하였습니다.';
		        msg += '에러내용 : ' + rsp.error_msg;
		    }

		    alert(msg);
		}); */
		alert("결제가 성공적으로 완료되었습니다.")
		location.href="showOrderInfo.do?orderNo=${order.orderNo}";
	}

	/* 우편번호 찾기 */
	function Postcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
						var extraRoadAddr = ''; // 도로명 조합형 주소 변수

						// 법정동명이 있을 경우 추가한다. (법정리는 제외)
						// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
							extraRoadAddr += data.bname;
						}
						// 건물명이 있고, 공동주택일 경우 추가한다.
						if (data.buildingName !== '' && data.apartment === 'Y') {
							extraRoadAddr += (extraRoadAddr !== '' ? ', '
									+ data.buildingName : data.buildingName);
						}
						// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						if (extraRoadAddr !== '') {
							extraRoadAddr = ' (' + extraRoadAddr + ')';
						}
						// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
						if (fullRoadAddr !== '') {
							fullRoadAddr += extraRoadAddr;
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('postcode').value = data.zonecode; //5자리 새우편번호 사용
						document.getElementById('roadAddress').value = fullRoadAddr;
						document.getElementById('jibunAddress').value = data.jibunAddress;

						// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
						if (data.autoRoadAddress) {
							//예상되는 도로명 주소에 조합형 주소를 추가한다.
							var expRoadAddr = data.autoRoadAddress
									+ extraRoadAddr;
							document.getElementById('guide').innerHTML = '(예상 도로명 주소 : '
									+ expRoadAddr + ')';

						} else if (data.autoJibunAddress) {
							var expJibunAddr = data.autoJibunAddress;
							document.getElementById('guide').innerHTML = '(예상 지번 주소 : '
									+ expJibunAddr + ')';

						} else {
							document.getElementById('guide').innerHTML = '';
						}
					}
				}).open();
	}
</script>
<title>Insert title here</title>

<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/jejugothic.css);

.col-sm-12, h1, h2, p {
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


/* table vertical */
.order-list-vertical {
	max-width: 100%;
	background-color: transparent;
	border-collapse: collapse;
	border-spacing: 0;
	width: 100%;
	margin-bottom: 20px;
}

.order-list-vertical thead th, .order-list-vertical tbody td {
	padding: 10px 10px;
	line-height: 100%;
	text-align: center;
	vertical-align: middle;
	border-top: 1px solid #dddddd;
	border-bottom: 1px solid #dddddd;
}

.order-list-vertical tbody td {
	font-size: 13px;
}

.order-list-vertical thead th {
	background: #eeeeee;
	vertical-align: bottom;
	font-size: 13px;
}

#startTable {
	border-top: 2px solid #dddddd;
}

/* 사진 */
#divProductInfo {
	text-align: left;
	padding-left: 30px;
}

#productInfoTitle {
	padding-left: 20px;
}

.productInfo {
	display: inline-block;
	box-shadow: 3px 3px 10px #333;
	margin: 5px;
	position: relative;
}

.productInfoTitle {
	position: absolute;
	width: 100%;
	min-height: 25%;
	top: 0px;
	background-color: #949596;
	opacity: 0.5;
	font-size: 5px;
	/* font-size: 30px; 나눔손글씨*/
}

.productInfoTitle p {
	margin-top: 3px;
	margin-left: 10px;
	margin-right: 10px;
	margin-buttom: 30px;
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

.productInfo img {
	vertical-align: middle;
	height: 120px;
	width: 90px;
	object-fit: cover;
	/* border: 0.5px solid #5a2d18; */
}

.productInfo:after {
	content: '';
	position: absolute;
	top: 0;
	left: 0.5rem;
	bottom: 0;
	width: .2rem;
	background: rgba(0, 0, 0, .06);
	box-shadow: 1px 0 3px rgba(255, 255, 255, .1);
}

/* table horizontal */
.order-list-horizontal {
	max-width: 100%;
	background-color: transparent;
	border-collapse: collapse;
	border-spacing: 0;
	width: 100%;
	margin-bottom: 20px;
}

.order-list-horizontal tbody th {
	background: #eeeeee;
	vertical-align: bottom;
	font-size: 13px;
	border-right: 1px solid #dddddd;
	
	
}

.order-list-horizontal tbody th {
	padding: 5px 10px;
	width: 12em;
	line-height: 100%;
	text-align: center;
	vertical-align: middle;
	border-top: 1px solid #dddddd;
	border-bottom: 1px solid #dddddd;
}

.order-list-horizontal tbody td {
	padding: 10px 30px;
	line-height: 100%;
	border-top: 1px solid #dddddd;
	border-bottom: 1px solid #dddddd;
}

#jumpjump {
	margin: 10px;
	padding: 20px;
}

/* payment checkbox, radio */

.payment-rc {
	margin-top: 10px;
}

.payment-rc span {
	margin-right: 10px;
}

.payment-rc label { 
	font-size: 13px;
	font-weight: normal; 
}

.payment-rc input[type=radio].with-font,
.payment-rc input[type=checkbox].with-font {
    border: 0;
    clip: rect(0 0 0 0);
    height: 1px;
    margin: -1px;
    overflow: hidden;
    padding: 0;
    position: absolute;
    width: 1px;
}
    
.payment-rc input[type=radio].with-font ~ label:before,
.payment-rc input[type=checkbox].with-font ~ label:before {
    font-family: FontAwesome;
    display: inline-block;
    content: "\f1db";
    letter-spacing: 10px;
    font-size: 1.2em;
    color: #535353;
    width: 1.4em;
}

.payment-rc input[type=radio].with-font:checked ~ label:before,
.payment-rc input[type=checkbox].with-font:checked ~ label:before  {
    content: "\f00c";
    font-size: 1.2em;
    letter-spacing: 5px;
}
.payment-rc input[type=checkbox].with-font ~ label:before {        
    content: "\f096";
}
.payment-rc input[type=checkbox].with-font:checked ~ label:before {
    content: "\f046";        
}



/* 총 결제 div */
.total-payment {
  z-index: 100;
  width: 50%;
  min-width: 100%;
  /* height: 100%;
  min-height: 100%; */
  background: 0 0 #ffffff;
  border-radius: 8px;
  border: 1px solid #dedede;
  margin-left: auto;
  margin-right: auto;
  display: block;
}

.total-payment-info {
  
  padding: 15px;
  text-align: right;
  background: #EEF2F4;
  color: #5D6F78;
  font-size: 13px;
  font-weight: 300;
  border-bottom: 1px solid #DEDEDE;
  border-top-left-radius: 8px;
  border-top-right-radius: 8px;
}

.total-payment-box {
  padding: 5px;
  margin-top: 20px;
  background: #fff;
  border: 1px solid #fff;
  border-radius: 8px;
}

.total-price{
  display: inline-block;
  font-size: 25px;
  font-weight: bold;
}

.order_agree{
  font-size: 12px;
  padding: 8px;
  
}

.order_agree_box{
  display:inline-block;
  font-size: 11px;
  font-weight: 100;
}

.order_payment_sub{
  padding: 0 7px 20px 7px;
}

/* 결제 방식 */
.payment-radios-span{
	margin-left: 5px;
}

input[name^="resize-"] {
	position: absolute;
	opacity: 0;
	cursor: pointer;
	z-index: 100;
	width: 150px;
	height: 35px;
	z-index: 100;
}

input[name^="resize-"] + label {
    color: #fff;
	display: inline-block;
    background: rgba(183, 172, 172, .7); 
	width: 150px;
	line-height: 35px;
	height: 35px;
    text-align: center;
	position: relative;
}
input[name^="resize-"]:checked + label {
    background: rgba(34, 35, 36, .7);
    color: #fff;
	box-shadow: 0px 1px 1px rgba(255,255,255,0.3);
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
							<h1 class="title">결제 페이지</h1>
							<p>결제 방식을 선택해 주십시오.</p>

						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- --------------------------------------------- [끝] 제목 Section --------------------------------------------- -->

	<!-- --------------------------------------------- [시작] 본문 Section --------------------------------------------- -->
	<br />
	<br />
	<br />
	<section>
		<div class="container">
			<div class="col-md-1"></div>

			<div class="col-md-10">
				<!-- 주문정보 -->
				
					<div style="margin-left: 3.5em;">
						<h4>주문상품정보</h4>
					</div>
					<table class="order-list-vertical">
						<colgroup>
							<col width="*" />
							<col width="*" />
							<col width="15%" />
							<col width="10%" />
							<col width="15%" />
						</colgroup>
						<thead id="order-header">
							<tr id="startTable">
								<th colspan="2">상품정보</th>
								<th>판매가</th>
								<th>수량</th>
								<th>합계</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td colspan="2">
									<div id="divProductInfo">
										<span class="productInfo"> <img
											src="upload/${order.book.book_picture_url}" />
											<div class="productInfoTitle">
												<p>${order.book.book_title}</p>
											</div>
										</span> <span id="productInfoTitle"> ${order.book.book_title}
										</span>
									</div>
								</td>
								<td>
									<div id="productInfoOther">
										<span> ${param.price}원</span>
									</div>
								</td>
								<td>
									<div id="productInfoOther">
										<span> ${order.quantity} </span>
									</div>
								</td>
								<td>
									<div id="productInfoOther">
										<span> ${order.totalPrice}원</span>
									</div>
								</td>
							</tr>

						</tbody>
					</table>
				

				<br> <br>

				<!-- 배송정보 -->
				
					<div style="margin-left: 3.5em;">
						<h4>배송정보</h4>
					</div>

					<table class="order-list-horizontal">
						<tbody>
							<tr id="startTable">
								<th scope="row">주문자 정보</th>
								<td colspan="3">
									<div>
										${sessionScope.mvo.username} <span id="jumpjump">|</span>
										${sessionScope.mvo.email}
									</div>
								</td>
							</tr>
						</tbody>

						<tbody>
							<tr>
								<th>받으시는 분</th>
								<td><input type="text" class="form-control"
									placeholder="(10자 이내)" maxlength="10"
									style="width: 10em; height: 2.5em;" /></td>
							</tr>
							<tr>
								<th>휴대폰 번호</th>
								<td><select class="form-control"
									style="display: inline; text-align: center; width: 5.2em; height: 2.5em;">
										<option value="010">010</option>
										<option value="011">011</option>
										<option value="016">016</option>
										<option value="017">017</option>
										<option value="018">018</option>
										<option value="019">019</option>
								</select> - <input type="text" maxlength="4" class="form-control"
									style="display: inline; text-align: center; width: 5.2em; height: 2.5em;" />
									- <input type="text" class="form-control"
									style="display: inline; text-align: center; width: 5.2em; height: 2.5em; ime-mode: disabled;"
									maxlength="4" /></td>
							<tr>
							<tr>
								<th>배송 주소</th>
								<td colspan="3">
									<div>
										<input type="text" class="form-control" id="postcode"
											placeholder="우편번호" readonly="readonly"
											style="display: inline-block; width: 7em; height: 2.5em; margin-bottom: 0.5em;">
										<input type="button" class="form-control" onclick="Postcode()"
											value="우편번호"
											style="display: inline-block; width: 6em; height: 2.6em; margin-bottom: 0.5em;"><br>
									</div>
									<div>
										<input type="text" class="form-control" id="roadAddress"
											placeholder="도로명주소" readonly="readonly"
											style="width: 35em; height: 2.5em; margin-bottom: 0.5em;">
									</div>
									<div>
										<input type="text" class="form-control" id="jibunAddress"
											placeholder="지번주소" readonly="readonly"
											style="width: 35em; height: 2.5em; margin-bottom: 0.5em;">
										<span id="guide" style="color: #999"></span>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				

				<br> <br>

				<!-- 결제정보 -->
				
				<div class="col-md-9">
					<div class="row">
						<div style="margin-left: 3.5em;">
							<h4>결제정보</h4>
						</div>
						<div id="startTable"></div>
						<br>

						<ul id="tab2" class="nav nav-tabs" style="text-align: center;">
							<li style="width: 12.35em;" class="active"><a
								href="#tab2-item1" data-toggle="tab">신용카드결제</a></li>
							<li style="width: 12.3em;"><a href="#tab2-item2"
								data-toggle="tab">현금결제</a></li>
							<li style="width: 12.3em;"><a href="#tab2-item3"
								data-toggle="tab">간편결제</a></li>
							<li style="width: 12.33em;"><a href="#tab2-item4"
								data-toggle="tab">기타결제</a></li>
						</ul>

						<!-- 신용카드 결제 -->
						<div class="tab-content">
							<div class="tab-pane fade active in" id="tab2-item1">
								<div class="payment-radios-1">
									<span class="payment-radios-span">
										<input type="radio" name="resize-graph" id="creditCard" checked="checked"/><label for="creditCard">신용카드</label>
									</span>
										
									<span class="payment-radios-span">
               							<input type="radio" name="resize-graph" id="foreignCreditCard" /><label for="foreignCreditCard">해외발급신용카드</label>
               						</span>
								</div>

								<!-- 신용카드 -->
								<div class="creditCardDiv" id="creditCardDiv-1" style="display: none; visibility: visible;">
									<table class="order-list-horizontal">
										<tbody>
											<tr>
												<th>카드 구분</th>
												<td>
													<div class="payment-rc">
    													<span>
 															<input id="privateCard" name="question" type="radio" class="with-font" value="" checked="checked"/>
   															<label for="privateCard">개인카드</label>
    													</span>
    													<span>
    														<input id="businessCard" name="question"type="radio" class="with-font" value=""/>
    														<label for="businessCard">법인카드</label>
    													</span>
  													</div>
													
												</td>
											</tr>
											<tr>
												<th>카드 선택</th>
												<td colspan="3"><select class="form-control" name=""
													style="width: 15em; height: 2.5em;">
														<option value="">선택해주세요</option>
														<option value="SH">신한카드(구LG)</option>
														<option value="KB">KB국민카드</option>
														<option value="BC">BC카드</option>
														<option value="HD">현대카드</option>
														<option value="LT">롯데카드</option>
														<option value="WH">외환카드</option>
														<option value="SS">삼성카드</option>
														<option value="UR">우리카드</option>
														<option value="HN">하나카드</option>
														<option value="CT">씨티카드</option>
														<option value="JC">저축은행카드</option>
														<option value="UC">우체국카드</option>
														<option value="SM">MG새마을체크카드</option>
														<option value="SUH">수협카드</option>
														<option value="JB">전북JB카드</option>
														<option value="KJ">광주은행카드</option>
														<option value="NH">NH카드</option>
														<option value="SIH">신협카드</option>
														<option value="JJ">제주카드</option>
														<option value="SU">KDB산업은행카드</option>
												</select></td>
											</tr>
										</tbody>
									</table>
								</div>

								<!-- 해외발급신용카드 -->
								<div class="creditCardDiv" style="display: none;">
									<table class="order-list-horizontal">
										<tbody>
											<tr>
												<th>카드 선택</th>
												<td colspan="3"><select class="form-control" name=""
													style="width: 15em; height: 2.5em;">
														<option value="">선택해주세요</option>
														<option value="SH">해외VISA</option>
														<option value="KB">해외MASTER</option>
														<option value="BC">해외JCB</option>
												</select></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>

							<!-- 현금결제 -->
							<div class="tab-pane fade" id="tab2-item2">
								<div class="payment-radios-2">
									<span class="payment-radios-span">
											<input type="radio" name="resize-graph" id="accountTrasfer" checked="checked"/><label for="accountTrasfer">실시간 계좌이체</label>
									</span>
									<span class="payment-radios-span">
											<input type="radio" name="resize-graph" id="noneDeposit" /><label for="noneDeposit">무통장 입금</label>
									</span>		
								</div>

								<!-- 실시간 계좌이체 -->
								<div class="cashDiv" id="cashDiv-1" style="display: none;">
									<table class="order-list-horizontal">
										<tbody>
											<tr>
												<th>결제 안내</th>
												<td>
													<ul
														style="margin: 0; padding: 0; font-size: 12px; list-style: square;">
														<li>실시간계좌이체는 인터넷뱅킹과 유사하게 주문과 동시에 고객님의 통장에서 계좌이체 되는
															서비스입니다.(수수료없음)</li>
														<li>실시간 계좌이체 이용을 위해서 공인인증서가 필요합니다.</li>
													</ul>
												</td>
											</tr>
										</tbody>
										
										<tbody>
											
											<tr>
												<th>현금영수증</th>
												<td>
													<div class="payment-rc">
    													<span>
 															<input name="cashStatement" id="personal" type="radio" class="with-font" value="" checked="checked"/>
   															<label for="personal">개인소득공제용</label>
    													</span>
    													<span>
    														<input name="cashStatement" id="business" type="radio" class="with-font" value=""/>
    														<label for="business">법인카드</label>
    													</span>
    													<span>
    														<input name="cashStatement" id="none" type="radio" class="with-font" value=""/>
    														<label for="none">미신청</label>
    													</span>
  													</div>
													
													
													<!-- 개인소득공제용 -->
													<div class="statement" >
														<span id="select-statement">
														<select class="form-control"
															style="margin-right:1.5em; display: inline-block; width: 9em; height: 3em; font-size: 11px;">
															<option value="card">카드번호</option>
														</select>
														</span>
														
														<span id="select-statement-span">
														<input type="text" maxlength="4" class="form-control"
															style="margin-top:10px; display: inline-block;  width: 7em; height: 3em; font-size: 11px;" />
														- <input type="text" class="form-control"
															style="display: inline-block;  width: 7em; height: 3em; ime-mode: disabled;
															font-size: 11px;" maxlength="4" />
														- <input type="text" class="form-control"
															style="display: inline-block;  width: 7em; height: 3em; ime-mode: disabled;
															font-size: 11px;" maxlength="4" />
														- <input type="text" class="form-control"
															style="display: inline-block;  width: 7em; height: 3em; ime-mode: disabled;
															font-size: 11px;" maxlength="6" />
														</span>
													</div>
													
													<!-- 사업자등록 -->
													<!-- <div class="business-statement" style="display: none;"> -->
													<div class="statement" id="statement-1" style="display: none;">
														<span>
														<select class="form-control"
															style="margin-right:2em; display: inline-block; width: 12em; height: 3em; font-size: 11px;">
															<option value="">사업자등록증번호</option>
														</select>
														</span>
														<span>
															<input type="text" maxlength="3" class="form-control"
															style="display: inline-block;  width: 5em; height: 3em; font-size: 11px;" />
															- <input type="text" class="form-control"
															style="display: inline-block;  width: 4em; height: 3em; font-size: 10px;" maxlength="2" />
															- <input type="text" class="form-control"
															style="display: inline-block;  width: 7em; height: 3em; font-size: 10px;" maxlength="6" />
														</span>
													</div>
													
													<!-- 미신청 -->
													<!-- <div class="none-statement" style="display: none;"> -->
													<div class="statement" id="statement-2" style="display: none;">
													
													</div>
												</td>
											</tr>
										</tbody>
									</table>
								</div>

								<!-- 무통장 입금 -->
								<div class="cashDiv" style="display: none;">
									<table class="order-list-horizontal">
										<tbody>
											<tr>
												<th>입금은행</th>
												<td colspan="3"><select class="form-control" name=""
													style="width: 15em; height: 2.5em;">
														<option value="">선택해주세요</option>
														<option value="KBB">국민은행</option>
														<option value="CBB">기업은행</option>
														<option value="NHB">농협은행</option>
														<option value="SHB">신한은행</option>
														<option value="OLB">우리은행</option>
														<option value="POB">우체국은행</option>
														<option value="SSB">하나은행</option>
												</select></td>
											</tr>
											<tr>
												<th>입금자명</th>
												<td colspan="3"><input type="text" maxlength="4"
													class="form-control"
													style="display: inline; text-align: center; width: 8em; height: 2.5em;" />
												</td>
											</tr>
											<tr>
												<th>결제 안내</th>
												<td>
													<ul
														style="margin: 0; padding: 0; font-size: 12px; list-style: square;">
														<li>은행별 가상계좌(개인전용)가 부여되며, 주문완료 후 부여된 계좌번호를 확인하실 수
															있습니다.</li>
														<li>정확한 주문금액(원 단위까지) 입금해 주세요.</li>
														<li>주문완료후 10일 이내 미입금시 주문이 자동 취소 되며, 취소금액은 예치금으로 처리
															됩니다.</li>
														<li>해외송금은 불가합니다. 환차손 및 해외송금수수료, 입금실패로 반송 수수료 발생 등
															고객님의 손해가 발생할 수 있으니 이점 유의해 주세요.</li>
														<li>동일금액으로 여러 주문건이 발생할 경우 가장 최근에 주문된 입금대기 건부터 입금완료처리
															됩니다.</li>
													</ul>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>



							<!-- 간편결제 -->
							<div class="tab-pane fade" id="tab2-item3">
								<div class="payment-radios-3">
									<span class="payment-radios-span">
											<input type="radio" name="resize-graph" id="kakao" checked="checked"/><label for="kakao">카카오페이</label>
									</span>
									<span class="payment-radios-span">	
											<input type="radio" name="resize-graph" id="naver" /><label for="naver">네이버페이</label>
									</span>
									<span class="payment-radios-span">
											<input type="radio" name="resize-graph" id="payco" /><label for="payco">PAYCO</label>
									</span>
									<span class="payment-radios-span">
											<input type="radio" name="resize-graph" id="syruppay" /><label for="syruppay">SyrupPay</label>
									</span>
								</div>


								<!-- 카카오 페이 -->
								<div class="simpleDiv" id="simpleDiv-1" style="display: none;">
									<table class="order-list-horizontal">
										<tbody>
											<tr>
												<th>결제 안내</th>
												<td>
													<ul
														style="margin: 0; padding: 0; font-size: 12px; list-style: square;">
														<li>카카오페이는 카카오톡 앱에 개인 신용카드(체크카드 포함)를 등록/인증하여 카카오페이
															비밀번호로 결제할 수 있는 간편결제입니다.</li>
														<li>본인명의 스마트폰 카카오톡에서 본인명의 카드 등록 후 사용 가능합니다.</li>
														<li>카카오페이는 무이자할부 및 제휴카드 혜택 내용과 관계가 없습니다. 자세한 사항은
															카카오페이 공지사항에서 확인하실 수 있습니다.</li>
													</ul>
												</td>
											</tr>
										</tbody>
									</table>
								</div>

								<!-- 네이버페이 -->
								<div class="simpleDiv" style="display: none;">
									<table class="order-list-horizontal">
										<tbody>
											<tr>
												<th>결제 안내</th>
												<td>
													<ul
														style="margin: 0; padding: 0; font-size: 12px; list-style: square;">
														<li>네이버페이는 네이버ID로 별도 앱 설치 없이 신용카드 또는 은행계좌 정보를 등록하여
															네이버페이 비밀번호로 결제할 수 있는 간편결제 서비스입니다.</li>
														<li>결제 가능한 신용카드 : 신한, 삼성, 현대, BC, 국민, 하나, 롯데, NH농협,
															씨티</li>
														<li>결제 가능한 은행 : NH농협, 국민, 신한, 우리, 기업, SC제일, 부산, 경남,
															수협, 우체국.</li>
														<li>네이버페이 카드 간편결제는 네이버페이에서 제공하는 카드사 별 무이자, 청구할인 혜택을
															받을 수 있습니다.</li>
														<li>주문 변경 시 카드사 혜택 및 할부 적용 여부는 해당 카드사 정책에 따라 변경될 수
															있습니다.</li>
													</ul>
												</td>
											</tr>
										</tbody>
									</table>
								</div>

								<!-- PAYCO -->
								<div class="simpleDiv" style="display: none;">
									<table class="order-list-horizontal">
										<tbody>
											<tr>
												<th>결제 안내</th>
												<td>
													<ul
														style="margin: 0; padding: 0; font-size: 12px; list-style: square;">
														<li>PAYCO는 NHN엔터테인먼트가 만든 안전한 간편결제 서비스입니다.</li>
														<li>휴대폰과 카드 명의자가 동일해야 결제 가능하며, 결제금액 제한은 없습니다.</li>
														<li>지원카드 : 모든 신용/체크카드 결제 가능</li>
													</ul>
												</td>
											</tr>
										</tbody>
									</table>
								</div>

								<!-- SyrupPay -->
								<div class="simpleDiv" style="display: none;">
									<table class="order-list-horizontal">
										<tbody>
											<tr>
												<th>결제 안내</th>
												<td>
													<ul
														style="margin: 0; padding: 0; font-size: 12px; list-style: square;">
														<li>Syrup Pay는 SK PLANET이 만든 간편결제 서비스입니다.</li>
														<li>앱이나 공인인증서, Active-X를 설치할 필요없이 모든 브라우저에서 사용 가능하며,
															모든 신용/체크카드 결제가 가능합니다.</li>
													</ul>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>

							<!-- 기타결제 -->
							<div class="tab-pane fade" id="tab2-item4">
								<div class="payment-radios-4">
									<span class="payment-radios-span">
											<input type="radio" name="resize-graph" id="phone" checked="checked"/><label for="phone">휴대폰결제</label>
									</span>
								</div>

								<div class="otherDiv" id="otherDiv-1" style="display: none;">
									<table class="order-list-horizontal">
										<tbody>
											<tr>
												<th>결제 안내</th>
												<td>
													<ul style="margin: 0; padding: 0; font-size: 12px;">
														<li><strong>휴대폰 결제 제한 안내</strong></li>
														<li>- 만 19세 미만 미성년자/법인 등록된 휴대폰</li>
														<li>(단, LG U+의 만 14세 이상의 경우, 법정대리인의 동의 시 5만원 미만 내 결제
															가능)</li>
														<li>- 연체, 미납 상태 휴대폰</li>
														<li>- 분실 등록된 휴대폰</li>
														<li>- 사용자 정지 신청 휴대폰</li>
													</ul>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="col-md-3">
					<div style="height: 39px;"></div>
					<div class="row" style="margin-left: 5px;">
						<div class="total-payment">
      						<div class="total-payment-info">
      							<table>
									<colgroup>
										<col width="100%">
										<col>
									</colgroup>
									<tbody>
										<tr>
											<th scope="row">상품수</th>
											<td><span>${order.quantity}(권)</span></td>
										</tr>
										<tr>
												<th scope="row">상품금액</th>
											<td class="cost">${order.totalPrice}(원)</td>
										</tr>
										<tr>
											<th scope="row">배송비</th>
											<td class="cost">0(원)</td>
											</tr>
									</tbody>
									<tfoot>
										<tr>
											<td colspan="2">
												<div class="total-payment-box">
													<p><strong>최종 결제금액</strong></p>
													<p class="total-price">${order.totalPrice}</p><span>(원)</span>
												</div>
											</td>
										</tr>
									</tfoot>
								</table>
							</div>
							<div class="order_agree">
								<p><strong>주문동의</strong></p>
								<p>주문할 상품의 상품명, 가격, 배송 정보에 동의하십니까?</p>
								<div class="payment-rc">
    								<input id="box1" type="checkbox" class="with-font" required="required"/>
    								<label for="box1" style="font-size: 11px;">확인동의(전자상거래법 제 8조 2항)</label>
  								</div>
							</div>
							
							<div class="order_payment_sub">
								<input type="button" class="form-control" value="결제하기" id="" onclick="orderResult()"
								style="width: 9.7em; height: 3em; padding-bottom:12px; font-size: 20px; font-weight: bold;">
								
							</div>
							
						</div>      					
  					</div>
				</div>
			</div>
			
			<div class="col-md-1"></div>
						
		</div>
	</section>
		<br><br><br>
	<!-- --------------------------------------------- [끝] 제목 Section --------------------------------------------- -->

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
