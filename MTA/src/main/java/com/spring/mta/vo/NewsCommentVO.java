package com.spring.mta.vo;

import lombok.Data;

@Data
public class NewsCommentVO {
	private int n_no=0;		// ���� �� ��ȣ
	private int nc_no=0;	// ���� ��� ��ȣ
	private String nc_text="";		// ���� ��� ����
	private String user_id="";		// ���� ���̵�
	private String nc_regdate;		// ���� ��� �����
	
}
