package com.spring.mta.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.spring.mta.service.ReplyService;
import com.spring.mta.vo.ReplyVO;
import com.spring.mta.vo.UserVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

/**************************************************************
 * ���� : REST(Representational State Transfer)�� ���� 
 *      �ϳ��� URI�� �ϳ��� ������ ���ҽ��� ��ǥ�ϵ��� ����ȴٴ� �����̴�. 
 *      �� REST����� Ư�� URL�� �ݵ�� �׿� �����ϴ� ������ ��ü��� ���� �ǹ��ϴ� ����̴�. 
 *      ���� ��� 'board/125'�� �Խù� �߿��� 125���̶�� ������ �ǹ̸� �������� �����ϰ�, 
 *      �̿� ���� ó���� GET, POST ��İ� ���� �߰����� ������ ���ؼ� �����Ѵ�.
 **************************************************************/

/**************************************************************
 * ���� : @RestController (@Controller + @ResponesBody)
 * Controller�� REST ����� ó���ϱ� ���� ������ ���. (������ Ư���� JSP�� ���� �並 ����� 
 * ���� ���� ������ �ƴ� REST ����� ������ ó���� ���ؼ� ����ϴ�(������ ��ü�� ��ȯ) ������̼��̴�.
 * @param <ReplyVO>
 * @ResponesBody: �Ϲ����� JSP�� ���� ��� ���޵Ǵ� �� �ƴ϶� ������ ��ü�� �����ϱ� ���� �뵵�̴�.
 * @PathVariable: URL ��ο� �ִ� ���� �Ķ���ͷ� �����Ϸ��� �� �� ����Ѵ�.
 * @RequestBody: JSON �����͸� ���ϴ� Ÿ������ ���ε� ó���Ѵ�.
 **************************************************************/

@RestController
@RequestMapping(value="/replies")
@Log4j
@AllArgsConstructor
public class ReplyController {

	private ReplyService replyService;
	
	/**************************************************************
	* ��� �۸�� �����ϱ�
	* @return List<ReplyVO>
	* ���� : @PathVariable�� URI�� ��ο��� ���ϴ� �����͸� �����ϴ� �뵵�� ������̼�.
	* ���� ��û URL : http://localhost:8080/replies/all/�Խ��Ǳ۹�ȣ
	* ���� ��û URL : http://localhost:8080/replies/replyList?b_num=�Խ��Ǳ۹�ȣ
	* ResponseEntity�� �����ڰ� ���� ��� �����Ϳ� HTTP ���� �ڵ带 ���� ������ �� �ִ� Ŭ����.
	**************************************************************/	
	
	@GetMapping(value = "/all/{n_no}", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	   public ResponseEntity<List<ReplyVO>> replyList(@PathVariable("n_no") Integer n_no){
	      log.info("list ȣ�� ����");
	      
	      ResponseEntity<List<ReplyVO>> entity = null;
	      entity = new ResponseEntity<>(replyService.replyList(n_no), HttpStatus.OK);
	      return entity;
	   }
	/**************************************************************
	 * ��� �۾��� �����ϱ�
	 * @return String
	* ���� : @RequestBody
	* 	consumes �Ӽ��� �̿��ϸ� ����ڰ� Request Body�� ��� Ÿ���� ������ �� ������ 
	* 	��û�� ����� �ݵ�� application/json�� �����ؾ� �Ѵ�.
	* 	produces �Ӽ��� �߰��ϰ� dataType�� �����ϸ� �ش� ������Ÿ�����θ� 
	* 	����ڿ��� �����ϰڴٴ� �ǹ̷� �ؼ��ϸ� �ȴ�.
	**************************************************************/	
	
	@PostMapping(value = "/replyInsert", consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE}) 
	public ResponseEntity<String> replyInsert(@RequestBody ReplyVO rvo,  HttpSession session){
		log.info("replyInsert ȣ�� ����");
		log.info("ReplyVO :" + rvo);
		int result = 0; 
		
		UserVO uvo = (UserVO)session.getAttribute("userInfo");
		rvo.setUser_id(uvo.getUser_id());
		
		result = replyService.replyInsert(rvo);
		return result==1 ? new ResponseEntity<String>("SUCCESS", HttpStatus.OK):
						   new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	/************************************************************************************
	 * ������ ��� ���� ��ȸ �ϱ�
	 * ���� ��û url:http://localhost:8080/repiles/��۹�ȣ(nc_no��)
	 * @return ReplyVO
	 ************************************************************************************/
	@GetMapping(value = "/{nc_no}",
				produces = {MediaType.APPLICATION_XML_VALUE,
							MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyVO> replySelect(@PathVariable("nc_no")Integer nc_no){
		log.info("replySelect ȣ�� ����");
		
		ResponseEntity<ReplyVO> entity = null;
		entity = new ResponseEntity<>(replyService.replySelect(nc_no), HttpStatus.OK);
		//replyService.replySelect(nc_no),HttpStatus.OK
		return entity;
	}
	 
	/************************************************************************************
	 * ��� ���� �����ϱ�
	 * @return
	 * ���� : rest��Ŀ��� update �۾��� put,patch����� �̿��ؼ� ó��.
	 * ��ü �����͸� �����ϴ� ��쿡�� put�� �̿��ϰ�,
	 * �Ϻε����͸� �����ϴ� ��쿡�� patch�� ���̿�
	 * ���� ��û url:http://localhost:8080/repiles/��۹�ȣ(nc_no��)
	 ************************************************************************************/
	
	@RequestMapping(value="/{nc_no}",
				method = {RequestMethod.PUT,RequestMethod.PATCH},
				consumes = "application/json",
				produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> replyUpdate(@PathVariable("nc_no")Integer nc_no,
				@RequestBody ReplyVO rvo){
		log.info("replyUpdate ȣ�� ����");
		rvo.setNc_no(nc_no);
		rvo.setUser_id("lss8710");
		log.info("ReplyVO :" + rvo);
		int result = replyService.replyUpdate(rvo);
		log.info("result :" + result);
		return result==1 ? new ResponseEntity<String>("SUCCESS", HttpStatus.OK):
			   			   new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
	
	/************************************************************************************
	 * ��� ���� �����ϱ�
	 * @return
	 * ���� : rest��Ŀ��� delete �۾��� delete����� �̿��ؼ� ó��.
	 * ���� ��û url:http://localhost:8080/repiles/��۹�ȣ(nc_no��)
	 ************************************************************************************/
	
	@DeleteMapping(value = "/{nc_no}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> replyDelete(@PathVariable("nc_no")Integer nc_no){
		log.info("replyDelete ȣ�� ����");
		log.info("nc_no ="+nc_no);
		
		int result = replyService.replyDelete(nc_no);
		return result==1 ? new ResponseEntity<String>("SUCCESS", HttpStatus.OK):
			   			   new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
}
