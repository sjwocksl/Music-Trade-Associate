package com.spring.mta.vo;

import lombok.Data;

@Data
public class serviceVO extends commonVO {
	private int scb_no = 0;	// ���� �� ��ȣ
	private String scb_title=""; // ���� �� ����
	private String scb_text="";	// ���� �� ����
	private String scb_regdate;	// ���� �����
	private int scb_replyCnt = 0; // ���� ��� ��
	private String user_id;		//���� ���̵�
}