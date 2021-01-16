/*======================
  INowstudyDAO.java
 ======================*/
package com.studyit.mvc;

import java.util.ArrayList;

public interface INowstudyDAO
{
	/*
	// 성적 데이터 인원 수 확인
		public int count();
		
		// 성적 데이터 리스트 확인
		public ArrayList<GradeDTO> list();
		
		// 성적 데이터 입력(추가)
		public int add(GradeDTO g);
	*/
	
	// 스터디 데이터 리스트 확인 
	public ArrayList<NowstudyDTO> list();
	
	// 스터디 리더의 아이디 확인 
	public String leaderCheck();
	
	
}
