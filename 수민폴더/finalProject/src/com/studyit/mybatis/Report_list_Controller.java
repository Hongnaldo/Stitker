package com.studyit.mybatis;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class Report_list_Controller
{
	@Autowired
	private SqlSession sqlSession;
	
	// 신고처리할 스터디원 리스트 조회
	@RequestMapping (value="participantreportlist.action", method=RequestMethod.GET)
	public String memList(Model model, HttpServletRequest request)
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
		
		result = "/WEB-INF/views/Participant_report_list.jsp";
		IParticipant_report_list_DAO dao = sqlSession.getMapper(IParticipant_report_list_DAO.class);
		
		model.addAttribute("list", dao.list());
		model.addAttribute("count", dao.count());
		
		return result;
	}
	
	// 신고처리할 게시물 리스트 조회
	@RequestMapping(value="/reportdetail.action", method=RequestMethod.GET)
	public String boardList(Model model, HttpServletRequest request)
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
		
		result = "/WEB-INF/views/Report_detailpage.jsp";
		IReport_detail_DAO dao = sqlSession.getMapper(IReport_detail_DAO.class);
		
		model.addAttribute("list", dao.list(request.getParameter("report_code")));
		
		return result;
	}
	
	// 등록된 스터디원 신고 리스트 출력
	@RequestMapping(value="/memreportdetail.action", method=RequestMethod.GET)
	public String memReportList(Model model, HttpServletRequest request)
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
		
		result = "/WEB-INF/views/Report_detailpage.jsp";
		IReport_detail_DAO dao = sqlSession.getMapper(IReport_detail_DAO.class);
		
		model.addAttribute("memList", dao.memList(request.getParameter("reported_parti_code")));
		model.addAttribute("reported_parti_code", request.getParameter("reported_parti_code"));
		model.addAttribute("reported_user_code", request.getParameter("reported_user_code"));
		
		
		return result;
	}
	
	// 등록된 게시판 신고 리스트 출력
	@RequestMapping(value="boardreportlist.action", method=RequestMethod.GET)
	public String boardReportlist(Model model, HttpServletRequest request)
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
		
		result = "/WEB-INF/views/Board_report_list.jsp";
		IBoard_report_list_DAO dao = sqlSession.getMapper(IBoard_report_list_DAO.class);
		
		model.addAttribute("list", dao.list());
		model.addAttribute("count", dao.count());
		
		return result;
	}
}
