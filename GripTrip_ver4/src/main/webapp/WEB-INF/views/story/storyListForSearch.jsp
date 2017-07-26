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
<link href="css/card.css" rel="stylesheet">
<link href="css/font-awesome.min.css" rel="stylesheet">
<!--[if lt IE 9]>
       <script src="js/html5shiv.js"></script>
       <script src="js/respond.min.js"></script>
    <![endif]-->
<link rel="shortcut icon" href="images/ico/griptrip.ico">
<link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/apple-touch-icon-144-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/apple-touch-icon-114-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">
<link rel="stylesheet" href="css/search.css">
<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.js"></script>
<script type="text/javascript">
      $(function(){
    		//선택한 정렬 방식에 밑줄
    		if(${sort==''} || ${sort=='new'}){
    			$('#new-sort').css('text-decoration', 'underline');
    		}else if(${sort=='hit'}){
    			$('#hit-sort').css('text-decoration', 'underline');
    		}else if(${sort=='bookmark'}){
    			$('#bookmark-sort').css('text-decoration', 'underline');
    		}
    	  //검색할때 선택되어진 카테고리
    	if
    		(${select==""}) $('#category').val("all").attr("selected","selected");
    	else 
    		$('#category').val("${select}").attr("selected","selected");
         // 로그아웃 버튼 클릭 시 confirm
          $('#logoutA').click(function(){
             if(confirm("로그아웃 하시겠습니까?")){
                  alert("로그아웃되었습니다.")
                  location.href="logout.do";
               }else{
                  return;
               }
          });
         
          $('.hotKeyword').bind("click", function() {
		      var str = $('#search').val();
		      var returnStr = str.split(" ");
		      
		      if(returnStr.length==1){
		         $('#search').val($('#search').val()+$(this).text()+" ");
		         return;
		      }   
		      for(var i=0; i<returnStr.length-1; i++){
		         if(returnStr[i]==$(this).text()){
		               return;
		            }
		      }//for
		      $('#search').val($('#search').val()+$(this).text()+" ");
		    });//bind           
            
          //검색 엔터 추가..
	        $("#search").keypress(function(enter) {
	        	//7/19
	           if(enter.keyCode==13){
	        	   var keyword = '${keyword}';
	        	   keyword = escape(encodeURIComponent(keyword));
	        	   enter.preventDefault();
	        	   search();
	           }
	        });//keypress
	        $('[data-toggle="tooltip"]').tooltip();
   });//function
   
   function selectButton(kind) {
      //alert("${keyword}");
      var keyword = '${keyword}';
      //alert(keyword);
      keyword = escape(encodeURIComponent(keyword));
      //alert(escape(encodeURIComponent(${keyword})));
      location.href="searchAgain.do?keyword="+keyword+"&&select=${select}"+"&&from="+kind+"&&sort=";
   }
   
   function deleteBookmark(kind, bno, sno) {
          $(function() {
               $.ajax({
                  type:"post",
                  url:"storyDeleteBookmark.do",
                  data:"book_no="+bno+"&&storyNo="+sno,
                  dataType:"json",
                     
                  success:function(data){
                     $('#'+sno).remove;
                     location.reload();
                  }//callback
               });//ajax
            });//function
      //location.href="storyDeleteBookmark.do?book_no="+bno+"&&storyNo="+sno+"&&from=story";
   }
   
   function bookmark(kind, bno, sno) {
      if(confirm("이 글을 북마크 하시겠습니까?")){
          $(function() {
                $.ajax({
                   type:"post",
                   url:"insertBookmark.do",
                   data:"book_no="+bno+"&&storyNo="+sno,
                   dataType:"json",
                      
                   success:function(data){
                      $('#'+sno).remove;
                      location.reload();
                   }//callback
                });//ajax
             });//function
         //location.href="insertBookmark.do?book_no="+bno+"&&storyNo="+sno+"&&from=story";
      }
   }
   function loginCheck() {
      if(confirm("로그인을 해주세요.\n홈으로 이동합니다."))   
         location.href="index.jsp";
   }
   var category="";
   var index="";
   var value="all";
   function category_selected() {
      category = document.getElementById('category');
      index = category.selectedIndex;
      value = category.options[index].value;
      //alert(index+", "+value);
   }
   //검색 버튼 눌렀을 때
   function search() {
      var keyword = document.getElementById('search');
      if(keyword.value==""){
         alert("검색어를 입력해주세요");
         return;
      }
      keyword = escape(encodeURIComponent(keyword.value));
      location.href="searchAgain.do?select="+value+"&&keyword="+keyword+"&&from=story&&sort=";
   }
   function sorting(kind) {
	   var keyword = '${keyword}';
	   keyword = escape(encodeURIComponent(keyword));
	    if(${select==""}) 
	   		location.href="searchAgain.do?keyword="+keyword+"&&select=all&&from=story"+"&&sort="+kind;
	   	else
	   		location.href="searchAgain.do?keyword="+keyword+"&&select=${select}&&from=story"+"&&sort="+kind;
   }
