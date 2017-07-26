<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

<!-- 2017-07-11 -->
<link href="css/font-awesome.min.css" rel="stylesheet">
<link rel="shortcut icon" href="images/ico/griptrip.ico">
<link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/apple-touch-icon-144-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/apple-touch-icon-114-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">
<link href="css/card.css" rel="stylesheet">
<link href="css/card-book.css" rel="stylesheet">
<link href="css/bookmark.css" rel="stylesheet">

<!-- Book 이미지 hover -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">

<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.js"></script>
<script type="text/javascript">
		$(function(){
    		$('#logoutA').click(function(){
    			if(confirm("로그아웃 하시겠습니까?")){
    	    		 alert("로그아웃되었습니다.")
    	    		 location.href="logout.do";
    	    	 }else{
    	    		 return;
    	    	 }
    		});
    		
    		$('[data-toggle="tooltip"]').tooltip();
		});
		/* deleteBookmark.do>Controller의 modelandview를 JsonView로 바꿔주세요. */
		function deleteBookmark(bookNo, storyNo) {
			//if(confirm("선택한 북마크를 삭제하시겠습니까?")){
				$(function() {
					$.ajax({
						type:"post",
						url:"deleteBookmark.do",
						data:"book_no="+bookNo+"&&storyNo="+storyNo,
						dataType:"json",
						
						success:function(data){
							location.reload();
						}//callback
					});//ajax
				});//function
  			//}
		}
	</script>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/jejugothic.css);
#page-breadcrumb, #avatar {
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
							<h1 class="title">북마크</h1>
							<p>회원님이 북마크하신 스토리북과 스토리들을 보실 수 있습니다.</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- --------------------------------------------- [끝] 제목 Section --------------------------------------------- -->
	<br><br>
	<c:choose>
		<c:when test="${bookList=='[]' && storyList=='[]'}">
		<section class="about" style="width: 100%; height: 350px; " >
	        <div class="container">
	           <div class="row center">
	           <br><br>
	              <div class="col-md-8 col-md-offset-2" align="center">
	                 <img src="images/bookmark.png"><br>
	              <br>
	              <a href="getOtherBookList.do" class="btn btn-common" style="width: 290px;">다른 사람들 스토리북 구경하기</a>
	              </div><br><br>
	           </div>
	        </div>
		 </section>
		</c:when>
		<c:otherwise>
			<!-- 2017-07-11 -->
			<c:if test="${bookList!=null}">
			<center><font size="30px" style="margin-top: 50px">BOOK</font></center>
			<div class="container" style="width: 85%;">
				<div class="row">
					<c:forEach items="${bookList}" var="book">
						<!-- book -->
						<div class="col-md-3">
							<article class="card-b"	style="border: 1px solid #e9ebea; box-shadow: 10px 10px 5px #e9ebea;">
								<figure class="card__feature-b book1249-b">
									<div class="card__wrapper-b">
										<div class="storyPicture-b">
											<img src="upload/${book.book_picture_url}" class="card__img-b" alt="Bridge" width="275" height="100%" style="object-fit: cover;">
											<div class="bookmark-b">
												<c:if test="${sessionScope.mvo.email!=null}">
													<div class="bookmark">
														<img id="0" src="${initParam.root}images/bookmarkOn_book.png" width="50" height="50" onclick="deleteBookmark(${book.book_no},0)">
													</div>
												</c:if>
											</div>
										</div>
										<figcaption>
											<div class="card__box-b">
												<header class="card__item-b card__header-b">
													<p class="sb-letter-b">Book</p>
													<h6 class="card__item-b card__item--small-b card__label-b">${book.nick}</h6>
													<!-- padding-top 추가(해상도에 따라서 달라짐) -->
													<h2 class="card__item-b card__item--small-b card__title-b bookTitle" style="font-size: 33px; font-family: 'Nanum Myeongjo'; padding-top: 20px;">
														<!-- 7/10 수정 -->
														<c:if test="${sessionScope.mvo!=null}">
															<a href="showStoryList.do?book_no=${book.book_no}&&email=${sessionScope.mvo.email}"><b>${book.book_title}</b></a>
														</c:if>
													</h2>
												</header>
												<div class="story-down-b">
			                                       <span data-toggle="tooltip" data-placement="top" title="조회수"> <i class="fa fa-eye"></i>&nbsp;${book.book_hit}&nbsp; </span>
			                                       <span data-toggle="tooltip" data-placement="top" title="스토리">  <i class="fa fa-file-image-o" aria-hidden="true"></i>&nbsp;${book.storyCount} </span>
			                                    </div>
											</div>
											<p>
										</figcaption>
									</div>
								</figure>
							</article>
						</div>
					</c:forEach>
				</div>
			</div>
			<br><br><br>
			</c:if>
			<!-- 북리스트 끝 -->
