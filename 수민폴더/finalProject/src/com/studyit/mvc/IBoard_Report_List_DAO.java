package com.studyit.mvc;

import java.util.ArrayList;

public interface IBoard_Report_List_DAO
{
	// �Խù� ����Ʈ ��������
	public ArrayList<Board_Report_List_DTO> list();
	
	// �� �Խù� ���� ����
	public int count();
}
