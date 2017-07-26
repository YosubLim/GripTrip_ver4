package spring.trip.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import spring.trip.domain.Book;
import spring.trip.domain.Bookmark;
import spring.trip.domain.Member;
import spring.trip.domain.Story;
import spring.trip.domain.Write;
import spring.trip.model.service.BookService;
import spring.trip.model.service.BookmarkService;
import spring.trip.model.service.CommentService;
import spring.trip.model.service.ReportService;
import spring.trip.model.service.StoryService;
import spring.trip.model.service.WriteService;

@Controller
public class BookController {

	@Autowired
	private BookService bookService;

	@Autowired
	private StoryService storyService;

	@Autowired
	private WriteService writeService;

	@Autowired
	private BookmarkService bookmarkService;

	@Autowired
	private ReportService reportService;

	@Autowired
	private CommentService commentService;

	private String path = "C:\\HNC\\csy\\GripTrip\\eclipse\\workspace\\GripTrip_ver4\\src\\main\\webapp\\upload\\";

	// 스토리북 등록
	@RequestMapping("insertWriteBook.do")
	public ModelAndView insertWriteBook(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			Book book) throws Exception {
		System.out.println("insertWriteBook까지 넘어옴..");
		MultipartFile file = book.getUploadFile();

		if (file != null) { // 파일 업로드를 했다
			String newFileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
			book.setBook_picture_url(newFileName);
			file.transferTo(new File(path + newFileName));
		}
		Member mvo = (Member) session.getAttribute("mvo");
		System.out.println("login 회원::" + mvo);

		if (mvo != null) {
			bookService.insertWriteBook(book);
			Write write = new Write();
			write.setBook_no(book.getBook_no());
			write.setEmail(mvo.getEmail());
			writeService.insertWrite(write);
		}
		// 7/10 수정
		return new ModelAndView("book/afterInsertBook", "book_no", book.getBook_no());
	}

	// 북 조회수 등록
	@RequestMapping("updateHit.do")
	public ModelAndView updateHit(HttpServletRequest request, HttpServletResponse response) throws Exception {
		bookService.updateHit(Integer.parseInt(request.getParameter("book_no")));

		return new ModelAndView("redirect:/getBookList.do");
	}

	// 다른 사람 북 리스트
	@RequestMapping("getOtherBookList.do")
	public ModelAndView getOtherBookList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {
		Member rvo = (Member) session.getAttribute("mvo");
		System.out.println("-----------------------------------");
		System.out.println("otherList" + rvo.getEmail());

		List<Book> bookList = bookService.getOtherBookList(rvo.getEmail());
		List<Bookmark> bookmarkList = bookmarkService.myBookmark(rvo.getEmail()); 
		int book_no = 0;
		for (int i = 0; i < bookList.size(); i++) {
			bookList.get(i).setBookmark("false");
			String nick = bookService.getNickName(bookList.get(i).getBook_no());
			bookList.get(i).setNick(nick);
			for (int j = 0; j < bookmarkList.size(); j++) {
				System.out.println("스토리넘만 " + bookmarkList.get(j));
				if (bookmarkList.get(j).getBookNo() == bookList.get(i).getBook_no()
						&& bookmarkList.get(j).getStoryNo() == 0) {
					System.out.println("1. " + bookmarkList.get(j).getBookNo());
					System.out.println("2. " + bookList.get(i).getBook_no());
					System.out.println("3. " + bookmarkList.get(j).getStoryNo());

					System.out.println("북마크체크된 북넘: " + bookmarkList.get(j).getBookNo());
					System.out.println("위 북넘을 가진 북마크의 스토리 넘" + bookmarkList.get(j).getStoryNo());
					bookService.updateBookmark(bookList.get(i).getBook_no());
					bookList.get(i).setBookmark("true");
					System.out.println(bookList.get(i).getBookmark());
				}
			}
			// 스토리 개수 가져오는 부분 추가
			book_no = bookList.get(i).getBook_no();
			int storyCount = bookService.getStoryCountOfBook(book_no);
			bookList.get(i).setStoryCount(storyCount);
			System.out.println("book_no : " + book_no + ", storyCount : " + storyCount);
		}
		// 스토리 리스트 받아오기
		List<Story> storyList = storyService.otherStoryList(rvo.getEmail());
		System.out.println("다른 사람 스토리: " + storyList);
		for (int i = 0; i < storyList.size(); i++) {
			storyList.get(i).setBookmark("false");
			String nick = bookService.getNickName(storyList.get(i).getBook().getBook_no());
			storyList.get(i).getMember().setNickname(nick);

			int countComment = commentService.countComment(Integer.toString(storyList.get(i).getStoryNo()));
			storyList.get(i).setCountComment(countComment);

			for (int j = 0; j < bookmarkList.size(); j++) {
				if (bookmarkList.get(j).getBookNo() == storyList.get(i).getBook().getBook_no()
						&& bookmarkList.get(j).getStoryNo() == storyList.get(i).getStoryNo()) {
					storyService.updateStoryBookmark(Integer.toString(storyList.get(i).getStoryNo()));
					storyList.get(i).setBookmark("true");
					storyList.get(i).setStoryContent(storyList.get(i).getStoryContent().replaceAll("<br>", "\r\n"));
				}
			} // for bookmarkList
		} // for storyList
		request.setAttribute("storyList", storyList);
		List reportList = reportService.selectReport();
		request.setAttribute("reportList", reportList);
		System.out.println("get other report: " + reportList);
		return new ModelAndView("book/allList", "bookList", bookList);
	}

