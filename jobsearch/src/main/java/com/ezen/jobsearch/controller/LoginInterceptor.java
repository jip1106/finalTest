package com.ezen.jobsearch.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ezen.jobsearch.member.model.MemberVO;

@Component
public class LoginInterceptor extends HandlerInterceptorAdapter{

	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.info("컨트롤러 수행 전 호출 - preHandle()");
		
		HttpSession session = request.getSession();
		MemberVO memberVo = (MemberVO)session.getAttribute("loginMember");
		
		
		if(memberVo == null) {
			System.out.println("request.getPathInfo()"+request.getPathInfo());
			System.out.println("request.getRequestURI()" + request.getRequestURI());
			System.out.println("request.getRequestURL()" + request.getRequestURL());
			
			String requestUri = request.getRequestURI();
			String loginPath = "/member/login.do";
			
			if(requestUri.indexOf("admin") > 0 ) {
				loginPath = "/admin/login.do";
			}

			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			
			out.print("<script type='text/javascript'>");
			out.print("alert('로그인이 필요한 서비스 입니다.');");
			out.print("location.href='" + request.getContextPath() + loginPath +"';");
			out.print("</script>");
			
			return false;
		}
		
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		logger.info("컨트롤러 수행 후 호출 - postHandle()");
		
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		logger.info("뷰 생성 후 호출 - postHandle()");
		
	}

}
