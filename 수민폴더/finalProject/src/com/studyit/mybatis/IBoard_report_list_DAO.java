package com.studyit.mybatis;

import java.util.ArrayList;

public interface IBoard_report_list_DAO
{
	// 리스트 
	public ArrayList<Board_report_list_DTO> list();
	
	// 처리해야하는 신고게시물 개수
	public int count();
}
