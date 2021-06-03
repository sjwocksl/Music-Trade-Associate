package com.spring.mta.vo;

import org.springframework.web.multipart.MultipartFile;

import com.spring.mta.vo.freeBoardVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class freeBoardVO extends commonVO{
	private int		f_no		=0; //�۹�ȣ
	private String	f_title		="";//������
	private String 	f_text		="";//�۳���
	private String f_regdate;		//�۵����
	
	private int	f_recommentCnt   	=0;//��õ��
	private int f_replyCnt 			=0;//��ۼ�
	private int f_viewsCnt 			=0;//����ȸ��
	
	private String user_id = "";	//�������̵�
	
	private	MultipartFile file;//�� ÷������
	private String f_file =""; 		//���� �̸�
}
