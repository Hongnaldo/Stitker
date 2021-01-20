package com.studyit.mybatis;

import java.util.ArrayList;

public interface IParticipant_report_list_DAO
{
	// ���͵�� �Ű� ����Ʈ ���
	public ArrayList<Participant_report_list_DTO> list();
	
	// ó���� �� ���͵�� �� ���
	public int count();
}
