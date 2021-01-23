/*============================================
	SuspendDAO.java
	인터페이스 자료형 / setter 구성
============================================*/

package com.test.mvc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

public class SuspendDAO implements ISuspendDAO
{
	// 인터페이스 자료형 기반 속성 구성
	private DataSource dataSource;

	// setter 메소드 구성
	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}

	// 인터페이스에서 선언된 메소드 재정의--------------------------------
	
	

	// 계정정지 회원 검색
	@Override
	public Suspend searchId(String suspend_code) throws SQLException
	{
		Suspend result = new Suspend();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT ID, ACCT_SUS_CODE, ACCT_SUS_DATE, ACCT_SUS_DATE_END "
				+ "FROM  VIEW_ACCOUNT_SUSPEND "
				+ "WHERE ACCT_SUS_CODE = ? ";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, suspend_code);
		
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next())
		{	
			
			result.setId(rs.getString("ID"));
			result.setAcct_sus_code(rs.getString("ACCT_SUS_CODE"));
			result.setAcct_sus_date(rs.getString("ACCT_SUS_DATE"));
			result.setAcct_sus_date_end(rs.getString("ACCT_SUS_DATE_END"));
			
			// ↓ (문제되면 제거)
			result.setSuspend_code(suspend_code);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	// 일반 직원 로그인
	@Override
	public String login(String id, String pw) throws SQLException
	{
		String result = null;
		
		Connection conn = dataSource.getConnection();
		String sql="SELECT NAME FROM EMPLOYEE WHERE EMPLOYEEID=? AND SSN2= CRYPTPACK.ENCRYPT(?,?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(id));
		pstmt.setString(2, pw);
		pstmt.setString(3, pw);
		
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next())
		{
			result = rs.getString("NAME");
		}
		rs.close();
		pstmt.close();
		conn.close();
		return result;
	}

	// 관리자 로그인
	@Override
	public String loginAdmin(String id, String pw) throws SQLException
	{
		String result=null;
		
		Connection conn = dataSource.getConnection();
		String sql ="SELECT NAME FROM EMPLOYEE WHERE EMPLOYEEID=? AND SSN2= CRYPTPACK.ENCRYPT(?,?) AND GRADE=0";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(id));
		pstmt.setString(2, pw);
		pstmt.setString(3, pw);
		
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next())
		{
			result = rs.getString("NAME");
		}
		rs.close();
		pstmt.close();
		conn.close();
		return result;
	}

	
	// --------------------------------인터페이스에서 선언된 메소드 재정의
	
	
	
}