	// 스토리북 삭제
	@RequestMapping("deleteBook.do")
	public ModelAndView deleteBook(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String book_picture_url = request.getParameter("book_picture_url");

		if (book_picture_url != null) {
			bookService.deleteFile(path + book_picture_url);
		}
		bookService.deleteBook(Integer.parseInt(request.getParameter("book_no")));
		bookmarkService.deleteBookmarkByBookNo(request.getParameter("book_no"));
		return new ModelAndView("JsonView");
	}

	// 스토리북 수정 뷰페이지 가기
	@RequestMapping("updateBookView.do")
	public ModelAndView updateBookView(HttpServletRequest request, HttpServletResponse response, Book book)
			throws Exception {
		book = bookService.getBookByBookNo(Integer.parseInt(request.getParameter("book_no")));
		return new ModelAndView("book/book_Update", "book", book);
	}

	// 스토리북 수정
	@RequestMapping("updateBook.do")
	public ModelAndView updateBook(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			Book book) throws Exception {
		System.out.println("updateBook Controller 까지 도착함..");

		MultipartFile file = book.getUploadFile();
		System.out.println("getUploadFile 후 file" + file);
		System.out.println("file 업로드 전 사진 :: " + book.getBook_picture_url());

		if (file != null) { // 파일 업로드를 했다
			String newFileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
			book.setBook_picture_url(newFileName);
			file.transferTo(new File(path + newFileName));
			System.out.println("file 업로드 한 사진 :: " + book.getBook_picture_url());
		} else if (file == null) { // 파일 업로드 안했다
			System.out.println("file 업로드 안한 사진 :: " + book.getBook_picture_url());
		}

		bookService.updateBook(book);
		String email = "";

		Member rvo = (Member) session.getAttribute("mvo");
		if (rvo != null)
			email = rvo.getEmail();
		System.out.println(email);
		return new ModelAndView("redirect:/getMyBookList.do?email=" + email);
	}

	@RequestMapping("previewTitle.do")
	public ModelAndView previewTitle(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String book_title = request.getParameter("book_title");
		// System.out.println("제목 미리보기 :: "+book_title);

		return new ModelAndView("JsonView", "book_title", book_title);
	}

	@RequestMapping("returnToMyBookList.do")
	public ModelAndView returnToMyBookList(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) throws Exception {
		String email = "";
		Member member = (Member) session.getAttribute("mvo");

		if (member != null) {
			email = member.getEmail();
		}

		return new ModelAndView("redirect:/getMyBookList.do?email=" + email);
	}

	// 스토리북 수정시 기존의 사진 삭제
	@RequestMapping("deletePicture.do")
	public ModelAndView deletePicture(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("deletePicture Controller 까지 도착함..");
		String book_picture_url = request.getParameter("book_picture_url");

		if (book_picture_url != null) {
			bookService.deleteFile(path + book_picture_url);
		}
		return new ModelAndView("JsonView");
	}

	// 내 스토리북 보기
	@RequestMapping("getMyBookList.do")
	public ModelAndView getMyBookList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {
		System.out.println("getMyBookListController..");
		Member rvo = (Member) session.getAttribute("mvo");
		String email = rvo.getEmail();
		List<Book> list = bookService.getMyBookList(email);
		List<Bookmark> bookmarkList = bookmarkService.myBookmark(email);

		for (int i = 0; i < list.size(); i++) {
			String nick = bookService.getNickName(list.get(i).getBook_no());
			list.get(i).setNick(nick);
			list.get(i).setBookmark("false");

			if (bookmarkList.isEmpty()) {
				list.get(i).setBookmark("false");
				bookService.deleteBookmark(list.get(i).getBook_no());
				System.out.println("기존에 추가된 북마크가 없을 때");
			}
			for (int j = 0; j < bookmarkList.size(); j++) {
				if (bookmarkList.get(j).getBookNo() == list.get(i).getBook_no()
						&& bookmarkList.get(j).getStoryNo() == 0) {
					list.get(i).setBookmark("true");
					bookService.updateBookmark(list.get(i).getBook_no());
					System.out.println("북마크에 추가된 book_no: " + list.get(i).getBook_no());
				} else {
					bookService.deleteBookmark(list.get(i).getBook_no());
					System.out.println("북마크에 추가되지 않은 book_no: " + bookmarkList.get(j).getBookNo());
				}
			}
		}
		return new ModelAndView("index", "list", list);
	}

	// 스토리, 북 리스트 모두 받기
	@RequestMapping("getAllList.do")
	public ModelAndView getAllList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Book> bookList = bookService.getAllBookList();
		List<Story> storyList = storyService.allStoryList();

		int book_no = 0;
		for (int i = 0; i < bookList.size(); i++) {
			String nick = bookService.getNickName(bookList.get(i).getBook_no());
			bookList.get(i).setNick(nick);
			System.out.println(bookList.get(i).getNick());

			// 스토리 개수 가져오는 부분 추가
			book_no = bookList.get(i).getBook_no();
			int storyCount = bookService.getStoryCountOfBook(book_no);
			bookList.get(i).setStoryCount(storyCount);
			System.out.println("book_no : " + book_no + ", storyCount : " + storyCount);
		}
		for (int i = 0; i < storyList.size(); i++) {
			String nick = bookService.getNickName(storyList.get(i).getBook().getBook_no());
			storyList.get(i).getMember().setNickname(nick);

			int countComment = commentService.countComment(Integer.toString(storyList.get(i).getStoryNo()));
			storyList.get(i).setCountComment(countComment);
			//7.19 추가
			storyList.get(i).setStoryContent(storyList.get(i).getStoryContent().replaceAll("<br>", "\r\n"));
		}
		request.setAttribute("storyList", storyList);
		List<String> reportList = reportService.selectReport();
		request.setAttribute("reportList", reportList);
		return new ModelAndView("book/allList", "bookList", bookList);
	}
}