<br><br><br>
			<!-- 스토리 리스트 -->
			<!-- <h2 align="center" style="font-size: 30px;"><b>Story</b></h2> -->
			<c:if test="${storyList!='[]'}">
			<center><font size="30px">STORY</font></center>
			<div class="container" style="width: 85%;">
				<div class="row">
					<c:forEach items="${storyList}" var="story">
						<div class="col-md-3">
							<article class="card"
								style="border: 1px solid #e9ebea; box-shadow: 10px 10px 5px #e9ebea;">
								<figure class="card__feature story1249">
									<div class="card__wrapper">
										<div class="storyPicture">
											<c:choose>
												<c:when test="${story.storyPictureUrl!=null}">
													<img src="upload/${story.storyPictureUrl}" class="card__img" alt="waves" width="275" height="240">
												</c:when>
												<c:otherwise>
													<img src="images/img.png" class="card__img" alt="waves" width="275" height="240">
												</c:otherwise>
											</c:choose>
											<c:if test="${sessionScope.mvo.email!=null}">
												<div class="bookmark">
													<img id="${story.storyNo}" src="${initParam.root}images/bookmarkOn_story.png" width="50" height="50" onclick="deleteBookmark(${story.book.book_no},${story.storyNo})">
												</div>
											</c:if>
										</div>
										<figcaption>
											<div class="card__box">
												<header class="card__item card__header">
													<p class="sb-letter-b">Story</p>
													<h6 class="card__item card__item--small card__label">${story.member.nickname}</h6>
													<!-- padding-top 추가(해상도에 따라서 달라짐) -->
													<h2 class="card__item card__item--small card__title" style="font-size: 33px; font-family: 'Nanum Myeongjo'; padding-top: 20px;">
														<a href="showStory.do?book_no=${story.book.book_no}&&storyNo=${story.storyNo}&&email=${sessionScope.mvo.email}"><b>${story.storyTitle}</b></a>
													</h2>
												</header>
												<section class="card__item card__body">
												</section>
											</div>
											<span class="story-down">
		                                        <span data-toggle="tooltip" data-placement="top" title="조회수">  <i class="fa fa-eye"></i>&nbsp;${story.storyHit}&nbsp;</span>
		                                        <span data-toggle="tooltip" data-placement="top" title="댓글수"> <i class="fa fa-comments"></i>&nbsp;${story.countComment} </span>
		                                    </span>
											<p>
										</figcaption>
									</div>
								</figure>
							</article>
						</div>
					</c:forEach>
				</div>
			</div>
			<br><br><br>
		</c:if>
		</c:otherwise>
	</c:choose>
	<br/><br/><br/><br/><br/><br/>
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
	<!-- Book Image를 위한 부분입니다. -->
	<script>
	/* Modernizr 2.5.3 (Custom Build) | MIT & BSD
	 * Build: http://www.modernizr.com/download/#-csstransforms3d-shiv-cssclasses-teststyles-testprop-testallprops-prefixes-domprefixes-load
	 */
	;window.Modernizr=function(a,b,c){function z(a){j.cssText=a}function A(a,b){return z(m.join(a+";")+(b||""))}function B(a,b){return typeof a===b}function C(a,b){return!!~(""+a).indexOf(b)}function D(a,b){for(var d in a)if(j[a[d]]!==c)return b=="pfx"?a[d]:!0;return!1}function E(a,b,d){for(var e in a){var f=b[a[e]];if(f!==c)return d===!1?a[e]:B(f,"function")?f.bind(d||b):f}return!1}function F(a,b,c){var d=a.charAt(0).toUpperCase()+a.substr(1),e=(a+" "+o.join(d+" ")+d).split(" ");return B(b,"string")||B(b,"undefined")?D(e,b):(e=(a+" "+p.join(d+" ")+d).split(" "),E(e,b,c))}var d="2.5.3",e={},f=!0,g=b.documentElement,h="modernizr",i=b.createElement(h),j=i.style,k,l={}.toString,m=" -webkit- -moz- -o- -ms- ".split(" "),n="Webkit Moz O ms",o=n.split(" "),p=n.toLowerCase().split(" "),q={},r={},s={},t=[],u=t.slice,v,w=function(a,c,d,e){var f,i,j,k=b.createElement("div"),l=b.body,m=l?l:b.createElement("body");if(parseInt(d,10))while(d--)j=b.createElement("div"),j.id=e?e[d]:h+(d+1),k.appendChild(j);return f=["&#173;","<style>",a,"</style>"].join(""),k.id=h,(l?k:m).innerHTML+=f,m.appendChild(k),l||(m.style.background="",g.appendChild(m)),i=c(k,a),l?k.parentNode.removeChild(k):m.parentNode.removeChild(m),!!i},x={}.hasOwnProperty,y;!B(x,"undefined")&&!B(x.call,"undefined")?y=function(a,b){return x.call(a,b)}:y=function(a,b){return b in a&&B(a.constructor.prototype[b],"undefined")},Function.prototype.bind||(Function.prototype.bind=function(b){var c=this;if(typeof c!="function")throw new TypeError;var d=u.call(arguments,1),e=function(){if(this instanceof e){var a=function(){};a.prototype=c.prototype;var f=new a,g=c.apply(f,d.concat(u.call(arguments)));return Object(g)===g?g:f}return c.apply(b,d.concat(u.call(arguments)))};return e});var G=function(a,c){var d=a.join(""),f=c.length;w(d,function(a,c){var d=b.styleSheets[b.styleSheets.length-1],g=d?d.cssRules&&d.cssRules[0]?d.cssRules[0].cssText:d.cssText||"":"",h=a.childNodes,i={};while(f--)i[h[f].id]=h[f];e.csstransforms3d=(i.csstransforms3d&&i.csstransforms3d.offsetLeft)===9&&i.csstransforms3d.offsetHeight===3},f,c)}([,["@media (",m.join("transform-3d),("),h,")","{#csstransforms3d{left:9px;position:absolute;height:3px;}}"].join("")],[,"csstransforms3d"]);q.csstransforms3d=function(){var a=!!F("perspective");return a&&"webkitPerspective"in g.style&&(a=e.csstransforms3d),a};for(var H in q)y(q,H)&&(v=H.toLowerCase(),e[v]=q[H](),t.push((e[v]?"":"no-")+v));return z(""),i=k=null,function(a,b){function g(a,b){var c=a.createElement("p"),d=a.getElementsByTagName("head")[0]||a.documentElement;return c.innerHTML="x<style>"+b+"</style>",d.insertBefore(c.lastChild,d.firstChild)}function h(){var a=k.elements;return typeof a=="string"?a.split(" "):a}function i(a){var b={},c=a.createElement,e=a.createDocumentFragment,f=e();a.createElement=function(a){var e=(b[a]||(b[a]=c(a))).cloneNode();return k.shivMethods&&e.canHaveChildren&&!d.test(a)?f.appendChild(e):e},a.createDocumentFragment=Function("h,f","return function(){var n=f.cloneNode(),c=n.createElement;h.shivMethods&&("+h().join().replace(/\w+/g,function(a){return b[a]=c(a),f.createElement(a),'c("'+a+'")'})+");return n}")(k,f)}function j(a){var b;return a.documentShived?a:(k.shivCSS&&!e&&(b=!!g(a,"article,aside,details,figcaption,figure,footer,header,hgroup,nav,section{display:block}audio{display:none}canvas,video{display:inline-block;*display:inline;*zoom:1}[hidden]{display:none}audio[controls]{display:inline-block;*display:inline;*zoom:1}mark{background:#FF0;color:#000}")),f||(b=!i(a)),b&&(a.documentShived=b),a)}var c=a.html5||{},d=/^<|^(?:button|form|map|select|textarea)$/i,e,f;(function(){var a=b.createElement("a");a.innerHTML="<xyz></xyz>",e="hidden"in a,f=a.childNodes.length==1||function(){try{b.createElement("a")}catch(a){return!0}var c=b.createDocumentFragment();return typeof c.cloneNode=="undefined"||typeof c.createDocumentFragment=="undefined"||typeof c.createElement=="undefined"}()})();var k={elements:c.elements||"abbr article aside audio bdi canvas data datalist details figcaption figure footer header hgroup mark meter nav output progress section summary time video",shivCSS:c.shivCSS!==!1,shivMethods:c.shivMethods!==!1,type:"default",shivDocument:j};a.html5=k,j(b)}(this,b),e._version=d,e._prefixes=m,e._domPrefixes=p,e._cssomPrefixes=o,e.testProp=function(a){return D([a])},e.testAllProps=F,e.testStyles=w,g.className=g.className.replace(/(^|\s)no-js(\s|$)/,"$1$2")+(f?" js "+t.join(" "):""),e}(this,this.document),function(a,b,c){function d(a){return o.call(a)=="[object Function]"}function e(a){return typeof a=="string"}function f(){}function g(a){return!a||a=="loaded"||a=="complete"||a=="uninitialized"}function h(){var a=p.shift();q=1,a?a.t?m(function(){(a.t=="c"?B.injectCss:B.injectJs)(a.s,0,a.a,a.x,a.e,1)},0):(a(),h()):q=0}function i(a,c,d,e,f,i,j){function k(b){if(!o&&g(l.readyState)&&(u.r=o=1,!q&&h(),l.onload=l.onreadystatechange=null,b)){a!="img"&&m(function(){t.removeChild(l)},50);for(var d in y[c])y[c].hasOwnProperty(d)&&y[c][d].onload()}}var j=j||B.errorTimeout,l={},o=0,r=0,u={t:d,s:c,e:f,a:i,x:j};y[c]===1&&(r=1,y[c]=[],l=b.createElement(a)),a=="object"?l.data=c:(l.src=c,l.type=a),l.width=l.height="0",l.onerror=l.onload=l.onreadystatechange=function(){k.call(this,r)},p.splice(e,0,u),a!="img"&&(r||y[c]===2?(t.insertBefore(l,s?null:n),m(k,j)):y[c].push(l))}function j(a,b,c,d,f){return q=0,b=b||"j",e(a)?i(b=="c"?v:u,a,b,this.i++,c,d,f):(p.splice(this.i++,0,a),p.length==1&&h()),this}function k(){var a=B;return a.loader={load:j,i:0},a}var l=b.documentElement,m=a.setTimeout,n=b.getElementsByTagName("script")[0],o={}.toString,p=[],q=0,r="MozAppearance"in l.style,s=r&&!!b.createRange().compareNode,t=s?l:n.parentNode,l=a.opera&&o.call(a.opera)=="[object Opera]",l=!!b.attachEvent&&!l,u=r?"object":l?"script":"img",v=l?"script":u,w=Array.isArray||function(a){return o.call(a)=="[object Array]"},x=[],y={},z={timeout:function(a,b){return b.length&&(a.timeout=b[0]),a}},A,B;B=function(a){function b(a){var a=a.split("!"),b=x.length,c=a.pop(),d=a.length,c={url:c,origUrl:c,prefixes:a},e,f,g;for(f=0;f<d;f++)g=a[f].split("="),(e=z[g.shift()])&&(c=e(c,g));for(f=0;f<b;f++)c=x[f](c);return c}function g(a,e,f,g,i){var j=b(a),l=j.autoCallback;j.url.split(".").pop().split("?").shift(),j.bypass||(e&&(e=d(e)?e:e[a]||e[g]||e[a.split("/").pop().split("?")[0]]||h),j.instead?j.instead(a,e,f,g,i):(y[j.url]?j.noexec=!0:y[j.url]=1,f.load(j.url,j.forceCSS||!j.forceJS&&"css"==j.url.split(".").pop().split("?").shift()?"c":c,j.noexec,j.attrs,j.timeout),(d(e)||d(l))&&f.load(function(){k(),e&&e(j.origUrl,i,g),l&&l(j.origUrl,i,g),y[j.url]=2})))}function i(a,b){function c(a,c){if(a){if(e(a))c||(j=function(){var a=[].slice.call(arguments);k.apply(this,a),l()}),g(a,j,b,0,h);else if(Object(a)===a)for(n in m=function(){var b=0,c;for(c in a)a.hasOwnProperty(c)&&b++;return b}(),a)a.hasOwnProperty(n)&&(!c&&!--m&&(d(j)?j=function(){var a=[].slice.call(arguments);k.apply(this,a),l()}:j[n]=function(a){return function(){var b=[].slice.call(arguments);a&&a.apply(this,b),l()}}(k[n])),g(a[n],j,b,n,h))}else!c&&l()}var h=!!a.test,i=a.load||a.both,j=a.callback||f,k=j,l=a.complete||f,m,n;c(h?a.yep:a.nope,!!i),i&&c(i)}var j,l,m=this.yepnope.loader;if(e(a))g(a,0,m,0);else if(w(a))for(j=0;j<a.length;j++)l=a[j],e(l)?g(l,0,m,0):w(l)?B(l):Object(l)===l&&i(l,m);else Object(a)===a&&i(a,m)},B.addPrefix=function(a,b){z[a]=b},B.addFilter=function(a){x.push(a)},B.errorTimeout=1e4,b.readyState==null&&b.addEventListener&&(b.readyState="loading",b.addEventListener("DOMContentLoaded",A=function(){b.removeEventListener("DOMContentLoaded",A,0),b.readyState="complete"},0)),a.yepnope=k(),a.yepnope.executeStack=h,a.yepnope.injectJs=function(a,c,d,e,i,j){var k=b.createElement("script"),l,o,e=e||B.errorTimeout;k.src=a;for(o in d)k.setAttribute(o,d[o]);c=j?h:c||f,k.onreadystatechange=k.onload=function(){!l&&g(k.readyState)&&(l=1,c(),k.onload=k.onreadystatechange=null)},m(function(){l||(l=1,c(1))},e),i?k.onload():n.parentNode.insertBefore(k,n)},a.yepnope.injectCss=function(a,c,d,e,g,i){var e=b.createElement("link"),j,c=i?h:c||f;e.href=a,e.rel="stylesheet",e.type="text/css";for(j in d)e.setAttribute(j,d[j]);g||(n.parentNode.insertBefore(e,n),m(c,0))}}(this,document),Modernizr.load=function(){yepnope.apply(window,[].slice.call(arguments,0))};
	</script>
	
	<div class="col-md-12">
         <img src="images/home/footer.png" class="img-responsive inline" alt="" style="position: absolute; bottom: 0px; z-index: -1; min-width: 100%; margin-left: -13px; height: 600px;">
   </div>
</body>
</html>