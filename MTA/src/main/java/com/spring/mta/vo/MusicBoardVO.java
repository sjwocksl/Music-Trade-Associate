package com.spring.mta.vo;

import org.springframework.web.multipart.MultipartFile;


import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class MusicBoardVO extends commonVO{
	private int m_no=0;			//���ǰԽ��� �� ��ȣ
	private String m_title="";	//���ǰԽ��� �� ����
	private String m_name="";	//��������
	private String m_bpm="";	//���� �Խ��� bpm
	private String m_explan="";	//���� �Խ��� ���Ǽ���
	private String m_regdate;	//���� �Խ��� �����
	private String m_price="";	//���� �Ǹ� ����
	private String m_genre = "";//���� �帣
	private int    m_isfree=0;	//��ǥ���� ����
	private int m_stock = 1; 	//���
	
	private int m_recommentcnt=0;//���� �Խ��� ��õ��
	private int m_views  = 0;	// ���� �Խ��� ��ȸ��
	private int m_replyCnt = 0;	// ���� �Խ��� ��۰���
	
	private String user_id	="";// �������̵�
	
	
	private String m_coverimage="";	// ���� Ŀ���̹��� ���
	private MultipartFile cover_file; // Ŀ���̹���
	
	private String m_file="";		// ���� ���� ���
	private MultipartFile file;		// ���� ����
}
