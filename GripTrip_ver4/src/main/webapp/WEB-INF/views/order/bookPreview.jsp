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


   <!-- bookpreview : 미리보기 부분 -->
   <link rel="stylesheet" type="text/css" href="css/bookpreview/default.css" />
   <link rel="stylesheet" type="text/css" href="css/bookpreview/bookblock.css" />
   <link rel="stylesheet" type="text/css" href="css/bookpreview/demo4.css" />
   <script src="js/bookpreview/modernizr.custom.js"></script>


   <!-- fomats -->
   <link rel="stylesheet" href="css/bookpreview/bookformat.css">


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
         /* 7/13 */
         var orderPrice=0;
         var price = 0;
         $('#quantity').keyup(function() {
            var quantity = $(this).val();
            price = $('#selected').text();
            price = Number(price);
            
            orderPrice = quantity*price;
            $('#price').html("<br>총 금액은 <font style='font-size: 20px;'><b>"+orderPrice+"원</b></font> 입니다");
         });//keyup
         
         $('#orderFrm').submit(function() {
            var num = $('input[name=quantity]').val();
            if(num<=0){
               alert("1이상을 입력해주세요");
               return false;
            }else
               $('input[name=price]').attr('value', price);
               return confirm(num+"권의 책을 주문하시겠습니까?");
         });//click
      });//function   
</script>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/jejugothic.css);

   input[type="number"]::-webkit-outer-spin-button,
   input[type="number"]::-webkit-inner-spin-button {
       -webkit-appearance: none;
       margin: 0;
   }
   

h1, h2, h5, #page-breadcrumb, #avatar, #bb-bookblock {
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
                     <h1 class="title" style="margin-top: 30px;">주문 페이지</h1>
                     <p>주문 상품의 정보를 확인하시고 수량을 입력해주십시오.</p>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </section>
   <!-- --------------------------------------------- [끝] 제목 Section --------------------------------------------- -->


<br><br>
<div align="center">미 리 보 기</div><br>

<section class="booksection">

