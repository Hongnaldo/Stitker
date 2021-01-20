package com.studyit.mvc;

public class Participant_report_list_DTO
{
	private String rnum, study_name, reported_id, handle_result, handle_code, reported_code;

	public String getRnum()
	{
		return rnum;
	}

	public void setRnum(String rnum)
	{
		this.rnum = rnum;
	}

	public String getStudy_name()
	{
		return study_name;
	}

	public void setStudy_name(String study_name)
	{
		this.study_name = study_name;
	}
	
	public String getHandle_result()
	{
		return handle_result;
	}

	public void setHandle_result(String handle_result)
	{
		this.handle_result = handle_result;
	}

	public String getReported_id()
	{
		return reported_id;
	}

	public void setReported_id(String reported_id)
	{
		this.reported_id = reported_id;
	}

	public String getHandle_code()
	{
		return handle_code;
	}

	public void setHandle_code(String handle_code)
	{
		this.handle_code = handle_code;
	}

	public String getReported_code()
	{
		return reported_code;
	}

	public void setReported_code(String reported_code)
	{
		this.reported_code = reported_code;
	}
	
}
