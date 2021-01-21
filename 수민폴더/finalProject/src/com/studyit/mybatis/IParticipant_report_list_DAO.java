package com.studyit.mybatis;

import java.util.ArrayList;

public interface IParticipant_report_list_DAO
{
	// 신고처리할 스터디원 리스트
	public ArrayList<Participant_report_list_DTO> list();
	
	// 신고처리할 스터디원 수
	public int count();
}
