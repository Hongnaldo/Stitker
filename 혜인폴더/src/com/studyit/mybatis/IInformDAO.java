/*===============
 IInformDAO.java
 - 인터페이스
================*/

package com.studyit.mybatis;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;


public interface IInformDAO
{
	public int add(InformDTO inform);
	public ArrayList<InformDTO> list();
	public int count();
	public int modify(InformDTO inform);
	public int remove(InformDTO inform);
	public int hitcounts(String post_num);
	
	public ArrayList<InterestDTO> imList();
	
	public int cmtAdd(CmtInformDTO cmtInform);
	public ArrayList<CmtInformDTO> cmtList(String post_num);
	public int cmtCount(String post_num);
	public int cmtModify(CmtInformDTO cmtInform);
	public int cmtRemove(CmtInformDTO cmtInform);
	
	
	public InformDTO detail(String post_num);
	
	
	//public ArrayList<InformDTO> infoList() throws SQLException;
}
