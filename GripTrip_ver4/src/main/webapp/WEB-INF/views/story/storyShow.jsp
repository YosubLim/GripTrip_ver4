<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
   //치환 변수 선언
    pageContext.setAttribute("cr", "\r"); //Space
    pageContext.setAttribute("cn", "\n"); //Enter
    pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
    pageContext.setAttribute("br", "<br/>"); //br 태그
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.js"></script>
	<link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/lightbox.css" rel="stylesheet"> 
    <link href="css/animate.min.css" rel="stylesheet"> 
	<link href="css/story/story2.css?ver=1" rel="stylesheet">
	<link href="css/responsive.css" rel="stylesheet">
	<link href="css/main.css" rel="stylesheet">
	<link href="css/story/style.css" rel="stylesheet">
	<link rel="shortcut icon" href="images/ico/griptrip.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">
    
    
<script type="text/javascript">
$(function(){	
      $('.updateComment').hide();
      $('.reComment').hide();
      
	   // 로그아웃 버튼 클릭 시 confirm
	  	$('#logoutA').click(function(){
	  		if(confirm("로그아웃 하시겠습니까?")){
	      		 alert("로그아웃되었습니다.")
	      		 location.href="logout.do";
	      	 }else{
	      		 return;
	      	 }
	  	});
	   
	   // 스토리 리스트 돌아가기
	  $('#storyListBtn').click(function () {
	          location.href="showStoryList.do?book_no=${story.book.book_no}&&email=${sessionScope.mvo.email}";
	  });//click
      
      // 스토리 삭제
      $('#storyDeleteBtn').click(function(){
         if(confirm("정말로 삭제하시겠습니까?")){
            location.href="deleteStory.do?storyNo=${story.storyNo}&&book_no=${story.book.book_no}";
         }
      }); // click()
      
      
      // 스토리 수정
      $('#storyUpdateBtn').click(function(){
         location.href="showUpdate.do?storyNo=${story.storyNo}&&book_no=${story.book.book_no}";         
      }); // click()
      
      
      // 댓글 쓰기
      $('#writeCommentForm').submit(function(){
         return true;
      }); // submit() 
      
      
      // 답글 쓰기 버튼 클릭
      $('a.recommentA').click('click', function(){
		$(this).parent().parent().hide();
		$(this).parent().parent().parent().parent().parent().find('.reComment').show();
      }); // click()
      
      // 리댓에서의 답글 쓰기 버튼 클릭
      $('a.recommentB').click('click', function(){
  		$(this).parent().parent().hide();
  		$(this).parent().parent().parent().parent().parent().parent().find('.reComment').show();
        }); // click()
      
      
      // 답글 취소 버튼 클릭
      $('.cancelRecommentA').click(function(){
		$(this).parent().parent().parent().hide();
		$(this).parent().parent().children().prev('.post-comment').show();
		$(this).parent().parents().children('.post-comment').children().find('ul').show();
      }); // click();
      
      
    
      // 댓글 수정 버튼 클릭
      $('.commentUpdateA').click(function(){
		var content = $(this).parent().parents().prev('#comment').text();
		
		$(this).parent().parent().parent().hide();
		$(this).parent().parent().parent().parent().next('.updateComment').show();
		$(this).parent().parent().parent().parent().next().find('textarea').val(content);
      });
      
      $('.commentUpdateB').click(function(){
  		var content = $(this).parents().prev('#comment').text();

  		$(this).parent().parent().parent().parent().hide();
  		$(this).parent().parent().parent().parent().parent().next('.updateComment').show();
  		$(this).parent().parent().parent().parent().parent().next().find('textarea').val(content);
        });
      
      // 댓글 수정 취소
      $('.cancelUpdateCommentBtn').click(function(){
		$(this).parent().parent().parent().hide();
		$(this).parents().find('.post-comment').children().show();
      });

      if(${story.bookmark==false}){
          $('#bookmarkDelete').hide();
       }else{
          $('#bookmarkInsert').hide();
       }
     });
     
     //function>북마크, 해제 버튼 북마크 상황에 맞게 받아오기  
  	function bookmark(bno, sno){
        $(function() {
           $.ajax({
              type:"post",
              url:"insertBookmark.do",
              data:"book_no="+bno+"&&storyNo="+sno,
              dataType:"json",
              
              success:function(data){
                 $('#bookmarkInsert').hide();
                 $('#bookmarkDelete').show();
                 }//callback
             });//ajax
          });//function
       }//function>bookmark
     function deleteBookmark(bno, sno){
          $(function() {
             $.ajax({
               type:"post",
               url:"storyDeleteBookmark.do",
               data:"book_no="+bno+"&&storyNo="+sno,
               dataType:"json",
               
               success:function(data){
                  $('#bookmarkDelete').hide();
                  $('#bookmarkInsert').show();
               }//callback
             });//ajax
          });//function
       }
