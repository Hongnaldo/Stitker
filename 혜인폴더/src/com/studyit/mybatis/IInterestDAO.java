/*===============
 IInformDAO.java
 - 인터페이스
================*/

package com.studyit.mybatis;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;


public interface IInterestDAO
{
	public ArrayList<InterestDTO> imList();

	//public ArrayList<InformDTO> infoList() throws SQLException;
}
