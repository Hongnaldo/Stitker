package com.studyit.mvc;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface ISupport_notice_list_DAO
{
	// 공지사항 리스트
	public ArrayList<Support_notice_list_DTO> list();
	
	// 조회수 1 증가시키기
	public void addHitCount(@Param("notice_code")String notice_code);
	
	// 세부페이지
	public Support_notice_list_DTO detail(@Param("notice_code")String notice_code);
	
	// 공지사항 등록하기
	public int insert(Support_notice_list_DTO dto);
	
	// 공지사항 수정하기
	public int modify(Support_notice_list_DTO dto);
	
	// 공지사항 삭제하기
	public int delete(String notice_code);
	
	// 코드로 글 불러오기
	public Support_notice_list_DTO searchCode(String notice_code);
}