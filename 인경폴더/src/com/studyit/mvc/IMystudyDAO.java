package com.studyit.mvc;

import java.util.ArrayList;

public interface IMystudyDAO
{
	public ArrayList<MystudyDTO> endlist();
	public ArrayList<MystudyDTO> nowlist();
	public ArrayList<MystudyDTO> cancellist();
	public ArrayList<MystudyDTO> upcominglist();
	public int count();
}
