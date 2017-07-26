package spring.trip.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import spring.trip.domain.Comment;
import spring.trip.domain.Member;
import spring.trip.domain.Story;
import spring.trip.model.service.CommentService;
import spring.trip.model.service.StoryService;

@Controller
public class CommentController {
	// field
	@Autowired
	private CommentService commentService;
	@Autowired
	private StoryService storyService;

	// writeComment()
	@RequestMapping("writeComment.do")
	public ModelAndView writeComment(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {
		// form 값 받기
		String storyNo = request.getParameter("storyNo");
		int depth = Integer.parseInt(request.getParameter("depth"));
		int orderId = Integer.parseInt(request.getParameter("orderId"));
		String commentIsPublic = request.getParameter("commentIsPublic");
		String commentContent = request.getParameter("commentContent");

		// Comment VO 채우기
		Comment cvo = new Comment();

		cvo.setCommentContent(commentContent);
		cvo.setCommentIsPublic(commentIsPublic);
		cvo.setDepth(depth);
		cvo.setOrderId(orderId);

		Member mvo = (Member) session.getAttribute("mvo");
		System.out.println(mvo);

		cvo.setMember(mvo);
		cvo.setStory(storyService.getStoryByStoryNo(storyNo));

		System.out.println("Comment VO before inserting into DB : " + cvo);

		// Comment VO DB에 insert
		commentService.writeComment(cvo);
		System.out.println("Comment VO after inserting into DB : " + cvo);

		// groupId까지 채우기
		int groupId = cvo.getCommentNo();
		cvo.setGroupId(groupId);

		System.out.println("Comment VO completed : " + cvo);

		// return new
		// ModelAndView("redirect:/showStory.do?book_no="+cvo.getStory().getBook().getBook_no()+"&&storyNo="+cvo.getStory().getStoryNo());
		return new ModelAndView("redirect:/showStory.do?storyNo=" + cvo.getStory().getStoryNo() + "&&book_no="
				+ cvo.getStory().getBook().getBook_no());
	}

	// writeRecomment()
	@RequestMapping("writeRecomment.do")
	public ModelAndView writeRecomment(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {
		// form 값 받기
		String storyNo = request.getParameter("storyNo");
		int parentCommentNo = Integer.parseInt(request.getParameter("parentCommentNo"));
		String parentCommentEmail = request.getParameter("parentCommentEmail");
		int groupId = Integer.parseInt(request.getParameter("groupId"));
		int orderId = Integer.parseInt(request.getParameter("orderId"));
		int depth = Integer.parseInt(request.getParameter("depth"));
		String commentContent = request.getParameter("commentContent");
		String commentIsPublic = request.getParameter("commentIsPublic");

		// Comment VO 만들고 채우기
		Comment cvo = new Comment();

		cvo.setParentCommentNo(parentCommentNo);
		cvo.setParentCommentEmail(parentCommentEmail);
		cvo.setGroupId(groupId);
		cvo.setDepth(depth + 1);
		cvo.setCommentContent(commentContent);
		cvo.setCommentIsPublic(commentIsPublic);

		cvo.setStory(storyService.getStoryByStoryNo(storyNo));
		cvo.setMember((Member) session.getAttribute("mvo"));

		System.out.println(cvo);
		System.out.println("Ole orderId : " + commentService.getMaxOrderIdWithSameDepth(cvo));

		int maxOrder = commentService.getMaxOrderIdWithSameDepth(cvo);
		int newOrderId = 0;

		if (maxOrder == 0)
			newOrderId = 1;
		else
			newOrderId = maxOrder + 1;

		cvo.setOrderId(newOrderId);
		System.out.println("RE: Comment VO before inserting into DB : " + cvo);

		commentService.writeRecomment(cvo);
		System.out.println("RE: Comment VO after inserting into DB : " + cvo);

		return new ModelAndView("redirect:/showStory.do?storyNo=" + cvo.getStory().getStoryNo() + "&&book_no="
				+ cvo.getStory().getBook().getBook_no());
	}

	// updateComment()
	@RequestMapping("updateComment.do")
	public ModelAndView updateComment(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String commentContent = request.getParameter("commentContent");
		int commentNo = Integer.parseInt(request.getParameter("commentNo"));
		String storyNo = request.getParameter("storyNo");
		String commentIsPublic = request.getParameter("commentIsPublic");
		String book_no = request.getParameter("book_no");

		Comment cvo = new Comment();
		cvo.setCommentContent(commentContent);
		cvo.setCommentNo(commentNo);
		cvo.setCommentIsPublic(commentIsPublic);

		commentService.updateComment(cvo);

		return new ModelAndView("redirect:/showStory.do?book_no=" + book_no + "&&storyNo=" + storyNo);
	}

	// removeComment()
	@RequestMapping("removeComment.do")
	public ModelAndView removeComment(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String commentNo = request.getParameter("commentNo");
		String storyNo = request.getParameter("storyNo");
		String book_no = request.getParameter("book_no");

		System.out.println("commentNo : " + commentNo + ", storyNo : " + storyNo + ", book_no : " + book_no);

		commentService.removeComment(commentNo);

		return new ModelAndView("redirect:/showStory.do?book_no=" + book_no + "&&storyNo=" + storyNo);
	}

	// showAllVisibleCommentsOfStory()
	public ModelAndView showAllVisibleCommentsOfStory(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String storyNo = request.getParameter("storyNo");
		Story svo = storyService.getStoryByStoryNo(storyNo);
		List<Comment> cList = commentService.showAllVisibleCommentsOfStory(svo);
		return new ModelAndView("JsonView", "cList", cList);
	}
}
