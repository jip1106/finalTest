package com.ezen.jobsearch.board.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	private Logger logger
		=LoggerFactory.getLogger(NoticeController.class);
	
	@RequestMapping(value = "/list.do")
	public String list() {
		logger.info("공지사항 목록");
		
		return "board/noticeList";
	}
}
