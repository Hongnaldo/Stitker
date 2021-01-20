package com.studyit.mvc;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class Report_detail_Controller
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value="/reportdetail.action", method=RequestMethod.GET)
	public String list(Model model, HttpServletRequest request)
	{
		String result = null;
		result = "/WEB-INF/views/Report_detailpage.jsp";
		
		IReport_detail_DAO dao = sqlSession.getMapper(IReport_detail_DAO.class);
		
		model.addAttribute("list", dao.list(request.getParameter("report_code")));
		
		return result;
	}
	
	@RequestMapping(value="/memreportdetail.action", method=RequestMethod.GET)
	public String memList(Model model, HttpServletRequest request)
	{
		String result = null;
		result = "/WEB-INF/views/Report_detailpage.jsp";
		
		IReport_detail_DAO dao = sqlSession.getMapper(IReport_detail_DAO.class);
		
		model.addAttribute("memList", dao.memList(request.getParameter("reported_code")));
		
		return result;
	}
}
