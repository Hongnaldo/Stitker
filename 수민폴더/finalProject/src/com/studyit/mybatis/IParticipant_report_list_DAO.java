package com.studyit.mybatis;

import java.util.ArrayList;
import java.util.HashMap;

public interface IParticipant_report_list_DAO
{
	// 신고처리할 스터디원 리스트
	public ArrayList<Participant_report_list_DTO> list();
	
	// 신고처리할 스터디원 수
	public int count();
	
	// 스터디원 경고 등록
	public int insertWarning(HashMap<String, String>param);
	
	// 신고처리 업데이트
	public int updateRhParti(String reported_parti_code);
	
	// 신고등록 삭제
	public int deleteRegParti(String reported_parti_code);
	
	// 신고처리 삭제
	public int deleteRhParti(String reported_parti_code);
	
}
