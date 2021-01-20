package com.studyit.mvc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class Support_QA_list_Controller
{
	@Autowired
	private SqlSession sqlSession;
	
	// 리스트페이지 조회
	@RequestMapping(value="/supportqalist.action", method=RequestMethod.GET)
	public String list(Model model)
	{
		String result = null;
		result = "/WEB-INF/views/Support_Q&A_list.jsp";
		
		ISupport_QA_list_DAO dao = sqlSession.getMapper(ISupport_QA_list_DAO.class);
		
		model.addAttribute("list", dao.list());
		model.addAttribute("count", dao.count());
		
		return result;
	}
	
	// 상세페이지 조회
	@RequestMapping(value="/supportqadetail.action", method=RequestMethod.GET)
	public String detail(ModelMap model, HttpServletRequest request)
	{
		String result = null;
		result = "/WEB-INF/views/Support_Q&A_detailpage.jsp";
		
		ISupport_QA_list_DAO dao = sqlSession.getMapper(ISupport_QA_list_DAO.class);
		
		model.addAttribute("qa", dao.detail(request.getParameter("ask_code")));
		
		return result;
	}
	
	// 질문 등록 폼
	@RequestMapping(value="/supportqawrite.action", method=RequestMethod.GET)
	public String insertForm()
	{
		String result = null;
		result = "/WEB-INF/views/Support_Q&A_register.jsp";
		
		return result;
	}
	
	// 질문 등록
	@RequestMapping(value="/supportqainsertq.action", method=RequestMethod.POST)
	public String insertQ(Support_QA_list_DTO dto)
	{
		String result = null;
		result = "redirect:supportqalist.action";
		
		ISupport_QA_list_DAO dao = sqlSession.getMapper(ISupport_QA_list_DAO.class);
		
		// 로그인으로 구현
		dto.setUser_code(dao.findUserCode("ljj33"));
		
		dto.setAsk_content(dto.getAsk_content().replaceAll("\n", "<br>"));
		
		dao.insertQ(dto);
		
		
		return result;
	}
	
	// 답변 등록
	@RequestMapping(value="/supportqainserta.action", method=RequestMethod.POST)
	public String insertA(Support_QA_list_DTO dto)
	{
		String result = null;
		result = "redirect:supportqalist.action";
		
		ISupport_QA_list_DAO dao = sqlSession.getMapper(ISupport_QA_list_DAO.class);
		
		// 로그인으로 구현
		dto.setAdmin_code("AD1");
		
		dao.insertA(dto);
		
		return result;
	}
	
	// 질문 수정 폼
	@RequestMapping(value="/supportqamodifyqform.action", method=RequestMethod.GET)
	public String modifyForm(HttpServletRequest request, ModelMap model)
	{
		String result = null;
		result = "/WEB-INF/views/Support_Q&A_modify.jsp";
		
		ISupport_QA_list_DAO dao = sqlSession.getMapper(ISupport_QA_list_DAO.class);
		
		model.addAttribute("dto", dao.searchCode(request.getParameter("ask_code")));
		
		return result;
	}
	
	// 질문 수정
	@RequestMapping(value="/supportqamodifyq.action", method=RequestMethod.GET)
	public String modifyQ(Support_QA_list_DTO dto)
	{
		String result = null;
		result = "redirect:supportqadetail.action?ask_code=" + dto.getAsk_code();
		
		dto.setAsk_content(dto.getAsk_content().replaceAll("\n", "<br>"));
		
		ISupport_QA_list_DAO dao = sqlSession.getMapper(ISupport_QA_list_DAO.class);
		dao.modifyQ(dto);
		
		return result;
	}
}
