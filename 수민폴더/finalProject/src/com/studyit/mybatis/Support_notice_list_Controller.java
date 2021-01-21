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
public class Support_notice_list_Controller
{
	@Autowired
	private SqlSession sqlSession;
	
	// 공지사항 리스트
	@RequestMapping(value="supportnoticelist.action", method=RequestMethod.GET)
	public String list(ModelMap model, HttpServletRequest request)
	{
		String result = null;
		HttpSession session = request.getSession();
		
		result = "/WEB-INF/views/Support_notice_list.jsp";
		ISupport_notice_list_DAO dao = sqlSession.getMapper(ISupport_notice_list_DAO.class);
		
		model.addAttribute("list", dao.list());
		model.addAttribute("admin", (String)session.getAttribute("admin"));
		
		return result;
	}
	
	// 공지사항 상세페이지
	@RequestMapping(value="supportnoticedetail.action", method=RequestMethod.GET)
	public String detail(Model model, HttpServletRequest request)
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
		
		result = "/WEB-INF/views/Support_notice_detailpage.jsp";
		ISupport_notice_list_DAO dao = sqlSession.getMapper(ISupport_notice_list_DAO.class);
		
		String notice_code = request.getParameter("notice_code");
		
		dao.addHitCount(notice_code);
		model.addAttribute("detail", dao.detail(notice_code));
		model.addAttribute("admin", (String)session.getAttribute("admin"));
		
		return result;
	}
	
	// 공지사항 작성 폼
	@RequestMapping(value="supportnoticewrite.action")
	public String writeForm(HttpServletRequest request)
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
		else if (session.getAttribute("admin") == null)		//-- 로그인은 되었지만 관리자가 아닌 상황
		{
			// 관리자가 아닌 상황 즉, 일반 사원일 때의 처리
			//-- 일반 사원으로 로그인되어있는 상황을 해제하고
			result = "redirect:logout.action";
			return result;
		}	
		// --------------------------------------------------------- 세션 처리 과정 추가(로그인에 대한 확인 과정 추가)
		
		result = "/WEB-INF/views/Support_notice_write.jsp";
		
		return result;
	}
	
	
	// 공지사항 등록
	@RequestMapping(value="supportnoticeinsert.action", method=RequestMethod.POST)
	public String insert(Support_notice_list_DTO dto, Model model, HttpServletRequest request)
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
		else if (session.getAttribute("admin") == null)		//-- 로그인은 되었지만 관리자가 아닌 상황
		{
			// 관리자가 아닌 상황 즉, 일반 사원일 때의 처리
			//-- 일반 사원으로 로그인되어있는 상황을 해제하고
			result = "redirect:logout.action";
			return result;
		}	
		// --------------------------------------------------------- 세션 처리 과정 추가(로그인에 대한 확인 과정 추가)		
		
		result = "redirect:supportnoticelist.action";
		ISupport_notice_list_DAO dao = sqlSession.getMapper(ISupport_notice_list_DAO.class);
		dto.setAdmin_id("AD1");
		dao.insert(dto);
		
		return result;
	}
	
	// 공지사항 수정 폼
	@RequestMapping(value="supportnoticemodifyf.action", method=RequestMethod.GET)
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
		else if (session.getAttribute("admin") == null)		//-- 로그인은 되었지만 관리자가 아닌 상황
		{
			// 관리자가 아닌 상황 즉, 일반 사원일 때의 처리
			//-- 일반 사원으로 로그인되어있는 상황을 해제하고
			result = "redirect:logout.action";
			return result;
		}	
		// --------------------------------------------------------- 세션 처리 과정 추가(로그인에 대한 확인 과정 추가)		
		
		result = "/WEB-INF/views/Support_notice_modify.jsp";
		ISupport_notice_list_DAO dao = sqlSession.getMapper(ISupport_notice_list_DAO.class);
		model.addAttribute("dto", dao.searchCode(request.getParameter("notice_code")));
		
		return result;
	}
	
	// 공지사항 수정
	@RequestMapping(value="supportnoticemodify.action", method=RequestMethod.POST)
	public String modify(Support_notice_list_DTO dto, HttpServletRequest request)
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
		else if (session.getAttribute("admin") == null)		//-- 로그인은 되었지만 관리자가 아닌 상황
		{
			// 관리자가 아닌 상황 즉, 일반 사원일 때의 처리
			//-- 일반 사원으로 로그인되어있는 상황을 해제하고
			result = "redirect:logout.action";
			return result;
		}	
		// --------------------------------------------------------- 세션 처리 과정 추가(로그인에 대한 확인 과정 추가)		
		
		result = "redirect:supportnoticedetail.action?notice_code="+dto.getNotice_code();
		ISupport_notice_list_DAO dao = sqlSession.getMapper(ISupport_notice_list_DAO.class);
		dao.modify(dto);
		
		
		return result;
	}
	
	// 공지사항 삭제
	@RequestMapping(value="supportnoticedelete.action", method=RequestMethod.GET)
	public String delete(HttpServletRequest request)
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
		else if (session.getAttribute("admin") == null)		//-- 로그인은 되었지만 관리자가 아닌 상황
		{
			// 관리자가 아닌 상황 즉, 일반 사원일 때의 처리
			//-- 일반 사원으로 로그인되어있는 상황을 해제하고
			result = "redirect:logout.action";
			return result;
		}	
		// --------------------------------------------------------- 세션 처리 과정 추가(로그인에 대한 확인 과정 추가)		
		
		result = "redirect:supportnoticelist.action";
		ISupport_notice_list_DAO dao = sqlSession.getMapper(ISupport_notice_list_DAO.class);
		dao.delete(request.getParameter("notice_code"));
		
		return result;
	}
}
