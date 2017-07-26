package spring.trip.advice;

import org.apache.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;

import spring.trip.domain.Member;

@Aspect
public class MemberLoggerAdvice {
   // field
   private Logger logger = Logger.getLogger(MemberLoggerAdvice.class);
   
   @AfterReturning(pointcut="execution(public * spring.trip.model.service.MemberService.login(..))", returning="ret")
   public void loginLog(JoinPoint jp, Member ret) throws Throwable{
      System.out.println("[Aspect]" + jp.getSignature().getName());
         if(ret != null){
         logger.info(ret.getEmail() + "님 로그인");
         logger.warn(ret.getEmail() + "님 로그인");
         logger.error(ret.getEmail() + "님 로그인");
         logger.fatal(ret.getEmail() + "님 로그인");
         }else{
            System.out.println("로그인 실패");
         }
   }
}