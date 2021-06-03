package com.spring.mta.controller;


import java.util.List;



import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.mta.common.vo.PageDTO;
import com.spring.mta.service.fcommentService;
import com.spring.mta.service.freeBoardService;
import com.spring.mta.service.serviceService;
import com.spring.mta.vo.fcommentVO;
import com.spring.mta.vo.freeBoardVO;
import com.spring.mta.vo.sReplyVO;
import com.spring.mta.vo.serviceVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;



@Controller
@Log4j
@RequestMapping("/sboard/*")
@AllArgsConstructor
public class serviceBoardController {
	
	private serviceService sService;
	
	
	/*********************************************************
	 * �۸�� �����ϱ�(����¡ ó�� ��� ��ȸ)
	 *********************************************************/
	
	@RequestMapping(value="/serviceCenter", method = RequestMethod.GET)
	public String serviceCenterList(@ModelAttribute("data") serviceVO sbvo, Model model ) {
		log.info("serviceBoard ȣ�� ����");
		
	
		// ��ü ���ڵ� ��ȸ 
		List<serviceVO> serviceList = sService.serviceboardList(sbvo);
		model.addAttribute("serviceList", serviceList);
		
		// ��ü ���ڵ�� ����
		int total = sService.serviceboardListCnt(sbvo);
		//����¡ ó��
		model.addAttribute("pageMaker" , new PageDTO(sbvo, total));
		
		
		return "sboard/serviceCenter";
	}
	
	
	/*********************************************************
	 * �۾��� �� ����ϱ�
	 *********************************************************/
	@RequestMapping("/serviceWriteForm")
	public String writeForm(@ModelAttribute("data") serviceVO sbvo) {
		log.info("serviceWrtieForm ȣ�� ����");
		
		return "sboard/serviceWriteForm";
	}
	

	/*********************************************************
	 * �۾��� �����ϱ�
	 *********************************************************/
	@RequestMapping(value="/serviceboardInsert", method = RequestMethod.POST)
	//@PostMapping("/freeboardInsert")
	public String serviceboardInsert(serviceVO sbvo, Model model) {
		log.info("serviceboardInsert ȣ�� ����");
		
	
		int result = 0;
		String url = "";
		result = sService.serviceboardInsert(sbvo);
		if(result == 1) {
			url = "/sboard/serviceCenter";
		}else {
			url = "/sboard/serviceWriteForm";
		}
		
		return url;
	}
	

	
	/*********************************************************
	 * �� �󼼺��� ����
	 *********************************************************/
	@RequestMapping(value="/serviceboardDetail", method = RequestMethod.GET)
	public String serviceboardDetail(@ModelAttribute("data") serviceVO sbvo, sReplyVO srvo, Model model) {
		log.info("serviceboardDetail ȣ�� ����");
		//log.info("bvo = " + bvo);
		

		serviceVO detail = sService.serviceboardDetail(sbvo);
		model.addAttribute("detail", detail);
		
		
		return "sboard/serviceDetail";
	}
	
	
	/**************************************************************
	    * �� ���� �����ϱ�
	    **************************************************************/
	   @RequestMapping(value="/serviceboardDelete")
	      public String serviceboardDelete(@ModelAttribute serviceVO sbvo) {
	         log.info("serviceboardDelete ȣ�� ����");
	         
	         int result = 0;
	         String url = "";
	         
	         result = sService.serviceboardDelete(sbvo.getScb_no());
	         
	         if(result==1) {
	            url="/sboard/serviceCenter";
	         }else {
	        	 url="/sboard/serviceboardDetail";
	         }
	         return "redirect:"+url;
	      }
	   
		/*********************************************************
		 * ������Ʈ �� ����ϱ�
		 * @param : b_num
		 * @return : BoardVO
		 *********************************************************/
		@RequestMapping("/serviceUpdateForm")
		public String updateForm(@ModelAttribute("data") serviceVO sbvo, Model model) {
			log.info("serviceUpdateForm ȣ�� ����");
			log.info("scb_no:" + sbvo.getScb_no());
			
			serviceVO board = sService.serviceUpdateForm(sbvo);
			model.addAttribute("updateData",board);
			return "sboard/serviceUpdateForm";
		}
		
		/*********************************************************
		 * ������Ʈ �����ϱ�2
		 * @param BoardVO
		 * ���� : RedirectAttributes ��ü�� �����̷�Ʈ ����(return "redirect:/���")��
		 * �ѹ��� ���Ǵ� �����͸� ������ �� �ִ� addFlashAttribute()��� ����� �����Ѵ�.
		 * addFlashAttribute() �޼ҵ�� ���������� ���۵Ǳ�� ������,
		 * URI�󿡴� ������ �ʴ� ������ �������� ���·� ���޵ȴ�.
		 *********************************************************/
		@RequestMapping(value="/serviceboardUpdate", method = RequestMethod.POST)
		public String serviceboardUpdate(@ModelAttribute serviceVO sbvo, RedirectAttributes ras) throws Exception{
			log.info("serviceboardUpdate ȣ�� ����");
			
			int result = 0;
			String url = "";
			
			result = sService.serviceboardUpdate(sbvo);
			ras.addFlashAttribute("data",sbvo);
			//addFlashAttribute() �� �����̷�Ʈ ���� �÷��ÿ� �����ϴ� �޼ҵ��. �����̷�Ʈ ���Ŀ��� �Ҹ��Ѵ�.
			
			if(result == 1) {
				
				url = "/sboard/serviceboardDetail";
			}else {
				url = "/sboard/serviceUpdateForm";
			}
			
			return "redirect:"+url;
			//redirect�ϰ��� ���� �ڿ� ������� x
		}
		
	
		
}
	


	
	
	
	

