package com.studyit.mvc;

public class EndstudyDTO
{
	// 주요 속성 구성 
	private String rnum, study_name, period, leader, weekday, start_time,
	         end_time, place, progress, nowpgs, user_code;
	
	//getter / setter 구성
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

	public String getPeriod()
	{
		return period;
	}

	public void setPeriod(String period)
	{
		this.period = period;
	}

	public String getLeader()
	{
		return leader;
	}

	public void setLeader(String leader)
	{
		this.leader = leader;
	}

	public String getWeekday()
	{
		return weekday;
	}

	public void setWeekday(String weekday)
	{
		this.weekday = weekday;
	}

	public String getStart_time()
	{
		return start_time;
	}

	public void setStart_time(String start_time)
	{
		this.start_time = start_time;
	}

	public String getEnd_time()
	{
		return end_time;
	}

	public void setEnd_time(String end_time)
	{
		this.end_time = end_time;
	}

	public String getPlace()
	{
		return place;
	}

	public void setPlace(String place)
	{
		this.place = place;
	}

	public String getProgress()
	{
		return progress;
	}

	public void setProgress(String progress)
	{
		this.progress = progress;
	}

	public String getNowpgs()
	{
		return nowpgs;
	}

	public void setNowpgs(String nowpgs)
	{
		this.nowpgs = nowpgs;
	}

	public String getUser_code()
	{
		return user_code;
	}

	public void setUser_code(String user_code)
	{
		this.user_code = user_code;
	}
	
	
}
