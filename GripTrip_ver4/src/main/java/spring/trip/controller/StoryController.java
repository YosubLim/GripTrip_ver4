package spring.trip.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import spring.trip.domain.Book;
import spring.trip.domain.Bookmark;
import spring.trip.domain.Comment;
import spring.trip.domain.Member;
import spring.trip.domain.Story;
import spring.trip.model.service.BookService;
import spring.trip.model.service.BookmarkService;
import spring.trip.model.service.CommentService;
import spring.trip.model.service.MemberService;
import spring.trip.model.service.StoryService;

@Controller
public class StoryController {
	@Autowired
	private StoryService storyService;
	@Autowired
	private BookService bookService;
	@Autowired
	private CommentService commentService;
	@Autowired
	private MemberService MemberService;
	@Autowired
	private BookmarkService bookmarkService;
	
	//스토리 추가하기 클릭시 거치는 컨트롤러
	@RequestMapping("storyWrite.do")
	public ModelAndView storyWrite(HttpServletRequest request, HttpServletResponse response, Story story) throws Exception{
		System.out.println("북넘버 "+request.getParameter("book_no"));
		int no= Integer.parseInt(request.getParameter("book_no"));
		Book book = bookService.getBookByBookNo(no);
		return new ModelAndView("story/storyWrite","book_no", book.getBook_no());
	}
	
	//스토리 작성하기 클릭시 거치는 컨트롤러
    @RequestMapping("insertStoryInfo.do")
	public ModelAndView insertStoryInfo(HttpServletRequest request, HttpServletResponse response, HttpSession session, Story story) throws Exception{
		Member member = (Member)session.getAttribute("mvo"); //나중에 수정
	   	story.setMember(member);
	   	int book_no = Integer.parseInt(request.getParameter("book_no"));
	   	story.setBook(bookService.getBookByBookNo(book_no));

	   	storyService.uploadStoryPhoto(story);
		storyService.insertStoryInfo(story);
	   	System.out.println(story);
	   	
	   	return new ModelAndView("redirect:showStory.do?storyNo="+story.getStoryNo()+"&&book_no="+book_no);      
	}
    
    //스토리 삭제 컨트롤러
	@RequestMapping("deleteStory.do")
	public ModelAndView deleteStory(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String[] storyArr = request.getParameter("storyNo").split("-");
		
		if(storyArr != null && storyArr.length>0){
		       for(int i=0 ; i<storyArr.length ; i++){ 
		    	   System.out.println(storyArr[i]);
		    	   storyService.deleteStory(storyArr[i]);
		    	   bookmarkService.deleteBookmarkByStoryNo(storyArr[i]);
		       }
			}  
		request.setAttribute("book_no", request.getParameter("book_no"));
		return new ModelAndView("redirect:showStoryList.do?book_no="+request.getParameter("book_no"));
	}
	
	//하나의 스토리를 보여주는 컨트롤러
	@RequestMapping("showStory.do")
	   public ModelAndView showStory(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
	         String storyNo = request.getParameter("storyNo");
	         
	         Story story = storyService.getStoryByStoryNo(storyNo);
	         
	         //북마크 부분
		     int book_no= Integer.parseInt(request.getParameter("book_no"));
		     Member member = (Member)session.getAttribute("mvo");
		     List<Bookmark> bookmarkList = bookmarkService.myBookmark(member.getEmail());
	         story.setBookmark("false");//북마트의 디폴트 값은 false로 한다..북마크 체크 안되있다는 것
		     
	         for(int i=0; i<bookmarkList.size(); i++){//로그인한 계정의 북마크 리스트를 돌면서
	        	 //계정의 북마크 리스트에 있는 북넘버와 현재 보여지는 스토리의 북넘버가 같고, 스토리넘버도 같다면
		    	  if(bookmarkList.get(i).getBookNo()==book_no && bookmarkList.get(i).getStoryNo()==(Integer.parseInt(storyNo))){
					storyService.updateStoryBookmark(Integer.toString(story.getStoryNo()));
					story.setBookmark("true");//북마크 추가된 것.. true
					break; //로그인한 계정의 북마크 리스트를 돌다가 현재 보려는 스토리의 넘버가 북마크 체크된 스토리라면 for문 break! 이 부분은 제가 생각해도 좀 복잡하니까 이해안가시면 질문주세요ㅠ
		    	  }else{	
		    		  	//그렇지 않다면, false
						storyService.deleteStoryBookmark(Integer.toString(story.getStoryNo()));
						story.setBookmark("false");
		    	  }
		      }	      
		      // 댓글 가져오는 부분 추가
	          Story story2 = new Story();
	          story2.setBook(new Book());
	          story2.setMember(story.getMember());
	          story2.setStoryNo(story.getStoryNo());
	          
		      String loginEmail = "";
		      Member loginMember = (Member) request.getSession().getAttribute("mvo"); // 로그인 되어 있는 사람
		      if(loginMember != null)
		         loginEmail = loginMember.getEmail(); // 로그인한 애 이멜
		      String storyEmail = story.getMember().getEmail(); // 스토리 주인 이멜
		    
		      if(!loginEmail.equals(storyEmail)){
		         story2.setMember(loginMember);
		      }      
		      List<Comment> cList = commentService.showAllVisibleCommentsOfStory(story2);
		      for(int i=0; i<cList.size(); i++){//코멘트 목록을 돌면서 email로 찾아온 멤버 객체의 닉네이름을 cList의 멤버에 먹임
		    	  Member cMember = MemberService.showMemberInfo(cList.get(i).getMember().getEmail());
		    	  cList.get(i).getMember().setNickname(cMember.getNickname());
		      }
		      request.setAttribute("cList", cList);
		      
		      //story.setStoryContent(story.getStoryContent().replaceAll("\r\n", "<br>"));	      
		      
		      //nick 받아오기
		      Member rMember = MemberService.showMemberInfo(storyEmail);
		      story.getMember().setNickname(rMember.getNickname());
		      request.setAttribute("nickname", story.getMember().getNickname());
		     
		      //댓글 갯수 -- 서윤 추가
		      int countComment = commentService.countComment(storyNo);
		      request.setAttribute("countComment", countComment);

	          return new ModelAndView("story/storyShow", "story", story);   
	}
	
