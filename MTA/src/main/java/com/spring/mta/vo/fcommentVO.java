package com.spring.mta.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class fcommentVO {
	private int fc_no = 0;	//�ڰ�_���۹�ȣ
	private String fc_text = ""; // �ڰ�_���۳���
	private String fc_regdate = ""; // �ڰ� ���۵����
	
	
	private String user_id = ""; //�������̵�
	private int f_no ;			//�����Խ��� ��ȣ
	
}
