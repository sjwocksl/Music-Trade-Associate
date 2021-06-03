package com.spring.mta.controller;


import java.util.List;



import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.mta.common.vo.PageDTO;
import com.spring.mta.service.LikeService;
import com.spring.mta.service.fcommentService;
import com.spring.mta.service.fnoticeService;
import com.spring.mta.service.freeBoardService;
import com.spring.mta.vo.fcommentVO;
import com.spring.mta.vo.fnoticeVO;
import com.spring.mta.vo.freeBoardVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;



@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class freeBoardController {
	
	private freeBoardService freeboardService;
	private fcommentService fcommentservice;
	private fnoticeService noticeService;
	private LikeService likeservice;
	
	/*********************************************************
	 * �۸�� �����ϱ�(����¡ ó�� ��� ��ȸ)
	 *********************************************************/
	
	@RequestMapping(value="/freeboard", method = RequestMethod.GET)
	//GetMapping("/boardList")
	public String boardList(@ModelAttribute("data") freeBoardVO fvo, fnoticeVO nvo, Model model ) {
		log.info("freeBoard ȣ�� ����");
		
	
		// ��ü ���ڵ� ��ȸ 
		List<freeBoardVO> boardList = freeboardService.freeboardList(fvo);
		model.addAttribute("boardList", boardList);
		
		// �������� ���ڵ� ��ȸ
		List<fnoticeVO> noticeList = noticeService.noticeList(nvo);
		model.addAttribute("noticeList", noticeList);
		
		// ��ü ���ڵ�� ����
		int total = freeboardService.boardListCnt(fvo);
		//����¡ ó��
		model.addAttribute("pageMaker" , new PageDTO(fvo, total));
		
		
		return "board/freeboard";
	}
	
	
	/*********************************************************
	 * �۾��� �� ����ϱ�
	 *********************************************************/
	@RequestMapping("/freeWriteForm")
	public String writeForm(@ModelAttribute("data") freeBoardVO bvo) {
		log.info("freeWrtieForm ȣ�� ����");
		
		return "board/freeWriteForm";
	}
	

	/*********************************************************
	 * �۾��� �����ϱ�
	 *********************************************************/
	@RequestMapping(value="/freeboardInsert", method = RequestMethod.POST)
	//@PostMapping("/freeboardInsert")
	public String freeboardInsert(freeBoardVO bvo, Model model) throws Exception{
		log.info("freeboardInsert ȣ�� ����");
		
	
		int result = 0;
		String url = "";
		result = freeboardService.freeboardInsert(bvo);
		if(result == 1) {
			url = "/board/freeboard";
		}else {
			url = "/board/freeWriteForm";
		}
		
		return "redirect:"+url;
	}
	

	
	/*********************************************************
	 * �� �󼼺��� ����
	 *********************************************************/
	@RequestMapping(value="/freeboardDetail", method = RequestMethod.GET)
	public String boardDetail(@ModelAttribute("data") freeBoardVO bvo,fcommentVO fco, Model model) {
		log.info("freeboardDetail ȣ�� ����");
		//log.info("bvo = " + bvo);
		

		freeBoardVO detail = freeboardService.freeboardDetail(bvo);
		model.addAttribute("detail", detail);
		
		List<fcommentVO> fcommentList =  fcommentservice.fcommentList(fco);
		model.addAttribute("fcommentList",fcommentList);
		
		return "board/freeboardDetail";
	}
	
	
	/**************************************************************
	    * �� ���� �����ϱ�
	    **************************************************************/
	   @RequestMapping(value="/freeboardDelete")
	      public String boardDelete(@ModelAttribute freeBoardVO bvo) {
	         log.info("freeboardDelete ȣ�� ����");
	         
	         int result = 0;
	         String url = "";
	         
	         result = freeboardService.freeboardDelete(bvo.getF_no());
	         
	         if(result==1) {
	            url="/board/freeboard";
	         }else {
	        	 url="/board/freeboardDetail";
	         }
	         return "redirect:"+url;
	      }
	   
		/*********************************************************
		 * ������Ʈ �� ����ϱ�
		 * @param : b_num
		 * @return : BoardVO
		 *********************************************************/
		@RequestMapping("/freeUpdateForm")
		public String updateForm(@ModelAttribute("data") freeBoardVO bvo, Model model) {
			log.info("freeUpdateForm ȣ�� ����");
			log.info("f_no:" + bvo.getF_no());
			
			freeBoardVO board = freeboardService.freeupdateForm(bvo);
			model.addAttribute("updateData",board);
			return "board/freeUpdateForm";
		}
		
		/*********************************************************
		 * ������Ʈ �����ϱ�2
		 * @param BoardVO
		 * ���� : RedirectAttributes ��ü�� �����̷�Ʈ ����(return "redirect:/���")��
		 * �ѹ��� ���Ǵ� �����͸� ������ �� �ִ� addFlashAttribute()��� ����� �����Ѵ�.
		 * addFlashAttribute() �޼ҵ�� ���������� ���۵Ǳ�� ������,
		 * URI�󿡴� ������ �ʴ� ������ �������� ���·� ���޵ȴ�.
		 *********************************************************/
		@RequestMapping(value="/freeboardUpdate", method = RequestMethod.POST)
		//@PostMapping("/boardUpdate")
		public String freeboardUpdate(@ModelAttribute freeBoardVO bvo, RedirectAttributes ras) throws Exception{
			log.info("freeboardUpdate ȣ�� ����");
			
			int result = 0;
			String url = "";
			
			result = freeboardService.freeboardUpdate(bvo);
			ras.addFlashAttribute("data",bvo);
			//addFlashAttribute() �� �����̷�Ʈ ���� �÷��ÿ� �����ϴ� �޼ҵ��. �����̷�Ʈ ���Ŀ��� �Ҹ��Ѵ�.
			
			if(result == 1) {
				//�Ʒ� url�� ���� �� �󼼤� �������� �̵�
				//url = "/board/boardDetail?b_num="+bvo.getB_num();
				url = "/board/freeboardDetail";
			}else {
				//url = "/board/updateForm?b_num="+bvo.getB_num();
				url = "/board/freeUpdateForm";
			}
			
			return "redirect:"+url;
			//redirect�ϰ��� ���� �ڿ� ������� x
		}
		
		
		/*********************************************************
		 * �� ��õ�ϱ�
		 *********************************************************/
		@RequestMapping(value = "/freeRecomment", method = RequestMethod.POST)
		public String freeRecomment(@ModelAttribute("data") freeBoardVO fvo, RedirectAttributes ras) {
			log.info("freeRecomment ȣ�� ����");
			log.info("f_no:" + fvo.getF_no());
			
			int result = 0;
			String url = "";
			result = freeboardService.freeRecomment(fvo.getF_no());
			
			ras.addFlashAttribute("data",fvo);
			//addFlashAttribute() �� �����̷�Ʈ ���� �÷��ÿ� �����ϴ� �޼ҵ��. �����̷�Ʈ ���Ŀ��� �Ҹ��Ѵ�.
			
			if(result == 1) {
				//�Ʒ� url�� ���� �� �󼼤� �������� �̵�
				//url = "/board/boardDetail?b_num="+bvo.getB_num();
				url = "/board/freeboardDetail?b_num="+fvo.getF_no();
			}else {
				url = "/board/freeboard";
			}
			
			return "redirect:"+url;
			//redirect�ϰ��� ���� �ڿ� ������� x
		}
		
}
	


	
	
	
	

