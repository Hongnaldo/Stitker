/*=====================================
	IFindPwDAO.java
	- 인터페이스
	- 비밀번호 찾기 관련 메소드 정의
=====================================*/

package com.studyit.mybatis;

import java.util.ArrayList;

public interface IFindPwDAO
{
	//public String findPwByEmail(String email);
	
	public String rndPw(); 
	
	public int updatePwByEmail(String rndStr, String email);
	
	
	
	//public String findPwByQna(String question, String anwser);
	
	public ArrayList<String> questionList();
}