	//수정 완료 버튼 클릭시 거치는 컨트롤러
	@RequestMapping("updateStory.do")
	public ModelAndView updateStory(HttpServletRequest request, HttpServletResponse response, HttpSession session, Story story) throws Exception{
		Member member = (Member)session.getAttribute("mvo");
		int book_no = Integer.parseInt(request.getParameter("book_no"));
		System.out.println("updateStory "+ book_no);
	   	story.setBook(bookService.getBookByBookNo(book_no));
		
	   	storyService.uploadStoryPhoto(story);
		storyService.updateStory(story);
		
		return new ModelAndView("redirect:showStory.do?storyNo="+story.getStoryNo()+"&&book_no="+book_no);
	}
	
	//스토리 목록 보여주는 컨트롤러
	@RequestMapping("showStoryList.do")
	   public ModelAndView showStoryList(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		  Member member = (Member)session.getAttribute("mvo");
		  List<Story> storyList = storyService.showStoryList(request.getParameter("book_no"));
		  String email = bookService.getEmailByBookNo(Integer.parseInt(request.getParameter("book_no")));
		  
	      for(int i=0; i<storyList.size(); i++){ 
	    	 Member rMember = MemberService.showMemberInfo(email);
	    	 storyList.get(i).getMember().setNickname(rMember.getNickname());
	         storyList.get(i).setStoryContent(storyList.get(i).getStoryContent().replaceAll("\r\n", "<br>"));
	        
	         //서윤 추가
	         int countComment = commentService.countComment(Integer.toString(storyList.get(i).getStoryNo()));
	         storyList.get(i).setCountComment(countComment);
	      }
	      request.setAttribute("book_no", request.getParameter("book_no"));
	      request.setAttribute("email", email);
	      
	      //서윤언니 추가...BookUrl
          Book book = bookService.getBookByBookNo(Integer.parseInt(request.getParameter("book_no")));
          request.setAttribute("bookPicture", book.getBook_picture_url());
          
          // 우정 추가 0707
          if(storyList.size() == 0){	// 스토리 없는 경우
        	  request.setAttribute("storyExists", false);
        	  request.setAttribute("email", email);
        	  if(email.equals(member.getEmail())){
        		  return new ModelAndView("book/afterInsertBook", "book", book);
        	  }else{
        		  request.setAttribute("book", book);
        		  request.setAttribute("email", email);
        		  return new ModelAndView("story/storyList", "storyList", storyList);
        	  }
          }else{ // 스토리 하나라도 있는 경우
        	  //7.11
        	  request.setAttribute("book", book);
        	  return new ModelAndView("story/storyList", "storyList", storyList);
          }
	   }
	
	//스토리 수정하기 눌렀을때 storyUpdate 뷰페이지로 넘어가기 전 컨트롤러
	@RequestMapping("showUpdate.do")
	public ModelAndView showUpdate(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String storyNo = request.getParameter("storyNo");
		String book_no = request.getParameter("book_no");
		System.out.println("showUpdate "+ book_no);
		Story story = storyService.getStoryByStoryNo(storyNo);
		request.setAttribute("book_no", book_no);
		
		return new ModelAndView("story/storyUpdate", "story", story);   
	}
	//첨부된 파일 삭제 컨르롤러	
	@RequestMapping("fileDelete.do")
	public ModelAndView fileDelete(HttpServletRequest request, HttpServletResponse response,Story story) throws Exception{
		String storyPictureUrl = request.getParameter("storyPictureUrl");
		String storyNo = request.getParameter("storyNo");
		if(storyPictureUrl!=null){
			storyService.fileDelete(storyPictureUrl);
			storyService.deleteUrl(storyNo);//null
			System.out.println(story.getStoryPictureUrl());	
		}
		return new ModelAndView("JsonView");
	}
}