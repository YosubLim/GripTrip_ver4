package spring.trip.controller;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import spring.trip.domain.Book;
import spring.trip.domain.Member;
import spring.trip.domain.Order;
import spring.trip.domain.Story;
import spring.trip.model.service.BookService;
import spring.trip.model.service.OrderService;
import spring.trip.model.service.StoryService;

@Controller
public class OrderController {

	@Autowired
	private OrderService orderService;

	@Autowired
	private BookService bookService;

	@Autowired
	private StoryService storyService;

	// 1.bookPreviewStoryBook
	@RequestMapping("bookPreviewStoryBook.do")
	public ModelAndView bookPreviewStoryBook(HttpServletRequest request, HttpServletResponse response, Story story)
			throws Exception {
		int book_no = Integer.parseInt(request.getParameter("book_no"));
		String bookNo = request.getParameter("book_no");

		List<Story> storyInfo = storyService.showStoryList(bookNo);
		for(int i=0; i<storyInfo.size(); i++){
	        storyInfo.get(i).setStoryContent(storyInfo.get(i).getStoryContent().replaceAll("\r\n", "<br>"));
	    }
		
		Collections.reverse(storyInfo);
		Book bookInfo = bookService.getBookByBookNo(book_no);
		request.setAttribute("bookInfo", bookInfo);

		System.out.println("storyInfostoryInfostoryInfostoryInfo : " + storyInfo);
		return new ModelAndView("order/bookPreview", "storyInfo", storyInfo);
	}

	// howToPay.do
	@RequestMapping("howToPay.do")
	public ModelAndView howToPay(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			Story story) throws Exception {

		int book_no = Integer.parseInt(request.getParameter("book_no"));
		int quantity = Integer.parseInt(request.getParameter("quantity"));
		int price = Integer.parseInt(request.getParameter("price"));
		
		Book rbvo = bookService.getBookByBookNo(book_no);

		Member mvo = (Member) session.getAttribute("mvo");

		Order ovo = new Order();
		ovo.setBook(rbvo);
		ovo.setMember(mvo);
		ovo.setQuantity(quantity);
		ovo.setTotalPrice(quantity * price);

		orderService.orderBook(ovo);

		Order order = orderService.showOrderInfo(ovo.getOrderNo());
		order.getBook().setBook_title(rbvo.getBook_title());
		order.getBook().setBook_picture_url(rbvo.getBook_picture_url());
		
		return new ModelAndView("order/howToPay", "order", order);
	}

	// 3.orderBook
	@RequestMapping("orderBook.do")
	public ModelAndView orderBook(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int quantity = Integer.parseInt(request.getParameter("Quantity"));
		int bn = Integer.parseInt(request.getParameter("BookNo"));
		int price = Integer.parseInt(request.getParameter("price"));

		Book bvo = bookService.getBookByBookNo(bn);

		HttpSession session = request.getSession();
		Member mvo = (Member) session.getAttribute("mvo");

		Order ovo = new Order();
		ovo.setMember(mvo);
		ovo.setBook(bvo);
		ovo.setQuantity(quantity);
		ovo.setTotalPrice(price);

		int row = orderService.orderBook(ovo);

		return new ModelAndView("redirect:/showOrderInfo.do?orderNo=" + ovo.getOrderNo());
	}

	// 4.showOrderInfo
	@RequestMapping("showOrderInfo.do")
	   public ModelAndView showOrderInfo(HttpServletRequest request, HttpServletResponse response)throws Exception{
	   
	         int OrderNo = Integer.parseInt(request.getParameter("orderNo"));
	      
	         Order rvo = orderService.showOrderInfo(OrderNo);
	         
	         Book book = bookService.getBookByBookNo(rvo.getBook().getBook_no());
	         
	         rvo.getBook().setBook_title(book.getBook_title());
	         rvo.getBook().setBook_picture_url(book.getBook_picture_url());
	         Member member = (Member) request.getSession().getAttribute("mvo");
	         
	         rvo.getMember().setNickname(member.getNickname());
	         
	         return new ModelAndView("order/orderBook_result", "rvo", rvo);
	   }
	
	 //5.getOrderListOfMember
	   @RequestMapping("getOrderListOfMember.do")
	   public ModelAndView getOrderListOfMember(HttpServletRequest request, HttpServletResponse response, HttpSession session)throws Exception{
	      Member member = (Member)session.getAttribute("mvo");
	      List<Order> list = orderService.getOrderListOfMember(member.getEmail());
	      System.out.println("====list===="+list+"+++++");
	      for(int i=0; i<list.size(); i++){
	         Book book = bookService.getBookByBookNo(list.get(i).getBook().getBook_no());
	         list.get(i).getBook().setBook_title(book.getBook_title());
	         list.get(i).getBook().setBook_picture_url(book.getBook_picture_url());
	         
	         System.out.println("책 제목: "+list.get(i).getBook().getBook_title());
	         System.out.println("책 " +list.get(i));
	      }
	         
	      return new ModelAndView("order/getOrderListOfMember","list", list);
	   }

	// cancelOrder
	@RequestMapping("cancelOrder.do")
	public ModelAndView cancelOrder(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {
		Member mvo = (Member) session.getAttribute("mvo");
		String Email = mvo.getEmail();

		int orderNo = Integer.parseInt(request.getParameter("orderNo"));
		int cel = orderService.cancelOrder(orderNo);

		return new ModelAndView("redirect:/getOrderListOfMember.do", "Email", Email);
	}
	
	@RequestMapping("getStoryCount.do")
	public ModelAndView getStoryCount(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String book_no = request.getParameter("book_no");
		int storyCount = bookService.getStoryCountOfBook(Integer.parseInt(book_no));
		return new ModelAndView("JsonView", "count", storyCount);
	}
}