</script>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/jejugothic.css);

.col-sm-12, h1, h2, font, .sorting, #category, p {
	font-family: 'Jeju Gothic';
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

table {
	width: 100%;
}

td {
	border-bottom: 1px solid #c2c3c4;
	width: 33%;
	height: 100px;
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
                            <h1 class="title">다른 사람들의 스토리북, 스토리 구경</h1>
                            <p>다른 사람들의 스토리북과 스토리를 검색하고 구경해보세요.</p>
                        </div>
                     </div>
                </div>
            </div>
        </div>
   </section>
   <!-- --------------------------------------------- [끝] 제목 Section --------------------------------------------- -->
   <br/>
   <br/>
   <div class="container" style="width: 100%;">
      <div class="row">
         <div class="col-md-3"></div>
         <div class="col-md-1">
            <select id="category" onchange="category_selected()" class="form-control" style="position: relative;top: 33px;height: 40px;">
              <option value="all">전체</option>
              <option value="title">제목</option>
              <option value="content">내용</option>
              <option value="location">장소</option>
            </select>            
         </div>
         <div class="col-md-4">
            <br/>
      <!-- --------------------------------------------- [시작] 검색창 --------------------------------------------- -->   
            <form class="search-form">
               <c:choose>
                  <c:when test="${keyword==null}">
                     <input type="text" name="search" id="search" placeholder="검색어를 입력하세요" class="search-input">
                     
                  </c:when>
                  <c:otherwise>
                     <input type="text" name="search" id="search" value="${keyword}" class="search-input">
                     
                  </c:otherwise>
               </c:choose>
            </form>
            <p>
            <i class="fa fa-search" aria-hidden="true" id="search-icon" type="button" onclick="search()" style="margin-top: 3px;"></i>
      <!-- --------------------------------------------- [끝] 검색창 --------------------------------------------- -->   
            
         </div>
         <div class="col-md-1">      
            <!-- <input type="button" onclick="search()" value="검색" style="top: 33px;position: relative;width: 100%;background-color: white; border-radius: 40px;height: 40px;" class="btn btn-common"> --> 
         </div>
         <div class="col-md-3"></div>
      </div>
         
      <div class="row">
         <div class="col-md-3"></div>
         <div class="col-md-6" style="text-align: center;">
            <br/>
            인기검색어 &ensp;<i class="fa fa-chevron-right" aria-hidden="true"></i>&ensp;&ensp;&ensp;
            <a class="hotKeyword"><font size="4px">${reportList[0]}</font></a>&ensp;&ensp;&ensp;  
            <a class="hotKeyword"><font size="4px">${reportList[1]}</font></a>&ensp;&ensp;&ensp;   
            <a class="hotKeyword"><font size="4px">${reportList[2]}</font></a>&ensp;&ensp;&ensp; 
            <a class="hotKeyword"><font size="4px">${reportList[3]}</font></a>&ensp;&ensp;&ensp;
            <a class="hotKeyword"><font size="4px">${reportList[4]}</font></a>&ensp;&ensp;&ensp;
         </div>
         <div class="col-md-3">
         </div>
      </div>
      <br/>
      <br/>
      <br/>
      <div class="row">
         <div class="col-md-3"></div>
         <div class="col-md-6">
            <table style="width: 100%;text-align: center;">
               <tr>
                  <td><a onclick="selectButton('all')" style="color: black;font-size: 22px;">All</a></td>
                  <td><a onclick="selectButton('book')" style="color: black;font-size: 22px;">Storybook</a></td>
                  <td style="border-bottom: 2px solid black;"><a onclick="selectButton('story')" style="color: black;font-size: 22px;">Story</a></td>
               </tr>
            </table>
         </div>
         <div class="col-md-3"></div>
      </div>
      <br/>
   </div>
   <br />
   <br />
   <br />
   <br />
   <br />
   <!-- --------------------------------------------- [시작] Story List--------------------------------------------- -->
   <!-- 스토리 리스트 -->
   <c:choose>
      <c:when test="${fn:length(storyList)!=0}">
         <div class="container" style="width: 85%;">
            <div class="row">
            <c:if test="${storyList!='[]'}">
               <div class="col-md-12" style="text-align: center;">
                  <font size="30px">STORY</font>
               </div>
               <div style="text-align: left;">
                  <a class="sorting" id="new-sort" href="javascript:sorting('new')" style="font-size: 18px;color: black;">최신순</a>&ensp;&ensp;
                  <a class="sorting" id="hit-sort" href="javascript:sorting('hit')" style="font-size: 18px;color: black;">조회수순</a>&ensp;&ensp;
                  <a class="sorting" id="bookmark-sort" href="javascript:sorting('bookmark')" style="font-size: 18px;color: black;">인기순</a>
               </div>
               </c:if>
               <c:forEach items="${storyList}" var="story">
                  <c:if test="${story.member.nickname!=sessionScope.mvo.nickname}">
                     <div class="col-md-3">
                        <article class="card" style="border: 1px solid #e9ebea; box-shadow: 10px 10px 5px #e9ebea;">
                           <figure class="card__feature story1249">
                              <div class="card__wrapper">
                                 <div class="storyPicture">
                                    <c:choose>
                                       <c:when test="${story.storyPictureUrl!=null}">
                                          <img src="upload/${story.storyPictureUrl}" class="card__img" alt="waves" width="275" height="240">
                                       </c:when>
                                       <c:otherwise>
                                          <img src="images/story-nopicture.png" class="card__img" alt="waves" width="275" height="240">
                                       </c:otherwise>
                                    </c:choose>
                                    <c:if test="${sessionScope.mvo.email!=null}">
                                       <c:choose>
                                          <c:when test="${story.bookmark=='false'}">
                                             <div class="bookmark">
                                                <img id="${story.storyNo}" src="${initParam.root}images/bookmarkOff_story.png" width="50" height="50" onclick="bookmark('story',${story.book.book_no},${story.storyNo})">
                                             </div>
                                          </c:when>
                                          <c:otherwise>
                                             <div class="bookmark">
                                                <img id="${story.storyNo}" src="${initParam.root}images/bookmarkOn_story.png" width="50" height="50" onclick="deleteBookmark('story',${story.book.book_no},${story.storyNo})">
                                             </div>
                                          </c:otherwise>
                                       </c:choose>
                                    </c:if>
                                 </div>

                                 <figcaption>
                                    <div class="card__box">
                                       <header class="card__item card__header">
                                          <p class="sb-letter-b">Story</p>
                                          <h6 class="card__item card__item--small card__label">${story.member.nickname}</h6>

                                          <c:choose>
                                             <c:when test="${sessionScope.mvo.email!=null}">
                                                <h2 class="card__item card__item--small card__title" >
                                                   <a href="showStory.do?book_no=${story.book.book_no}&&storyNo=${story.storyNo}&&email=${sessionScope.mvo.email}" style="font-size: 33px; font-family: 'Nanum Myeongjo'"><b>${story.storyTitle}</b></a>
                                                </h2>
                                             </c:when>
                                             <c:otherwise>
                                                <h2 class="card__item card__item--small card__title" style="font-size: 33px; font-family: 'Nanum Myeongjo'">
                                                   <a href="javascript:loginCheck()">${story.storyTitle}</a>
                                                </h2>
                                             </c:otherwise>
                                          </c:choose>
                                       </header>
                                       <section class="card__item card__body">
														<!-- ...추가 -->
														<c:choose>
															<c:when test="${fn:length(story.storyContent) > 14}">
																<p>
																	<c:out value="${fn:substring(story.storyContent,0,13)}" />
																	...
																</p>
															</c:when>
															<c:otherwise>
																<p>
																	<c:out value="${story.storyContent}" />
																</p>
															</c:otherwise>
														</c:choose>
														<!--  -->
													</section>
                                    </div>
                                    <span class="story-down">
                                       <span data-toggle="tooltip" data-placement="top" title="조회수"><i class="fa fa-eye"></i>&nbsp;${story.storyHit}&nbsp;</span>
                                       <span data-toggle="tooltip" data-placement="top" title="댓글수"><i class="fa fa-comments"></i>&nbsp;${story.countComment}</span>
                                    </span>
                                    <p>
                                 </figcaption>
                              </div>
                           </figure>
                        </article>
                     </div>
                  </c:if>
               </c:forEach>
            </div>
         </div>
      </c:when>
      <c:otherwise>
         <h2 align="center">공개된 스토리가 없습니다.</h2>
      </c:otherwise>
   </c:choose>

   <!-- --------------------------------------------- [끝] Story List--------------------------------------------- -->
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

   <!-- <script type="text/javascript" src="js/jquery.js"></script> -->
   <script type="text/javascript" src="js/bootstrap.min.js"></script>
   <script type="text/javascript" src="js/lightbox.min.js"></script>
   <script type="text/javascript" src="js/wow.min.js"></script>
   <script type="text/javascript" src="js/jquery.countTo.js"></script>
   <script type="text/javascript" src="js/main.js"></script>
</body>
</html>