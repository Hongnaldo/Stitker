package com.studyit.mybatis;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface ISupport_QA_list_DAO
{
	// 1:1 ���� ����Ʈ
	public ArrayList<Support_QA_list_DTO> list();
	
	// 1:1 ���� ��������	
	public Support_QA_list_DTO detail(String ask_code);
	
	// �亯�ؾ��ϴ� 1:1 ���� ���� 
	public int count();
	
	// 1:1 ���� ���
	public int insertQ(Support_QA_list_DTO dto);
	
	// 1:1 �亯 ���
	public int insertA(Support_QA_list_DTO dto);
	
	// �������̵�� �����ڵ� ã��
	public String findUserCode(String id);
	
	// 1:1 ���� ����
	public int modifyQ(Support_QA_list_DTO dto);
	
	// �ڵ�� ���� �ҷ�����
	public Support_QA_list_DTO searchCode(String ask_code);
	
}
