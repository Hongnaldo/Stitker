package com.studyit.mybatis;

import java.util.ArrayList;

public interface IBoard_report_list_DAO
{
	// �Խù� ����Ʈ ��������
	public ArrayList<Board_report_list_DTO> list();
	
	// �� �Խù� ���� ����
	public int count();
}
