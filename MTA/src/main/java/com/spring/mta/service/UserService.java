package com.spring.mta.service;



import com.spring.mta.vo.UserVO;


public interface UserService {

	public UserVO login(UserVO uvo);
	public int userUpdate(UserVO uvo) throws Exception;
	
	public int userInsert(UserVO uvo);
	//���̵� �ߺ�Ȯ��
	public int userIdCheck(UserVO uvo);
	//���̵�ã��
	public String userFindId(UserVO uvo);
	//��� ��ȣ ã��
	public String userFindPwd(UserVO uvo);
	

}