<div class="container" style="width: 1300px; height: 590px;">
   <div class="bb-custom-wrapper">
      
      <div id="bb-bookblock" class="bb-bookblock">
         <div class="bb-item">
            <div class="bb-custom-firstpage">
               <h1>${bookInfo.book_title }
               <!-- <span>Back-Cover : 인쇄시 입력x</span> --></h1>   
               <nav class="codrops-demos">
                  ${bookInfo.book_create_date}
               </nav>
            </div>
            <div class="bb-custom-side" id="bookcoverpic" style="background-image: url('upload/${bookInfo.book_picture_url}');" >            
                  <%-- 이부분은 표지입니다. 책배경은 사용자 지정<br><br>
                  ${bookInfo.book_title }<br><br> --%>
            </div>
         </div>
         
         <c:forEach begin="0" end="${fn:length(storyInfo)-1 }" step="2" var="i">
                    
                    <div class="bb-item">
                  
                  <div class="bb-custom-side">
                           <div style="border: 1px solid #eeeeee; width: 600px; height: 350px; background-image: url('${initParam.root}images/bookpreview/post-card.jpg');">
                              <div class="row" style="margin: 60px 30px 25px 30px;">
                                 <c:choose>
                                    <c:when test="${storyInfo[i].storyPictureUrl != null}">
                                          <div class="col-md-6" style="border-right: 1px solid #a99d8e;">
                                               <img src="upload/${storyInfo[i].storyPictureUrl}" width="250" height="230" style="margin-left: -20px;">
                                            </div>
                                            <div class="col-md-6">
                                               <font size="5px;">${storyInfo[i].storyTitle }</font><br>
                                               <c:if test="${storyInfo[i].storyLocation != null}">
                                                  <div style="margin-top: 10px; margin-bottom: 10px;">
                                                  at. ${storyInfo[i].storyLocation}
                                                  </div>
                                               </c:if>
                                       <div style="margin-top: 10px;">
                                                  ${storyInfo[i].storyContent }
                                               </div>
                                       <span style="margin-left: 50px;">
                                       </span>
                                            </div>
                                       </c:when>
                                       <c:otherwise>
                                            <font size="5px;">${storyInfo[i].storyTitle }</font><br>
                                            <c:if test="${storyInfo[i].storyLocation != null}">
                                               <div style="margin-top: 10px; margin-bottom: 10px;">
                                               at. ${storyInfo[i].storyLocation }<br><br>
                                               </div>
                                            </c:if>
                                    <div style="margin-top: 10px;">
                                               ${storyInfo[i].storyContent }
                                            </div>
                                       </c:otherwise>
                                 </c:choose>
                                </div>
                     </div>
                  </div>
                  
                          
                           <div class="bb-custom-side">
                           <c:if test="${storyInfo[i+1]==null }"></c:if>
                           <c:if test="${storyInfo[i+1]!=null }">
                              <div style="border: 1px solid #eeeeee; width: 600px; height: 350px; background-image: url('${initParam.root}images/bookpreview/post-card.jpg');">
                              <div class="row" style="margin: 60px 30px 25px 30px;">
                                 <c:choose>
                                       <c:when test="${storyInfo[i+1].storyPictureUrl != null}">
                                          <div class="col-md-6" style="border-right: 1px solid #a99d8e;">
                                               <img src="upload/${storyInfo[i+1].storyPictureUrl}" width="250" height="230" style="margin-left: -20px;">
                                            </div>
                                            <div class="col-md-6">
                                               <font size="5px;">${storyInfo[i+1].storyTitle }</font><br>
                                               <div style="margin-top: 10px; margin-bottom: 10px;">
                                               at. ${storyInfo[i+1].storyLocation}
                                               </div>
                                       <div style="margin-top: 10px;">
                                                  ${storyInfo[i+1].storyContent }
                                               </div>
                                       <span style="margin-left: 50px;">
                                       </span>
                                            </div>
                                       </c:when>
                                       <c:otherwise>
                                            <font size="5px;">${storyInfo[i+1].storyTitle }</font>
                                            <c:if test="${storyInfo[i+1].storyLocation != null}">
                                               <div style="margin-top: 10px;">
                                                  at. ${storyInfo[i+1].storyLocation }
                                               </div>
                                            </c:if>
                                            <div style="margin-top: 10px;">
                                               ${storyInfo[i+1].storyContent }
                                            </div>
                                       </c:otherwise>
                                    </c:choose>
                                   </div>
                        </div>
                          </c:if>
                        </div>
                     </div>              
              </c:forEach>
      </div>
      <br>
      <nav>
         <a id="bb-nav-first" href="#" class="bb-custom-icon bb-custom-icon-first">First page</a>
         <a id="bb-nav-prev" href="#" class="bb-custom-icon bb-custom-icon-arrow-left">Previous</a>
         <a id="bb-nav-next" href="#" class="bb-custom-icon bb-custom-icon-arrow-right">Next</a>
         <a id="bb-nav-last" href="#" class="bb-custom-icon bb-custom-icon-last">Last page</a>
      </nav>      
   </div>

</div>

<!-- /container -->
</section>


<br><br><br><br><br><br><br><br>




<!-- ----------------------------------------- Fomats ----------------------------------------- -->

