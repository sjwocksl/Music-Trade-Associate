package com.spring.mta.vo;

import lombok.Data;

@Data
public class mcommentVO {
	private int mc_no = 0; // ���� ��� ��ȣ
	private int m_no = 0; // ���� �� ��ȣ
	private String mc_text = "";	// ��� ����
	private String mc_regdate;		// ��� �����
	private String user_id;			// ����� ���̵�
	
}
