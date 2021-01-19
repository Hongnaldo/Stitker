/*=================================
	LoginFindController.java
	- 아이디 찾기 폼 컨트롤러
	- 아이디 찾기 액션 컨트롤러
	- 비밀번호 찾기 폼 컨트롤러
	- 비밀번호 찾기 액션 컨트롤러
==================================*/

package com.studyit.mybatis;



import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class LoginFindController
{
	@Autowired
	private SqlSession sqlSession;
	
	// 아이디 찾기 폼
	@RequestMapping(value = "/findidform.action", method = RequestMethod.GET)
	public String findIdForm()
	{
		return "/WEB-INF/views/Find_id.jsp";
	}
	
	// 아이디 찾기 액션
	@RequestMapping(value = "/findid.action", method = RequestMethod.POST)
	public String findId(Model model, HttpServletRequest request)
	{
		IFindIdDAO dao = sqlSession.getMapper(IFindIdDAO.class);
		
		String email = request.getParameter("email");
		
		model.addAttribute("email", email);
		model.addAttribute("id", dao.findId(email));
		
		return "/WEB-INF/views/Find_id_result.jsp";
	}
	
	// 비밀번호 찾기 폼
	@RequestMapping(value = "/findpwform.action", method = RequestMethod.GET)
	public String findPwForm()
	{
		return "/WEB-INF/views/Find_pw.jsp";
	}
	
	// 비밀번호 찾기 액션
	@RequestMapping(value = "/findbyemail.action", method = RequestMethod.POST)
	public String findPw(Model model, HttpServletRequest request)
	{
		IFindPwDAO dao = sqlSession.getMapper(IFindPwDAO.class);
		
		String email = request.getParameter("email");
		String rndStr = dao.rndPw();
		
		dao.updatePwByEmail(rndStr, email);
		
		model.addAttribute("email", email);
		model.addAttribute("rndStr", rndStr);
		
		return "/WEB-INF/views/Find_pw_result.jsp";
	}
	
	
}