<div class="container">
   <div class="row">
      <section>
        <div class="wizard">
            <div class="wizard-inner">
                <div class="connecting-line"></div>
                <ul class="nav nav-tabs" role="tablist">

                    <li role="presentation" class="active">
                        <a href="#step1" data-toggle="tab" aria-controls="step1" role="tab" title="Cover">
                            <span class="round-tab">
                        <i class="glyphicon glyphicon-book"></i>
                            </span>
                        </a>
                    </li>

                    <li role="presentation" class="disabled">
                        <a href="#step2" data-toggle="tab" aria-controls="step2" role="tab" title="Size">
                            <span class="round-tab">
                                <i class="glyphicon glyphicon-fullscreen"></i>
                            </span>
                        </a>
                    </li>
                    <li role="presentation" class="disabled">
                        <a href="#step3" data-toggle="tab" aria-controls="step3" role="tab" title="Paper">
                            <span class="round-tab">
                                <i class="glyphicon glyphicon-th-large"></i>
                            </span>
                        </a>
                    </li>

                    <li role="presentation" class="disabled">
                        <a href="#complete" data-toggle="tab" aria-controls="complete" role="tab" title="Complete">
                            <span class="round-tab">
                                <i class="glyphicon glyphicon-ok"></i>
                            </span>
                        </a>
                    </li>
                </ul>
            </div>

            <form action="howToPay.do" method="post" id="orderFrm">
                <div class="tab-content">
                    <div class="tab-pane active" role="tabpanel" id="step1">
                        <h3 align="center">Cover</h3><br>
                        <p>
                        <center>
                        <div class="row">
                           <div class="col-md-6">
                              <input type="radio" name="cover" id="hard" value="3000" class="input-hidden" />
                        <label for="hard">
                           <img src="images/bookpreview/cover-hard.jpg" style="width: 50%;"/>
                        </label><br><br>
                        <div>
                                 Hard<br>
                                 3000원
                              </div>
                           </div>
                           <div class="col-md-6">
                              <input type="radio" name="cover" id="soft" value="2000" class="input-hidden" />
                        <label for="soft">
                           <img src="images/bookpreview/cover-soft.jpg" style="width: 50%;"/>
                        </label><br><br>
                        <div>
                                 Soft<br>
                                 2000원
                              </div>
                           </div>
                        </div>
                        </center>
                        <ul class="list-inline pull-right">
                            <li><button type="button" class="btn next-step">다음</button></li>
                        </ul>
                    </div>
                    <div class="tab-pane" role="tabpanel" id="step2">
                        <h3 align="center">Size</h3><br>
                        <p>
                        <div class="row">
                           <div class="col-md-4">
                              <input type="radio" name="size" id="small" value="1000" class="input-hidden" />
                        <label for="small">
                           <img src="images/bookpreview/size-small.jpg" style="width: 80%;"/>
                        </label><br><br>
                        <div style="margin-left: 80px;">
                                 Small(18cm*18cm)<br>
                                 1000원
                              </div>
                           </div>
                           <div class="col-md-4">
                              <input type="radio" name="size" id="standard" value="1500" class="input-hidden" />
                        <label for="standard">
                           <img src="images/bookpreview/size-standard.jpg" style="width: 80%;"/>
                        </label><br><br>
                        <div style="margin-left: 80px;">
                                 Standard(20cm*25cm)<br>
                                 1500원
                              </div>
                           </div>
                           <div class="col-md-4">
                              <input type="radio" name="size" id="large" value="2000" class="input-hidden" />
                        <label for="large">
                           <img src="images/bookpreview/size-large.jpg" style="width: 80%;"/>
                        </label><br><br>
                        <div style="margin-left: 80px;">
                                 Large(30cm*30cm)<br>
                                 2000원
                              </div>
                           </div>
                        </div>
                        <br>
                  <ul class="list-inline pull-right">
                            <li><button type="button" class="btn btn-default prev-step"><i class="glyphicon glyphicon-chevron-left"></i></button></li>
                            <li><button type="button" class="btn next-step">다음</button></li>
                        </ul>
                    </div>
                    <div class="tab-pane" role="tabpanel" id="step3">
                        <h3 align="center">Paper</h3><br>
                        <p>
                        <center>
                        <div class="row">
                           <div class="col-md-6">
                              <input type="radio" name="paper" id="gloss" value="1000" class="input-hidden" />
                        <label for="gloss">
                           <img src="images/bookpreview/paper-gloss.PNG" style="width: 70%;"/>
                        </label><br><br>
                        <div>
                                 유광<br>
                                 1000원
                              </div>
                           </div>
                           <div class="col-md-6">
                              <input type="radio" name="paper" id="matt" value="1000" class="input-hidden" />
                        <label for="matt">
                           <img src="images/bookpreview/paper-matt.PNG" style="width: 70%;"/>
                        </label><br><br>
                        <div>
                                 무광<br>
                                 1000원
                              </div>
                           </div>
                        </div>
                        </center>
                        <br>
                  <ul class="list-inline pull-right">
                            <li><button type="button" class="btn btn-default prev-step"><i class="glyphicon glyphicon-chevron-left"></i></button></li>
                            <li><button type="button" class="btn btn-info-full next-step" id="all-save">다음</button></li>
                        </ul>
                    </div>
                    <div class="tab-pane" role="tabpanel" id="complete">
                        <h2>옵션 선택 완료</h2>
                        <p>고객님의 주문하신 책 <font style="font-size: 20px;"><b>1권</b></font>의 가격은</p>
                        <font style='font-size: 20px;'><b><span id="selected"></span>원</b></font> 입니다<br><br>
                        <input type="hidden" name="book_no" value="${bookInfo.book_no}" >
                    <input type="hidden" name="price" value="">
                    Quantity : <input type="number" name="quantity" required="required" id="quantity">
                    <div id="price"></div><br><br>
                    <input class="btn btn-common" style="width: 20%; background: white;" type="submit" value="주문 및 결제">
                    </div>
                    <div class="clearfix"></div>
                </div>
            </form>
        </div>
    </section>
   </div>
