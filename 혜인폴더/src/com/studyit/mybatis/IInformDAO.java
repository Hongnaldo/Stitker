/*===============
 IInformDAO.java
 - 인터페이스
================*/

package com.studyit.mybatis;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;


public interface IInformDAO
{
	public int add(InformDTO inform);

	public ArrayList<InformDTO> list();
	public int count();
	public int modify(InformDTO inform);
	public int remove(InformDTO inform);
	public void hitcounts(String post_code);
	public void recAdd(String post_code);
	public void recNotAdd(String post_code);
	public String interestMc(@Param("interest_mc") String interest_mc);
	
	public ArrayList<InterestDTO> imList();
	
	public int cmtAdd(CmtInformDTO cmtInform);
	public ArrayList<CmtInformDTO> cmtList(String post_code);
	public int cmtCount(String post_code);
	public int cmtModify(CmtInformDTO cmtInform);
	public int cmtRemove(CmtInformDTO cmtInform);
	
	
	public InformDTO detail(String post_code);
	
	
	//public ArrayList<InformDTO> infoList() throws SQLException;
}
