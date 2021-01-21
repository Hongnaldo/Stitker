package com.studyit.mybatis;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
	
	// 1:1질문 리스트
	@RequestMapping(value="/supportqalist.action", method=RequestMethod.GET)
	public String list(Model model, HttpServletRequest request)
	{
		String result = null;
		
		// 세션 처리 과정 추가(로그인에 대한 확인 과정 추가) ---------------------------------------------------------
		HttpSession session = request.getSession();
		
		if (session.getAttribute("code") == null)	//-- 로그인이 되어있지 않은 상황
		{
			// 로그인이 되어있지 않은 상황에서의 처리
			result = "redirect:loginform.action";
			return result;
		}
		// --------------------------------------------------------- 세션 처리 과정 추가(로그인에 대한 확인 과정 추가)				
		
		result = "/WEB-INF/views/Support_Q&A_list.jsp";
		
		ISupport_QA_list_DAO dao = sqlSession.getMapper(ISupport_QA_list_DAO.class);
		
		if (session.getAttribute("admin") == "admin")
			model.addAttribute("list", dao.listAdmin());
		else
			model.addAttribute("list", dao.listMember((String)session.getAttribute("userid")));
		
		model.addAttribute("count", dao.count());
		model.addAttribute("admin", (String)session.getAttribute("admin"));
		model.addAttribute("code", (String)session.getAttribute("code"));
		
		return result;
	}
	
	// 1:1질문 상세페이지
	@RequestMapping(value="/supportqadetail.action", method=RequestMethod.GET)
	public String detail(ModelMap model, HttpServletRequest request)
	{
		String result = null;
		
		// 세션 처리 과정 추가(로그인에 대한 확인 과정 추가) ---------------------------------------------------------
		HttpSession session = request.getSession();
		
		if (session.getAttribute("code") == null)	//-- 로그인이 되어있지 않은 상황
		{
			// 로그인이 되어있지 않은 상황에서의 처리
			result = "redirect:loginform.action";
			return result;
		}
		// --------------------------------------------------------- 세션 처리 과정 추가(로그인에 대한 확인 과정 추가)				
		
		result = "/WEB-INF/views/Support_Q&A_detailpage.jsp";
		
		ISupport_QA_list_DAO dao = sqlSession.getMapper(ISupport_QA_list_DAO.class);
		
		model.addAttribute("qa", dao.detail(request.getParameter("ask_code")));
		model.addAttribute("admin", (String)session.getAttribute("admin"));
		model.addAttribute("code", (String)session.getAttribute("code"));
		
		return result;
	}
	
	// 1:1질문 작성 폼
	@RequestMapping(value="/supportqawrite.action", method=RequestMethod.GET)
	public String insertForm(HttpServletRequest request)
	{
		String result = null;
		
		// 세션 처리 과정 추가(로그인에 대한 확인 과정 추가) ---------------------------------------------------------
		HttpSession session = request.getSession();
		
		if (session.getAttribute("code") == null)	//-- 로그인이 되어있지 않은 상황
		{
			// 로그인이 되어있지 않은 상황에서의 처리
			result = "redirect:loginform.action";
			return result;
		}
		// --------------------------------------------------------- 세션 처리 과정 추가(로그인에 대한 확인 과정 추가)				
		
		result = "/WEB-INF/views/Support_Q&A_register.jsp";
		
		return result;
	}
	
	// 1:1질문 등록
	@RequestMapping(value="/supportqainsertq.action", method=RequestMethod.POST)
	public String insertQ(Support_QA_list_DTO dto, HttpServletRequest request)
	{
		String result = null;		

		// 세션 처리 과정 추가(로그인에 대한 확인 과정 추가) ---------------------------------------------------------
		HttpSession session = request.getSession();
		
		if (session.getAttribute("code") == null)	//-- 로그인이 되어있지 않은 상황
		{
			// 로그인이 되어있지 않은 상황에서의 처리
			result = "redirect:loginform.action";
			return result;
		}
		// --------------------------------------------------------- 세션 처리 과정 추가(로그인에 대한 확인 과정 추가)
		
		result = "redirect:supportqalist.action";
		ISupport_QA_list_DAO dao = sqlSession.getMapper(ISupport_QA_list_DAO.class);
		
		dto.setUser_code((String)session.getAttribute("code"));
		dto.setAsk_content(dto.getAsk_content().replaceAll("\n", "<br>"));
		
		dao.insertQ(dto);
		
		return result;
	}
	
	// 1:1답변 등록
	@RequestMapping(value="/supportqainserta.action", method=RequestMethod.POST)
	public String insertA(Support_QA_list_DTO dto, HttpServletRequest request)
	{
		String result = null;
		
		// 세션 처리 과정 추가(로그인에 대한 확인 과정 추가) ---------------------------------------------------------
		HttpSession session = request.getSession();
		
		if (session.getAttribute("code") == null)	//-- 로그인이 되어있지 않은 상황
		{
			// 로그인이 되어있지 않은 상황에서의 처리
			result = "redirect:loginform.action";
			return result;
		}
		// --------------------------------------------------------- 세션 처리 과정 추가(로그인에 대한 확인 과정 추가)
		
		result = "redirect:supportqalist.action";
		ISupport_QA_list_DAO dao = sqlSession.getMapper(ISupport_QA_list_DAO.class);
		
		
		dto.setAdmin_code((String)session.getAttribute("code"));
		
		dao.insertA(dto);
		
		return result;
	}
	
	// 1:1질문 수정폼
	@RequestMapping(value="/supportqamodifyqform.action", method=RequestMethod.GET)
	public String modifyForm(HttpServletRequest request, ModelMap model)
	{
		String result = null;
		
		// 세션 처리 과정 추가(로그인에 대한 확인 과정 추가) ---------------------------------------------------------
		HttpSession session = request.getSession();
		
		if (session.getAttribute("code") == null)	//-- 로그인이 되어있지 않은 상황
		{
			// 로그인이 되어있지 않은 상황에서의 처리
			result = "redirect:loginform.action";
			return result;
		}
		// --------------------------------------------------------- 세션 처리 과정 추가(로그인에 대한 확인 과정 추가)		
		
		result = "/WEB-INF/views/Support_Q&A_modify.jsp";
		
		ISupport_QA_list_DAO dao = sqlSession.getMapper(ISupport_QA_list_DAO.class);
		
		Support_QA_list_DTO dto = dao.searchCode(request.getParameter("ask_code"));
		dto.setAsk_content(dto.getAsk_content().replaceAll("<br>", "\n"));
		
		model.addAttribute("dto", dto);
		
		return result;
	}
	
	// 1:1질문 수정
	@RequestMapping(value="/supportqamodifyq.action", method=RequestMethod.GET)
	public String modifyQ(Support_QA_list_DTO dto, HttpServletRequest request)
	{
		String result = null;
		
		// 세션 처리 과정 추가(로그인에 대한 확인 과정 추가) ---------------------------------------------------------
		HttpSession session = request.getSession();
		
		if (session.getAttribute("code") == null)	//-- 로그인이 되어있지 않은 상황
		{
			// 로그인이 되어있지 않은 상황에서의 처리
			result = "redirect:loginform.action";
			return result;
		}
		// --------------------------------------------------------- 세션 처리 과정 추가(로그인에 대한 확인 과정 추가)				
		
		result = "redirect:supportqadetail.action?ask_code=" + dto.getAsk_code();
		
		dto.setAsk_content(dto.getAsk_content().replaceAll("\n", "<br>"));
		
		ISupport_QA_list_DAO dao = sqlSession.getMapper(ISupport_QA_list_DAO.class);
		dao.modifyQ(dto);
		
		return result;
	}
	
	// 1:1질문 삭제
	@RequestMapping(value="/supportqadeleteq.action", method=RequestMethod.GET)
	public String deleteQ(String ask_code, HttpServletRequest request)
	{
		String result = null;
		
		// 세션 처리 과정 추가(로그인에 대한 확인 과정 추가) ---------------------------------------------------------
		HttpSession session = request.getSession();
		
		if (session.getAttribute("code") == null)	//-- 로그인이 되어있지 않은 상황
		{
			// 로그인이 되어있지 않은 상황에서의 처리
			result = "redirect:loginform.action";
			return result;
		}
		// --------------------------------------------------------- 세션 처리 과정 추가(로그인에 대한 확인 과정 추가)	
		
		result = "redirect:supportqalist.action";
		ISupport_QA_list_DAO dao = sqlSession.getMapper(ISupport_QA_list_DAO.class);
		
		dao.deleteQ(ask_code);
		
		return result;
	}
}
