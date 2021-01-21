/*==============================
	ISuspendDAO.java
	- 인터페이스.
==============================*/

package com.test.mvc;

import java.sql.SQLException;
import java.util.ArrayList;

public interface ISuspendDAO
{	
	public Suspend searchId(String suspend_code) throws SQLException;
	
	public String login(String id, String pw) throws SQLException;
	public String loginAdmin(String id, String pw) throws SQLException;
	
}
