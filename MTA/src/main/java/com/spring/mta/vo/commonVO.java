package com.spring.mta.vo;


//import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


//@Data
@ToString
@Setter
@Getter
public class commonVO {
	//���ǰ˻��� ����� �ʵ�(�˻����, �˻��ܾ�)
	private String search = "";
	private String keyword = "";
	
	//��¥�˻��� ����� �ʵ�(������, ������)
	private String start_date = "";
	private String end_date = "";
	
	private int pageNum = 0; //������ ��ȣ
	private int amount  = 0; //�������� ������ ������ ��
	
	public commonVO() {
		this(1, 10);
	}
	
	public commonVO(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
}
