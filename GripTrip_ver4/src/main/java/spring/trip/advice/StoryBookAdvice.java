package spring.trip.advice;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import spring.trip.model.service.BookService;
import spring.trip.model.service.BookmarkService;
import spring.trip.model.service.StoryService;
import spring.trip.model.service.WriteService;

@Aspect
public class StoryBookAdvice {
	
	@Autowired
	private BookService bookService;

	@Autowired
	private StoryService storyService;

	@Autowired
	private WriteService writeService;
	
	@Autowired
	private BookmarkService bookmarkService;

	@Before("execution(* spring.trip.controller.StoryController.showStory(..))")
    public void showStory(JoinPoint jp) throws Throwable{
       ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
       HttpServletRequest request = attr.getRequest();
       int book_no = Integer.parseInt(request.getParameter("book_no"));
       String storyNo = request.getParameter("storyNo");
       bookService.updateHit(book_no);
       storyService.upStoryHit(storyNo);
    }
	
	@Before("execution(* spring.trip.controller.StoryController.showStoryList(..))")
	   public void showStoryList(JoinPoint jp) throws Throwable{
	      ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
	      HttpServletRequest request = attr.getRequest();
	      int book_no = Integer.parseInt(request.getParameter("book_no"));
	      bookService.updateHit(book_no);
	  }
}