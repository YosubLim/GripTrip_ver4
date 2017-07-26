package spring.trip.advice;

import java.net.URLDecoder;
import javax.servlet.http.HttpServletRequest;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import spring.trip.model.service.ReportService;

@Aspect
public class ReportAdvice {
	@Autowired
	private ReportService reportService;

	@Before("execution(* spring.trip.controller.SearchController.search(..))")
	   public void report(JoinPoint jp) throws Throwable{
	      
	      ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
	      HttpServletRequest request = attr.getRequest();
	      
	      String keyword = request.getParameter("keyword");
	      keyword = URLDecoder.decode(keyword);
	      String[] rkeyword = keyword.split(" ");
	      
	      for(String s : rkeyword){
	    	  System.out.println("Advice Class keyword :: "+s);
	    	  reportService.saveReport(s);
	      } 
	      //reportService.saveReport(keyword);	      
	   }
}














