/*===============
 IInformDAO.java
 - 인터페이스
================*/

package com.studyit.mybatis;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;


public interface ICmtInformDAO
{
	public int cmtAdd(CmtInformDTO cmtInform);
	public ArrayList<CmtInformDTO> cmtList(String post_num);
	public int cmtCount(String post_num);
	public int cmtModify(CmtInformDTO cmtInform);
	public int cmtRemove(CmtInformDTO cmtInform);
	

}
