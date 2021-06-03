package com.spring.mta.dao;

import com.spring.mta.vo.UserVO;

public interface UserDao {

	public UserVO login(UserVO uvo);
	public int userUpdate(UserVO uvo);
	
	public int userInsert(UserVO uvo);
	//�ߺ�Ȯ��
	public int checkOverId(UserVO uvo);
	//���̵� ã��
	public String userFindId(UserVO uvo);
	//��й�ȣ ã��
	public String userFindPwd(UserVO uvo);

}
