package com.spring.mta.controller;


import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.mta.service.UserService;
import com.spring.mta.vo.UserVO;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user/*")
@AllArgsConstructor
public class UserController {
	
	private UserService userService;
	
	/* ������� �� �̵� */
	   @GetMapping("/Accept")
	   public String Accept() {
	      return "user/Accept";
	   }
	
		/* ȸ������ �� �̵� */
	   @GetMapping("/userJoin")
	   public String userJoin() {
	      return "user/userJoin";
	   }
	
	   /* ���̵�ã�� �� �̵� */
	  @GetMapping("/useridfind")
	   public String useridfind() {
	      return "user/useridfind";
	   }
	  
	  /* ��й�ȣã�� �� �̵� */
	   @GetMapping("/userpwfind")
	   public String userpwfind() {
	      return "user/userpwfind";
	   }

	
	
	/*********************************************************
	 * �α��� �����ϱ�
	 *********************************************************/
	
	@RequestMapping(value="/login", method = RequestMethod.POST)
	//GetMapping("/boardList")
	public String loginList(@ModelAttribute("data") UserVO uvo , HttpSession session, Model model) {
		log.info("loginList ȣ�� ����");
		
		// ��ü ���ڵ� ��ȸ 
		UserVO userInfo  = userService.login(uvo);
		
		if (userInfo != null) {
			session.setAttribute("userInfo", userInfo);
		}else {
			model.addAttribute("errMsg", "�α��������� �ùٸ����ʽ��ϴ�.");
		}
		
		return "/intro";
	}
	
	/*********************************************************
	 * �α׾ƿ� �����ϱ�
	 *********************************************************/
	
	 @RequestMapping("/logout")
	    public String logout(HttpSession session) {
	        session.invalidate();
	     
	        
	     return "/intro";
	}


	
	
	/********************************************************
	 * ������������ �̵�
	 * ******************************************************/
	 @GetMapping("/userDetailForm")
	 public String userDetailForm() {
		 return "user/userDetailForm";
	 }
	 
	 /********************************************************
	  * ���� ���������� �̵�
	 * ******************************************************/
		 @GetMapping("/userUpdateForm")
		 public String userUpdateForm() {
			 return "user/userUpdateForm";
	}
		 
		 /********************************************************
		  * ���� ���� ����
		 * ******************************************************/
		@RequestMapping(value="/userUpdate", method = RequestMethod.POST)
		public String freeboardUpdate(@ModelAttribute("data") UserVO uvo, HttpSession session ) throws Exception{
			log.info("userUpdate ȣ�� ����");
			
			UserVO another = (UserVO)session.getAttribute("userInfo");
			uvo.setUser_id(another.getUser_id());
			
			UserVO userInfo = userService.login(uvo);
				if(userInfo != null) {
					session.setAttribute("userInfo", userInfo);
			}
			
			int result = 0;
			String url = "";
			result = userService.userUpdate(uvo);
			if (result == 1) {
				  	session.invalidate();
					url = "/intro";
			}else {
					url = "user/userUpdateForm";
			}	
			
			return url;
		}
					 
		 /********************************************************
		  * ȸ������ ����
		 * ******************************************************/
		@RequestMapping(value = "/userInsert", method = RequestMethod.POST)
		   public String userInsert(UserVO uvo, Model model) {
		      log.info("userInsert ��û �Ϸ�");
		      
		      int result = 0;
		      String url = "";
		      result = userService.userInsert(uvo);
		      if (result == 1) {
		         url = "/intro";
		      }
		      
		      return url;
		   } 
		
		
		 //���̵� �ߺ�Ȯ��
		   @ResponseBody
		   @RequestMapping(value = "/idCheck", method = RequestMethod.POST)
		   public int idCheck(UserVO uvo) {
		      log.info("idCheck ȣ�� ����");
		      
		      int result = 0;

		      result =  userService.userIdCheck(uvo);
		      
		      
		      return result;
		   }
		   
		   //���̵� ã��Ȯ��
		   @ResponseBody
		   @RequestMapping(value = "/findId", method = RequestMethod.POST)
		   public String findId(@ModelAttribute("data") UserVO uvo) {
		      log.info("findId ȣ�� ����");
		      
		      String result = "";
		      
		      
		      result =  userService.userFindId(uvo);
		      
		      
		      
		      return result;
		   }
		   
		 //��й�ȣ ã��Ȯ��
		   @ResponseBody
		   @RequestMapping(value = "/findPwd", method = RequestMethod.POST)
		   public String findPwd(@ModelAttribute("data") UserVO uvo) {
		      log.info("findPwd ȣ�� ����");
		         
		      String result = "";
		         
		         
		      result =  userService.userFindPwd(uvo);
		         
		         
		         
		      return result;
		   }
}

