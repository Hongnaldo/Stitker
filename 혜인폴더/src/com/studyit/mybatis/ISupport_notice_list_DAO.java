package com.studyit.mybatis;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface ISupport_notice_list_DAO
{
	// �������� ����Ʈ
	public ArrayList<Support_notice_list_DTO> list();
	
	// ��ȸ�� 1 ������Ű��
	public void addHitCount(@Param("notice_code")String notice_code);
	
	// ����������
	public Support_notice_list_DTO detail(@Param("notice_code")String notice_code);
	
	// �������� ����ϱ�
	public int insert(Support_notice_list_DTO dto);
	
	// �������� �����ϱ�
	public int modify(Support_notice_list_DTO dto);
	
	// �������� �����ϱ�
	public int delete(String notice_code);
	
	// �ڵ�� �� �ҷ�����
	public Support_notice_list_DTO searchCode(String notice_code);
}