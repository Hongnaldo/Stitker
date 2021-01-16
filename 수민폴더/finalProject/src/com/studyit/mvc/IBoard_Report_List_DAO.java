package com.studyit.mvc;

import java.util.ArrayList;

public interface IBoard_Report_List_DAO
{
	// 게시물 리스트 가져오기
	public ArrayList<Board_Report_List_DTO> list();
	
	// 총 게시물 갯수 세기
	public int count();
}
