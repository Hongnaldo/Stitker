package com.studyit.mvc;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface ISupport_QA_list_DAO
{
	// 1:1 질문 리스트
	public ArrayList<Support_QA_list_DTO> list();
	
	// 1:1 질문 상세페이지	
	public Support_QA_list_DTO detail(String ask_code);
	
	// 답변해야하는 1:1 질문 갯수 
	public int count();
	
	// 1:1 질문 등록
	public int insertQ(Support_QA_list_DTO dto);
	
	// 1:1 답변 등록
	public int insertA(Support_QA_list_DTO dto);
	
	// 유저아이디로 유저코드 찾기
	public String findUserCode(String id);
	
	// 1:1 질문 수정
	public int modifyQ(Support_QA_list_DTO dto);
	
	// 코드로 내용 불러오기
	public Support_QA_list_DTO searchCode(String ask_code);
	
}
