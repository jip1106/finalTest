package com.ezen.jobsearch.board.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/faq")
public class FaqController {
	private Logger logger
		=LoggerFactory.getLogger(FaqController.class);
	
	@RequestMapping(value = "/list.do")
	public String list() {
		logger.info("FAQ 목록");
		
		return "board/faqList";
	}
}
