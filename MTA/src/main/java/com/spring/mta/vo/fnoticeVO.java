package com.spring.mta.vo;

import lombok.Data;

@Data
public class fnoticeVO {
	private int fn_no = 0;		//������ȣ
	private String fn_title =""; 	//���� Ÿ��Ʋ
	private String fn_text = "";	//���� ����
	private String fn_regdate;		//���� �����
	private String mg_id;			//�Ŵ��� ���̵�
	
}
