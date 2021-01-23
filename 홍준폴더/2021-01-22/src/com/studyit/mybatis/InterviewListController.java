/*==========================
	MemberMain.java
	- 컨트롤러
==========================*/

package com.studyit.mybatis;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class InterviewListController
{
	// mybatis 객체 의존성 (자동) 주입~!!!
	@Autowired
	private SqlSession sqlSession;

	@RequestMapping(value = "/interviewlist.action", method = RequestMethod.GET)
	public String memberList(ModelMap model) throws SQLException
	{
		IInterview dao = sqlSession.getMapper(IInterview.class);
		model.addAttribute("interestlist", dao.interestlist());
		model.addAttribute("list", dao.list());

		return "WEB-INF/views/Interview_list.jsp";

	}

	@RequestMapping(value = "/interview_writeform.action", method = RequestMethod.GET)
	public String interviewAddform(ModelMap model) throws SQLException
	{
		
		IInterview dao = sqlSession.getMapper(IInterview.class);
		model.addAttribute("interestlist",dao.interestlist());

		return "WEB-INF/views/Interview_write.jsp";

	}

	@RequestMapping(value = "/interview_write.action", method = RequestMethod.POST)
	public String interviewAdd(InterviewDTO dto, HttpServletRequest request) throws SQLException
	{
		String page="redirect:interviewlist.action";
		
		IInterview dao = sqlSession.getMapper(IInterview.class);
		
		HttpSession session = request.getSession();
		if(session.getAttribute("code") == null) 
		{
			page = "redirect:loginform.action";
			return page;
		}
		
		String user_code = (String)session.getAttribute("code");
		dto.setUser_code(user_code);
		dto.setInterest_mc_code(request.getParameter("interest_mc_code"));
		dto.setTitle(request.getParameter("title"));
		dto.setContent(request.getParameter("content"));
		
		dao.add(dto);
		return page;
	}
	@RequestMapping(value = "/interview_detail.action", method = RequestMethod.GET)
	public String interviewdetail(ModelMap model, HttpServletRequest request, InterviewDTO dto) throws SQLException
	{
		String check = "different";
		IInterview dao = sqlSession.getMapper(IInterview.class);
		
		HttpSession session = request.getSession();
		if(session.getAttribute("code") == null) 
		{
			return "redirect:loginform.action";
		}
		String user_code = request.getParameter("user_code");
		session.setAttribute("write_user_code", user_code);
		if(user_code.equals((String)session.getAttribute("code")))
			check="same";
		
		model.addAttribute("recCheck",dao.recCheck(request.getParameter("post_code"), (String)session.getAttribute("code")));
		dao.hitcount(request.getParameter("post_code"));
		model.addAttribute("check",check);
		model.addAttribute("Commentlist", dao.commentlist(request.getParameter("post_code")));
		model.addAttribute("list",dao.searchlist(request.getParameter("post_code")));
			
		return "WEB-INF/views/Interview_detail.jsp";

	}
	@RequestMapping(value = "/interview_modifyform.action", method = RequestMethod.GET)
	public String interviewModify(ModelMap model,InterviewDTO dto, HttpServletRequest request) throws SQLException
	{
		String page="WEB-INF/views/Interview_modify.jsp";
		
		IInterview dao = sqlSession.getMapper(IInterview.class);
		
		HttpSession session = request.getSession();
		String userpw = (String)session.getAttribute("userpw");
		
		if(session.getAttribute("code") == null) 
		{
			page = "redirect:loginform.action";
			return page;
		}
		
		model.addAttribute("userpw",userpw);
		model.addAttribute("interest",dao.interestlist());
		String post_code = request.getParameter("post_code");
		model.addAttribute("list",dao.searchlist(post_code));
		
		return page;
	}
	@RequestMapping(value = "/modify_cancel.action", method = RequestMethod.GET)
	public String modifyCancel(ModelMap model) throws SQLException
	{
		return "redirect:interviewlist.action";
	}
	@RequestMapping(value = "/interview_delete.action", method = RequestMethod.GET)
	public String interviewDelete(ModelMap model,InterviewDTO dto, HttpServletRequest request) throws SQLException
	{
		String page="redirect:interviewlist.action";
		
		IInterview dao = sqlSession.getMapper(IInterview.class);
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("code") == null) 
		{
			page = "redirect:loginform.action";
			return page;
		}
		
		
		String post_code = request.getParameter("post_code");
		dao.remove(post_code);
		return page;
	}
	
	@RequestMapping(value = "/commentinsert.action", method = RequestMethod.POST)
	public String commentsAdd(InterviewDTO dto, HttpServletRequest request, ModelMap model) throws SQLException
	{
		
		
		IInterview dao = sqlSession.getMapper(IInterview.class);
		
		HttpSession session = request.getSession();
		if(session.getAttribute("code") == null) 
		{
			String page = "redirect:loginform.action";
			return page;
		}
		
		
		String user_code = (String)session.getAttribute("code");
		String write_user_code = (String)session.getAttribute("write_user_code");
		String comments = request.getParameter("commentBox");
		String post_code = request.getParameter("post_code");
		
		dao.addComment(post_code, user_code, comments);
		
		
		
		return "redirect:interview_detail.action?post_code="+post_code + "&user_code=" +write_user_code;
	}
	@RequestMapping(value = "/rec.action", method = RequestMethod.GET)
	public String recAdd(InterviewDTO dto, HttpServletRequest request) throws SQLException
	{
		String page="redirect:interviewlist.action";
		
		IInterview dao = sqlSession.getMapper(IInterview.class);
		
		HttpSession session = request.getSession();
		if(session.getAttribute("code") == null) 
		{
			page = "redirect:loginform.action";
			return page;
		}
		
		String user_code = (String)session.getAttribute("code");
		String write_user_code = (String)session.getAttribute("write_user_code");
		String post_code = request.getParameter("post_code");
		
		dao.addRec(post_code, user_code);
		return "redirect:interview_detail.action?post_code="+post_code + "&user_code=" +write_user_code;
	}
	@RequestMapping(value = "/notrec.action", method = RequestMethod.GET)
	public String notrecAdd(InterviewDTO dto, HttpServletRequest request) throws SQLException
	{
		String page="redirect:interviewlist.action";
		
		IInterview dao = sqlSession.getMapper(IInterview.class);
		
		HttpSession session = request.getSession();
		if(session.getAttribute("code") == null) 
		{
			page = "redirect:loginform.action";
			return page;
		}
		
		String user_code = (String)session.getAttribute("code");
		String write_user_code = (String)session.getAttribute("write_user_code");
		String post_code = request.getParameter("post_code");
		
		dao.addNotRec(post_code, user_code);
		return "redirect:interview_detail.action?post_code="+post_code + "&user_code=" +write_user_code;
	}
	

}
