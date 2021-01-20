package com.studyit.mvc;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class Participant_report_list_Controller
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping (value="participantreportlist.action", method=RequestMethod.GET)
	public String list(Model model)
	{
		String result = null;
		result = "/WEB-INF/views/Participant_report_list.jsp";
		
		IParticipant_report_list_DAO dao = sqlSession.getMapper(IParticipant_report_list_DAO.class);
		
		model.addAttribute("list", dao.list());
		model.addAttribute("count", dao.count());
		
		return result;
	}
}
