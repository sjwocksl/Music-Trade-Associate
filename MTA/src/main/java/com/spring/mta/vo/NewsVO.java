package com.spring.mta.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class NewsVO extends commonVO{
		private int n_no=0;
	  
	    private String n_text="";
	    private String n_regdate;
	    private String n_title="";
	    private String n_note="";
	    private String user_id="";
	    
	    
	    private String n_image="";	// ���� ���
	    private MultipartFile file; //���� ��ü
	    private String n_thumb 	=""; //���� �������� ������ ����� �̹��� ���Ͽ� 
	
	
}
