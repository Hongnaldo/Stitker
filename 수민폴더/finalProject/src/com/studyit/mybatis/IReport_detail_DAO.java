package com.studyit.mybatis;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface IReport_detail_DAO
{
	public ArrayList<Report_detail_DTO> list(@Param("report_code")String report_code);
	
	public ArrayList<Report_detail_DTO> memList(@Param("reported_parti_code")String reported_parti_code);
	
}
