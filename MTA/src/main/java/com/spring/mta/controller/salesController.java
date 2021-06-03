package com.spring.mta.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.mta.common.vo.PageDTO;
import com.spring.mta.service.PurchaseService;
import com.spring.mta.service.SalesService;
import com.spring.mta.vo.salesVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/sales/*")
@Log4j
@AllArgsConstructor
public class salesController {

	private SalesService salesService;
	
	@RequestMapping(value="/salesboard", method = RequestMethod.GET)
	public String salesboard(@ModelAttribute("data") salesVO svo, Model model){
		log.info("salesboard ȣ�� ����");
		
		List<salesVO> salesboard = salesService.salesboard(svo);
		model.addAttribute("salesboard", salesboard);
		
		// ��ü ���ڵ�� ����
		int total = salesService.boardListCnt(svo);
		//����¡ ó��
		model.addAttribute("pageMaker" , new PageDTO(svo, total));
		
		
		return "order/sales_list"; 
	}
}
