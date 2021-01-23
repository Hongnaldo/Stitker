package com.studyit.mybatis;

import java.sql.SQLException;
import java.util.ArrayList;



public interface IInterview
{
	public ArrayList<InterviewDTO> list() throws SQLException;
	public ArrayList<InterviewDTO> interestlist() throws SQLException;
	public int count() throws SQLException;
	public int add(InterviewDTO dto) throws SQLException;
	public InterviewDTO searchlist(String post_code) throws SQLException;
	public int remove(String post_code) throws SQLException;
	public int hitcount(String post_code) throws SQLException;
	public int addComment(String post_code, String user_code, String comments) throws SQLException;
	public ArrayList<InterviewCommentDTO> commentlist(String post_code) throws SQLException;
	public int addRec(String post_code, String user_code) throws SQLException;
	public int addNotRec(String post_code, String user_code) throws SQLException;
	public int recCheck(String post_code, String user_code) throws SQLException;
}