</div>

<!-- Fomats -->

<!-- footer -->
   <br>
    <br>
    <br>
    
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
                     <p id="avatar" style="font-size: 14px; margin-left: 10px;">
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



<!-- script -->

      <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
      <script src="js/bookpreview/jquerypp.custom.js"></script>
      <script src="js/bookpreview/jquery.bookblock.js"></script>
      <script>
         var Page = (function() {
            
            var config = {
                  $bookBlock : $( '#bb-bookblock' ),
                  $navNext : $( '#bb-nav-next' ),
                  $navPrev : $( '#bb-nav-prev' ),
                  $navFirst : $( '#bb-nav-first' ),
                  $navLast : $( '#bb-nav-last' )
               },
               init = function() {
                  config.$bookBlock.bookblock( {
                     speed : 1000,
                     shadowSides : 0.8,
                     shadowFlip : 0.4
                  } );
                  initEvents();
               },
               initEvents = function() {
                  
                  var $slides = config.$bookBlock.children();

                  // add navigation events
                  config.$navNext.on( 'click touchstart', function() {
                     config.$bookBlock.bookblock( 'next' );
                     return false;
                  } );

                  config.$navPrev.on( 'click touchstart', function() {
                     config.$bookBlock.bookblock( 'prev' );
                     return false;
                  } );

                  config.$navFirst.on( 'click touchstart', function() {
                     config.$bookBlock.bookblock( 'first' );
                     return false;
                  } );

                  config.$navLast.on( 'click touchstart', function() {
                     config.$bookBlock.bookblock( 'last' );
                     return false;
                  } );
                  
                  // add swipe events
                  $slides.on( {
                     'swipeleft' : function( event ) {
                        config.$bookBlock.bookblock( 'next' );
                        return false;
                     },
                     'swiperight' : function( event ) {
                        config.$bookBlock.bookblock( 'prev' );
                        return false;
                     }
                  } );

                  // add keyboard events
                  $( document ).keydown( function(e) {
                     var keyCode = e.keyCode || e.which,
                        arrow = {
                           left : 37,
                           up : 38,
                           right : 39,
                           down : 40
                        };

                     switch (keyCode) {
                        case arrow.left:
                           config.$bookBlock.bookblock( 'prev' );
                           break;
                        case arrow.right:
                           config.$bookBlock.bookblock( 'next' );
                           break;
                     }
                  } );
               };

               return { init : init };

         })();
      </script>
      <script>
            Page.init();
      </script>
      
      
   <!-- bookformat -->
   <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
   <script src='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js'></script>
   <script src="js/bookpreview/bookformat.js"></script>   
   <script src="https://cdnjs.cloudflare.com/ajax/libs/prefixfree/1.0.7/prefixfree.min.js"></script>
   
   <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/jquery.isotope.min.js"></script>
    <script type="text/javascript" src="js/lightbox.min.js"></script>
    <script type="text/javascript" src="js/wow.min.js"></script>
    <script type="text/javascript" src="js/main.js"></script>  
    
    <div class="col-md-12">
         <img src="images/home/footer.png" class="img-responsive inline" alt="" style="position: absolute; bottom: 0px; z-index: -1; min-width: 100%; margin-left: -13px; height: 600px;">
   </div>
   </body>
</html>