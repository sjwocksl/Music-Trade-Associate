package com.spring.mta.vo;

import lombok.Data;

@Data
public class paymentVO {
	private int p_no = 0;	// ���� ��ȣ
	private String user_id=""; // ���� ���̵�
	private String p_date ;		// ���� �Ͻ�
	private String p_t_price="";	// ��������
}
