package com.studyit.mybatis;

import java.sql.SQLException;
import java.util.ArrayList;



public interface IStudyReview
{
	public ArrayList<StudyReviewDTO> list() throws SQLException;
	public ArrayList<StudyReviewDTO> interestlist() throws SQLException;
	public int count() throws SQLException;
	
}
