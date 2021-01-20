/*===============
 IInformDAO.java
 - 인터페이스
================*/

package com.studyit.mybatis;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;


public interface ISeminarDAO
{
	public int add(SeminarDTO inform);
	public ArrayList<SeminarDTO> list();
	public int count();
	public int modify(SeminarDTO inform);
	public int remove(SeminarDTO inform);
	public int hitcounts(String post_num);
	
	public ArrayList<SeminarCtgDTO> scList();
	
	
	public SeminarDTO detail(String post_num);
	
	//public ArrayList<InformDTO> infoList() throws SQLException;
}
