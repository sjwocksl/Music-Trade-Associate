package com.spring.mta.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.mta.service.fnoticeService;
import com.spring.mta.vo.fcommentVO;
import com.spring.mta.vo.fnoticeVO;
import com.spring.mta.vo.freeBoardVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/notice/*")
@AllArgsConstructor
public class noticeController {
	private fnoticeService noticeService;
	
	
	/*********************************************************
	 * ���� �󼼺��� ����
	 *********************************************************/
	@RequestMapping(value="/fnoticeDetail", method = RequestMethod.GET)
	public String noticeDetail(@ModelAttribute("data") fnoticeVO nvo,fcommentVO fco, Model model) {
		log.info("noticeDetail ȣ�� ����");
		//log.info("bvo = " + bvo);
		

		fnoticeVO detail = noticeService.noticeDetail(nvo);
		model.addAttribute("detail", detail);
		
		
		return "notice/fnoticeDetail";
	}
	
	
	/*********************************************************
	 * ���� �۾��� �� ����ϱ�
	 *********************************************************/
	@RequestMapping("/fnoticeWriteForm")
	public String noticeWriteForm(@ModelAttribute("data") fnoticeVO nvo) {
		log.info("noticeWrtieForm ȣ�� ����");
		
		return "notice/noticeWriteForm";
	}
	
	/*********************************************************
	 * ���� �۾��� �����ϱ�
	 *********************************************************/
	@RequestMapping(value="/fnoticeInsert", method = RequestMethod.POST)
	//@PostMapping("/freeboardInsert")
	public String fnoticeInsert(fnoticeVO nvo, Model model){
		log.info("fnoticeInsert ȣ�� ����");
		
	
		int result = 0;
		String url = "";
		result = noticeService.fnoticeInsert(nvo);
		if(result == 1) {
			url = "/board/freeboard";
		}else {
			url = "/notice/noticeWriteForm";
		}
		
		return "redirect:"+url;
	}
	
}
