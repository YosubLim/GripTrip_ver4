package spring.trip.controller;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Case;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import spring.trip.domain.Book;
import spring.trip.domain.Bookmark;
import spring.trip.domain.Member;
import spring.trip.domain.Story;
import spring.trip.model.service.BookService;
import spring.trip.model.service.BookmarkService;
import spring.trip.model.service.CommentService;
import spring.trip.model.service.MemberService;
import spring.trip.model.service.ReportService;
import spring.trip.model.service.StoryService;

@Controller
public class SearchController {
	@Autowired
	private BookService bookService;

	@Autowired
	private StoryService storyService;

	@Autowired
	private BookmarkService bookmarkService;
	
	@Autowired
	private CommentService commentService;
	
	@Autowired
	private MemberService memberService;

	@Autowired
	private ReportService reportService;

	@RequestMapping("search.do")
	public ModelAndView search(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {
		response.setContentType("text/html;charset=utf-8");
		Member member = (Member) session.getAttribute("mvo");
		String keyword = request.getParameter("keyword");
		String select = request.getParameter("select");
		keyword = URLDecoder.decode(keyword, "utf-8");
		List<Book> bookList = null;
		List<Story> storyList = null;
		ArrayList<Book> allBookList = new ArrayList<Book>();
		ArrayList<Story> allStoryList = new ArrayList<Story>();
		List<String> reportList = reportService.selectReport();

		// 키워드 trim
		String[] rkeyword = keyword.split(" ");
		System.out.println("search.do");

		for (String s : rkeyword) {
			if (request.getParameter("from").equals("all")) {
				if (select.equals("all")) {
					bookList = bookService.searchBook(s);
					storyList = storyService.searchStory(s);
				} else if (select.equals("title")) {
					bookList = bookService.searchBookByTitle(s);
					storyList = storyService.searchStoryByTitle(s);
				} else if (select.equals("content")) {
					bookList = bookService.searchBookByContent(s);
					storyList = storyService.searchStoryByContent(s);
				} else if (select.equals("location")) {
					bookList = bookService.searchBookByLocation(s);
					storyList = storyService.searchStoryByLocation(s);
				}
				// 북 북마크 설정, 닉네임 설정
				// 로그인 되어있을 때
				if (member != null) {
					List<Bookmark> bookmarkList = bookmarkService.myBookmark(member.getEmail());
					for (int i = 0; i < bookList.size(); i++) {
						bookList.get(i).setBookmark("false");
						String nick = bookService.getNickName(bookList.get(i).getBook_no());
						bookList.get(i).setNick(nick);
						for (int j = 0; j < bookmarkList.size(); j++) {
							if (bookmarkList.get(j).getBookNo() == bookList.get(i).getBook_no()
									&& bookmarkList.get(j).getStoryNo() == 0) {
								bookService.updateBookmark(bookList.get(i).getBook_no());
								bookList.get(i).setBookmark("true");
								System.out.println(bookList.get(i).getBookmark());
							}
						}
					}
					// 스토리 북마크, 닉네임 설정
					bookmarkList = bookmarkService.myBookmark(member.getEmail());
					for (int i = 0; i < storyList.size(); i++) {
						storyList.get(i).setBookmark("false");
						String nick = bookService.getNickName(storyList.get(i).getBook().getBook_no());
						storyList.get(i).getMember().setNickname(nick);
						for (int j = 0; j < bookmarkList.size(); j++) {
							if (bookmarkList.get(j).getBookNo() == storyList.get(i).getBook().getBook_no()
									&& bookmarkList.get(j).getStoryNo() == storyList.get(i).getStoryNo()) {
								storyService.updateStoryBookmark(Integer.toString(storyList.get(i).getStoryNo()));
								storyList.get(i).setBookmark("true");
							}
						} // for bookmarkList
					} // for storyList
				} else {
					for (int i = 0; i < bookList.size(); i++) {
						String nick = bookService.getNickName(bookList.get(i).getBook_no());
						bookList.get(i).setNick(nick);
					}
					for (int i = 0; i < storyList.size(); i++) {
						String nick = bookService.getNickName(storyList.get(i).getBook().getBook_no());
						storyList.get(i).getMember().setNickname(nick);
					}
				} // member가 null일 때
			} // from all일 때
			allBookList.addAll(bookList);
			allStoryList.addAll(storyList);
		} // keyword갯수만큼 for
		request.setAttribute("keyword", keyword);
		request.setAttribute("select", select);
		request.setAttribute("reportList", reportList);
		request.setAttribute("storyList", allStoryList);
		
		for (int i = 0; i < allBookList.size(); i++) {
			int book_no = allBookList.get(i).getBook_no();
			int storyCount = bookService.getStoryCountOfBook(book_no);
			allBookList.get(i).setStoryCount(storyCount);
		}
		for (int i = 0; i < allStoryList.size(); i++) {
			allStoryList.get(i).setStoryContent(allStoryList.get(i).getStoryContent().replaceAll("<br>", "\r\n"));
			// 서윤 추가
			int countComment = commentService.countComment(Integer.toString(allStoryList.get(i).getStoryNo()));
			allStoryList.get(i).setCountComment(countComment);
		}
		return new ModelAndView("book/allList", "bookList", allBookList);
	}// method

	   @RequestMapping("searchAgain.do")
	   public ModelAndView searchAgain(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	         throws Exception {
	      response.setContentType("text/html;charset=utf-8");
	      Member member = (Member) session.getAttribute("mvo");
	      String keyword = request.getParameter("keyword");
	      String select = request.getParameter("select");
	      keyword = URLDecoder.decode(keyword);
	      List<Book> bookList = null;
	      List<Story> storyList = null;
	      ArrayList<Book> allBookList = new ArrayList<Book>();
	      ArrayList<Story> allStoryList = new ArrayList<Story>();
	      List<String> reportList = reportService.selectReport();
	      int caseId = 0;
	      String sort = request.getParameter("sort");

	      System.out.println(select);
	      String[] rkeyword = keyword.split(" ");

	      for (String s : rkeyword) {
	         if (request.getParameter("from").equals("all")) {
	            if (select.equals("all")) {
	               switch (sort) {
	               case "new":
	                  bookList = bookService.searchBook(s);
	                  storyList = storyService.searchStory(s);
	                  break;
	               case "hit":
	                  bookList = bookService.searchBookOrderByHit(s);
	                  storyList = storyService.searchStoryOrderByHit(s);
	                  break;
	               case "bookmark":
	                  bookList = bookService.searchBookOrderByBookmark(s);
	                  storyList = storyService.searchStoryOrderByBookmark(s);
	                  break;
	               default:
	                  if (member == null) {
	                     return new ModelAndView("redirect:getAllList.do");
	                  } else {
	                     return new ModelAndView("redirect:getOtherBookList.do");
	                  }
	               }

	            } else if (select.equals("title")) {
	               switch (sort) {
	               case "new":
	                  bookList = bookService.searchBookByTitle(s);
	                  storyList = storyService.searchStoryByTitle(s);
	                  break;
	               case "hit":
	                  bookList = bookService.searchBookByTitleOrderByHit(s);
	                  storyList = storyService.searchStoryByTitleOrderByHit(s);
	                  break;
	               case "bookmark":
	                  bookList = bookService.searchBookByTitleOrderByBookmark(s);
	                  storyList = storyService.searchStoryByTitleOrderByBookmark(s);
	                  break;

	               default:
	                  if (member == null) {
	                     return new ModelAndView("redirect:getAllList.do");
	                  } else {
	                     return new ModelAndView("redirect:getOtherBookList.do");
	                  }
	               }

	            } else if (select.equals("content")) {
	               switch (sort) {
	               case "new":
	                  bookList = bookService.searchBookByContent(s);
	                  storyList = storyService.searchStoryByContent(s);
	                  break;
	               case "hit":
	                  bookList = bookService.searchBookByContentOrderByHit(s);
	                  storyList = storyService.searchStoryByContentOrderByHit(s);
	                  break;
	               case "bookmark":
	                  bookList = bookService.searchBookByContentOrderByBookmark(s);
	                  storyList = storyService.searchStoryByContentOrderByBookmark(s);
	                  break;

	               default:
	                  if (member == null) {
	                     return new ModelAndView("redirect:getAllList.do");
	                  } else {
	                     return new ModelAndView("redirect:getOtherBookList.do");
	                  }
	               }

	            } else if (select.equals("location")) {
	               switch (sort) {
	               case "new":
	                  bookList = bookService.searchBookByLocation(s);
	                  storyList = storyService.searchStoryByLocation(s);
	                  break;

	               case "hit":
	                  bookList = bookService.searchBookByLocationOrderByHit(s);
	                  storyList = storyService.searchStoryByLocationOrderByHit(s);
	                  break;
	               case "bookmark":
	                  bookList = bookService.searchBookByLocationOrderByBookmark(s);
	                  storyList = storyService.searchStoryByLocationOrderByBookmark(s);
	                  break;

	               default:
	                  if (member == null) {
	                     return new ModelAndView("redirect:getAllList.do");
	                  } else {
	                     return new ModelAndView("redirect:getOtherBookList.do");
	                  }
	               }
	            } else {
	               bookList = bookService.searchBook(s);
	               storyList = storyService.searchStory(s);
	            }
	            for (int i = 0; i < bookList.size(); i++) {
	               String nick = bookService.getNickName(bookList.get(i).getBook_no());
	               bookList.get(i).setNick(nick);
	            }
	            for (int i = 0; i < storyList.size(); i++) {
	               String nick = bookService.getNickName(storyList.get(i).getBook().getBook_no());
	               storyList.get(i).getMember().setNickname(nick);
	            }
	            caseId = 3;
	         } // from all일 때
	         else if (request.getParameter("from").equals("book")) {
	            if (select.equals("all")) {
	               switch (sort) {
	               case "new":
	                  bookList = bookService.searchBook(s);
	                  break;
	               case "hit":
	                  bookList = bookService.searchBookOrderByHit(s);
	                  break;
	               case "bookmark":
	                  bookList = bookService.searchBookOrderByBookmark(s);
	                  break;
	               default:
	                  bookList = bookService.searchBook(s);
	                  break;
	               }
	            } else if (select.equals("title")) {
	               switch (sort) {
	               case "new":
	                  bookList = bookService.searchBookByTitle(s);
	                  break;
	               case "hit":
	                  bookList = bookService.searchBookByTitleOrderByHit(s);
	                  break;
	               case "bookmark":
	                  bookList = bookService.searchBookByTitleOrderByBookmark(s);
	                  break;
	               default:
	                  bookList = bookService.searchBookByTitle(s);
	                  break;
	               }
	            } else if (select.equals("content")) {
	               switch (sort) {
	               case "new":
	                  bookList = bookService.searchBookByContent(s);
	                  break;
	               case "hit":
	                  bookList = bookService.searchBookByContentOrderByHit(s);
	                  break;
	               case "bookmark":
	                  bookList = bookService.searchBookByContentOrderByBookmark(s);
	                  break;
	               default:
	                  bookList = bookService.searchBookByContent(s);
	                  break;
	               }
	            } else if (select.equals("location")) {
	               switch (sort) {
	               case "new":
	                  bookList = bookService.searchBookByLocation(s);
	                  break;
	               case "hit":
	                  bookList = bookService.searchBookByLocationOrderByHit(s);
	                  break;
	               case "bookmark":
	                  bookList = bookService.searchBookByLocationOrderByBookmark(s);
	                  break;
	               default:
	                  bookList = bookService.searchBookByLocation(s);
	                  break;
	               }
	            } else {
	               bookList = bookService.searchBook(s);
	            }

	            // 닉네임 먹이기
	            for (int i = 0; i < bookList.size(); i++) {
	               String nick = bookService.getNickName(bookList.get(i).getBook_no());
	               bookList.get(i).setNick(nick);
	            }
	            // 로그인 유무 확인
	            if (member != null) {
	               List<Bookmark> bookmarkList = bookmarkService.myBookmark(member.getEmail());
	               for (int i = 0; i < bookList.size(); i++) {
	                  bookList.get(i).setBookmark("false");
	                  for (int j = 0; j < bookmarkList.size(); j++) {
	                     if (bookmarkList.get(j).getBookNo() == bookList.get(i).getBook_no()
	                           && bookmarkList.get(j).getStoryNo() == 0) {
	                        bookService.updateBookmark(bookList.get(i).getBook_no());
	                        bookList.get(i).setBookmark("true");
	                        System.out.println(bookList.get(i).getBookmark());
	                     } // if
	                  } // for
	               } // for
	            } // else
	            System.out.println("from book일 때: " + s);
	            caseId = 1;
	         } // from book일 때
	         else if (request.getParameter("from").equals("story")) {
	            if (select.equals("all") || select == null) {
	               switch (sort) {
	               case "new":
	                  storyList = storyService.searchStory(s);
	                  break;
	               case "hit":
	                  storyList = storyService.searchStoryOrderByHit(s);
	                  break;
	               case "bookmark":
	                  storyList = storyService.searchStoryOrderByBookmark(s);
	                  break;
	               default:
	                  storyList = storyService.searchStory(s);
	                  break;
	               }

	            } else if (select.equals("title")) {
	               switch (sort) {
	               case "new":
	                  storyList = storyService.searchStoryByTitle(s);
	                  break;
	               case "hit":
	                  storyList = storyService.searchStoryByTitleOrderByHit(s);
	                  // caseId=2;
	                  break;
	               case "bookmark":
	                  storyList = storyService.searchStoryByTitleOrderByBookmark(s);
	                  break;
	               default:
	                  storyList = storyService.searchStoryByTitle(s);
	                  break;
	               }

	            } else if (select.equals("content")) {
	               switch (sort) {
	               case "new":
	                  storyList = storyService.searchStoryByContent(s);
	                  break;
	               case "hit":
	                  storyList = storyService.searchStoryByContentOrderByHit(s);
	                  // caseId=2;
	                  break;
	               case "bookmark":
	                  storyList = storyService.searchStoryByContentOrderByBookmark(s);
	                  break;
	               default:
	                  storyList = storyService.searchStoryByContent(s);
	                  break;
	               }

	            } else if (select.equals("location")) {
	               switch (sort) {
	               case "new":
	                  storyList = storyService.searchStoryByLocation(s);
	                  break;
	               case "hit":
	                  storyList = storyService.searchStoryByLocationOrderByHit(s);
	                  // caseId=2;
	                  break;
	               case "bookmark":
	                  storyList = storyService.searchStoryByLocationOrderByBookmark(s);
	                  break;
	               default:
	                  storyList = storyService.searchStoryByLocation(s);
	                  break;
	               }

	            } else {
	               storyList = storyService.searchStory(s);
	            }
	            for (int i = 0; i < storyList.size(); i++) {
	               String nick = bookService.getNickName(storyList.get(i).getBook().getBook_no());
	               storyList.get(i).getMember().setNickname(nick);
	            }
	            // 로그인 유무 확인
	            if (member != null) {
	               List<Bookmark> bookmarkList = bookmarkService.myBookmark(member.getEmail());
	               for (int i = 0; i < storyList.size(); i++) {
	                  storyList.get(i).setBookmark("false");
	                  for (int j = 0; j < bookmarkList.size(); j++) {
	                     if (bookmarkList.get(j).getBookNo() == storyList.get(i).getBook().getBook_no()
	                           && bookmarkList.get(j).getStoryNo() == storyList.get(i).getStoryNo()) {
	                        storyService.updateStoryBookmark(Integer.toString(storyList.get(i).getStoryNo()));
	                        storyList.get(i).setBookmark("true");
	                     }
	                  } // for bookmarkList
	               } // for storyList
	            } // member가 null이 아닐 때
	            caseId = 2;
	         } // from story일 때
	         if (bookList != null)
	            allBookList.addAll(bookList);
	         if (storyList != null)
	            allStoryList.addAll(storyList);
	      } // for
	      if(member != null){
		      List<Bookmark> bookmarkList = bookmarkService.myBookmark(member.getEmail());
		      for (int i = 0; i < allBookList.size(); i++) {
		         allBookList.get(i).setBookmark("false");
		         for (int j = 0; j < bookmarkList.size(); j++) {
		            if (bookmarkList.get(j).getBookNo() == allBookList.get(i).getBook_no()
		                  && bookmarkList.get(j).getStoryNo() == 0) {
		               bookService.updateBookmark(allBookList.get(i).getBook_no());
		               allBookList.get(i).setBookmark("true");
		               System.out.println(allBookList.get(i).getBookmark());
		            }
		         }
		      }//로그인한 계정이 한 스토리북 북마크 리스트
		      for (int i = 0; i < allStoryList.size(); i++) {
		         allStoryList.get(i).setBookmark("false");
		         for (int j = 0; j < bookmarkList.size(); j++) {
		            if (bookmarkList.get(j).getBookNo() == allStoryList.get(i).getBook().getBook_no()
		                  && bookmarkList.get(j).getStoryNo() == allStoryList.get(i).getStoryNo()) {
		               storyService.updateStoryBookmark(Integer.toString(allStoryList.get(i).getStoryNo()));
		               allStoryList.get(i).setBookmark("true");
		            }
		         } // for bookmarkList
		      } //로그인한 계정이 한 스토리 북마크 리스트
	      }
	      request.setAttribute("keyword", keyword);
	      request.setAttribute("select", select);
	      request.setAttribute("reportList", reportList);
	      request.setAttribute("sort", sort);
	      //우정 추가
	      for (int i = 0; i < allBookList.size(); i++) {
	         int book_no = allBookList.get(i).getBook_no();
	         int storyCount = bookService.getStoryCountOfBook(book_no);
	         allBookList.get(i).setStoryCount(storyCount);
	         // System.out.println("book_no : " + book_no + ", storyCount : " +
	         // storyCount);
	      }
	      for (int i = 0; i < allStoryList.size(); i++) {
	         allStoryList.get(i).setStoryContent(allStoryList.get(i).getStoryContent().replaceAll("<br>", "\r\n"));
	         // 서윤 추가
	         int countComment = commentService.countComment(Integer.toString(allStoryList.get(i).getStoryNo()));
	         allStoryList.get(i).setCountComment(countComment);
	      }
	      switch (caseId) {
	      case 1:
	         return new ModelAndView("book/bookList", "bookList", allBookList);
	      case 2:
	         return new ModelAndView("story/storyListForSearch", "storyList", allStoryList);
	      case 3:
	         request.setAttribute("storyList", allStoryList);
	         return new ModelAndView("book/allList", "bookList", allBookList);
	      }
	      return null;
	   }// method
}
