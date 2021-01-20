package com.studyit.mvc;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class Board_report_list_Controller
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value="boardreportlist.action", method=RequestMethod.GET)
	public String list(Model model)
	{
		IBoard_report_list_DAO dao = sqlSession.getMapper(IBoard_report_list_DAO.class);
		String result = null;
		
		model.addAttribute("list", dao.list());
		model.addAttribute("count", dao.count());
		
		
		result = "/WEB-INF/views/Board_report_list.jsp";
		
		return result;
	}
	
	
}
