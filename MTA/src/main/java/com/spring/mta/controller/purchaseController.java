package com.spring.mta.controller;

import java.util.List;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.mta.common.vo.PageDTO;
import com.spring.mta.service.PurchaseService;
import com.spring.mta.vo.purchaseVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/purchase/*")
@Log4j
@AllArgsConstructor
public class purchaseController {
	private PurchaseService purchaseService;
	
	
	@RequestMapping(value="/purchaseboard", method = RequestMethod.GET)
	public String purchaseBoard(@ModelAttribute("data") purchaseVO pvo, Model model) {
		log.info("purchaseboard ȣ�� ����");
		
		List<purchaseVO> pList = purchaseService.purchaseBoard(pvo);
		model.addAttribute("pList",pList);
		
		// ��ü ���ڵ�� ����
		int total = purchaseService.boardListCnt(pvo);
		//����¡ ó��
		model.addAttribute("pageMaker" , new PageDTO(pvo, total));
				
		return "order/purchase_list";
	}
}
