package com.studyit.mvc;

import java.util.ArrayList;

public interface IParticipant_report_list_DAO
{
	// 스터디원 신고 리스트 출력
	public ArrayList<Participant_report_list_DTO> list();
	
	// 처리안 된 스터디원 수 출력
	public int count();
}