</script>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/jejugothic.css);
h1, h2, #page-breadcrumb, #blog-details, #avatar {
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
							<h1 class="title">스토리 페이지</h1>
							<p>스토리의 상세 정보입니다.</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- --------------------------------------------- [끝] 제목 Section --------------------------------------------- -->
      <br><br><br>
	<section id="blog-details" >
        <div class="container">
              <div class="single-blog" id="storyDetail">
                  <div class="post-thumb">
                    <c:if test="${story.storyPictureUrl!=null}">
                      <img src="upload/${story.storyPictureUrl}" style="width: 900px; height: 400px;">
                      <div class="post-overlay">
                         <c:choose>
                         <c:when test="${story.storyTripDate==null}">
                             <span class="uppercase">
                             <br><br><br>
                             <font style="color: white;" class="storyDate">&nbsp;${story.storyCreateDate}</font></span>
                          </c:when>
                          <c:otherwise>
                             <span class="uppercase">
                             <br><br><br>
                             <font style="color: white;">&nbsp;${story.storyTripDate}</font></span>
                          </c:otherwise>
                          </c:choose>
                      </div>
                       </c:if>
                  </div>
                  <div class="post-content overflow">
                  <h2 class="post-title bold">${story.storyTitle}</h2>
                      <h5 class="post-author"><font style="color: #0099ae; font-family: 'Jeju Gothic';">Posted by ${nickname}</font></h5>
                      <c:if test="${story.storyLocation!=null}">
                      at ${story.storyLocation}<br>
                      </c:if>
                      <br>
                      ${fn:replace(story.storyContent, cn, br)}
                      <%-- <c:if test="${fn:length(story.storyContent)>50}">
	                      <c:forEach begin="0" end="${fn:length(story.storyContent)-1}" varStatus="status">
		                      <c:set value="${status.count mod 50}" var="remain"/>
								<c:if test="${remain==0}">
									<c:out value="${fn:substring(story.storyContent,(status.count/50-1)*50, status.index)}" />
									50자<br>
								</c:if>
		                  </c:forEach>
	                  </c:if>
                      <c:if test="${fn:length(story.storyContent)<50}">
						${story.storyContent}
					  </c:if> --%>
					  ${story.storyContent }
                      <div class="post-bottom overflow">
                        <ul class="nav navbar-nav post-nav">
                             <c:if test="${sessionScope.mvo.email!=null}">
								<li style="color:#0099ae;" onclick="bookmark(${story.book.book_no},${story.storyNo})" id="bookmarkInsert"><i class="fa fa-bookmark-o"></i>&nbsp;&nbsp;bookmark</li>
								<li style="color:#0099ae;" onclick="deleteBookmark(${story.book.book_no},${story.storyNo})" id="bookmarkDelete"><i class="fa fa-bookmark"></i>&nbsp;&nbsp;bookmark</li>
							</c:if>
                             <li><font style="color: #0099ae;">${story.storyHit} hits</font></li>
                              <li style="color:#0099ae;"><i class="fa fa-comments"></i>&nbsp;&nbsp;${countComment} Comments</li>
                              <c:if test="${sessionScope.mvo.email==story.member.email}">
                              <li><a href="#" id="storyUpdateBtn"><i class="fa fa-pencil"></i>수정</a></li>
                              <li><a href="#" id="storyDeleteBtn"><i class="fa fa-trash"></i>삭제</a></li>
                                 <c:if test="${story.storyIsPublic=='private'}">
                                        <li><i class="fa fa-lock" aria-hidden="true" style="color:#0099ae;"></i></li>
                                 </c:if>
                              </c:if>
                              <li><a href="#" id="storyListBtn"><i class="fa fa-undo"></i>Story List</a></li>
                        </ul>
                        </div>
                           <br><br>
                        <div class="response-area">
						<h2 class="bold">Comments</h2>
						<ul class="media-list">
							<li class="media">
								<div>
                          			<c:choose>
               							<c:when test="${requestScope.cList != null}">
               								<c:forEach var="comment" items="${requestScope.cList}" varStatus="i">
               									<div class="all-comment">
				                              	<div class="post-comment" style="padding-left: 10px; padding-top: 10px;">
				                              		<c:choose>
				                              			<c:when test="${comment.depth==0}">
				                              				<span class="media-body">
				                           						<span><i class="fa fa-user"></i>Posted by <a href="#">${comment.member.nickname}</a></span>
				                           						<p id="comment">
				                                   				<c:if test="${comment.commentIsPublic=='private'}">
					                                      			<a href="#">
					                                      				<i class="fa fa-lock" aria-hidden="true"></i>
					                                      			</a>
				                                     			</c:if>
                                      							&nbsp;${comment.commentContent}</p>
                                     							<ul class="nav navbar-nav post-nav">
				                                       				<li><a href="#"><i class="fa fa-clock-o"></i>${comment.commentCreateDate}</a></li>
				                                        			<li><a class="recommentA"><i class="fa fa-reply"></i>Reply</a></li>
				                                     				<c:if test="${comment.member.email == sessionScope.mvo.email}">
								                            			<li><a class="commentUpdateA"><i class="fa fa-pencil"></i>수정</a></li>
								                            			<li><a href="removeComment.do?commentNo=${comment.commentNo}&&storyNo=${comment.story.storyNo}&&book_no=${story.book.book_no}"><i class="fa fa-trash"></i>삭제</a></li>
			                          								</c:if>
				                                    			</ul>
				                                			</span>
				                              			</c:when>
				                              			<c:otherwise>
				                              				<div class="media-body">
				                              				<div class="col-md-1">
				                              					<c:forEach begin="1" end="${comment.depth}"></c:forEach>
				                              				</div>
				                              				<div class="col-md-11">
					                           						<span><i class="fa fa-user"></i>Posted by <a href="#">${comment.member.nickname}</a></span>
					                           						<p id="comment">
					                                   				<c:if test="${comment.commentIsPublic=='private'}">
						                                      			<a href="#">
						                                      				<i class="fa fa-lock" aria-hidden="true"></i>
						                                      			</a>
					                                     			</c:if>
	                                      							&nbsp;${comment.commentContent}</p>
	                                     							<ul class="nav navbar-nav post-nav">
					                                       				<li><a href="#"><i class="fa fa-clock-o"></i>${comment.commentCreateDate}</a></li>
					                                        			<li><a class="recommentB"><i class="fa fa-reply"></i>Reply</a></li>
					                                     				<c:if test="${comment.member.email == sessionScope.mvo.email}">
									                            			<li><a class="commentUpdateB"><i class="fa fa-pencil"></i>수정</a></li>
									                            			<li><a href="removeComment.do?commentNo=${comment.commentNo}&&storyNo=${comment.story.storyNo}&&book_no=${story.book.book_no}"><i class="fa fa-trash"></i>삭제</a></li>
				                          								</c:if>
					                                    			</ul>
				                              				</div>
				                              				</div>
				                              			</c:otherwise>
				                              			
				                              		</c:choose>
				                            	</div>
				                          		<div class="updateComment">
						                         	<form action="updateComment.do" method="post">
							                       		<input type="hidden" name="storyNo" value="${story.storyNo}">
							                       		<input type="hidden" name="commentNo" value="${comment.commentNo}">
							                      		<input type="hidden" name="book_no" value="${story.book.book_no}">
							                      		
							                      		<div class="comments">
								                    	<div class="row" style="width: 700px;">
															<div class="col-md-2">
																${comment.member.nickname}
															</div>
															<div class="col-md-10">
																<div class="comment1"><textarea name="commentContent" rows="3" cols="63" style="border-style: hidden;"></textarea></div>
																	<c:choose>
							                       						<c:when test="${comment.commentIsPublic == 'public'}">
							                       							<div style="margin: 12px; margin-left: 20px;">
																			<input type="radio" name="commentIsPublic" value="public" checked/>&nbsp;공개
																			&nbsp;&nbsp;
																			<input type="radio" name="commentIsPublic" value="private"/>&nbsp;비공개
																			</div>
							                                   			</c:when>
							                      						<c:otherwise>
							                               					<div style="margin: 12px; margin-left: 20px;">
																			<input type="radio" name="commentIsPublic" value="public"/>&nbsp;공개
																			&nbsp;&nbsp;
																			<input type="radio" name="commentIsPublic" value="private" checked/>&nbsp;비공개
																			</div>
							                              				</c:otherwise>
							                           				</c:choose>
								                   				<div style="margin-left: 346px; margin-top: -45px;">
																	<input class="btn btn-common updateCommentBtn" type="submit" value="수정" style="width: 100px; background: white;">
									                   				<input class="btn btn-common cancelUpdateCommentBtn" value="취소" style="width: 100px; background: white;">
								                   				</div>
															</div>
														</div>
													</div>
						                        	</form>
						                        </div>
					                        	<div class="reComment">
						                        	<form action="writeRecomment.do" method="post" class="recommentFrm">
							                           <input type="hidden" name="lineNo" value="${i.index}">
							                           <input type="hidden" name="storyNo" value="${comment.story.storyNo}">
							                           <input type="hidden" name="parentCommentNo" value="${comment.commentNo}">
							                           <input type="hidden" name="parentCommentEmail" value="${comment.member.nickname}">
							                           <input type="hidden" name="groupId" value="${comment.groupId}">
							                           <input type="hidden" name="orderId" value="${comment.orderId}">
							                           <input type="hidden" name="depth" value="${comment.depth}">
						                        		<div class="comments">
								                    	<div class="row">
															<div class="col-md-1">
																re:
															</div>
															<div class="col-md-11">
																<div class="comment1"><textarea name="commentContent" rows="3" cols="58" style="border-style: hidden;"></textarea></div>
																	<div style="margin: 12px; margin-left: 20px;">
																	<input type="radio" name="commentIsPublic" value="public" checked/>&nbsp;공개
																	&nbsp;&nbsp;
																	<input type="radio" name="commentIsPublic" value="private"/>&nbsp;비공개
																	</div>
																<div style="margin-left: 305px; margin-top: -45px;">
																	<input class="btn btn-common" type="submit" value="등록" style="width: 100px; background: white;">
									                   				<input class="btn btn-common cancelRecommentA" value="취소" style="width: 100px; background: white;">
								                   				</div>
															</div>
														</div>
													</div>
						                        	</form>
						                       	</div>
				                            	</div>
                              				</c:forEach>
                              			</c:when>
                              		</c:choose>
                              	</div>
                          	</li>
                      	</ul>                   
                  	</div><!--/Response-area-->

                  	<!-- 로그인 했을 경우만 댓글 작성가능 -->
            <c:if test="${sessionScope.mvo != null}">
            	<form action="writeComment.do" method="post">
					<input type="hidden" name="storyNo" value="${story.storyNo}">
					<input type="hidden" name="depth" value="0">
					<input type="hidden" name="orderId" value="1">
                     
                    <div class="comments">
                    	<div class="row" style="width: 700px;">
							<div class="col-md-2">
								${sessionScope.mvo.nickname}
							</div>
							<div class="col-md-10">
								<div class="comment1"><textarea name="commentContent" rows="3" cols="63" style="border-style: hidden;"></textarea></div>
								<div style="margin: 12px; margin-left: 20px;">
									<input type="radio" name="commentIsPublic" value="public" checked/>&nbsp;공개
									&nbsp;&nbsp;
									<input type="radio" name="commentIsPublic" value="private"/>&nbsp;비공개
								</div>
								<div style="margin-top: -45px;">
								<input class="btn btn-common" type="submit" id="writeBtn" value="등록" style="width: 100px;margin-left: 450px; background: white;">
								</div>
							</div>
						</div>
					</div>
            	</form>
            </c:if>
                  </div>
              </div>
          </div>
    </section>
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