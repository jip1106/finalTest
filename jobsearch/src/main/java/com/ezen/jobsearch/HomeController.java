package com.ezen.jobsearch;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	

	@RequestMapping(value = {"/home.do","/index.do"})
	public String home() {
		
		return "home";
	}
	
	@RequestMapping(value = {"/admin/home.do","/admin/index.do"})
	public String adminPage() {
		return "/admin/index";
	}
	
	@RequestMapping(value="/admin/login.do")
	public String adminLoginPage() {
		return "/admin/login/login";
	}
	
}
