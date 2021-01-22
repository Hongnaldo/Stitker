package com.studyit.mybatis;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MainController
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "/studyit.action", method = RequestMethod.GET)
	public String mainPage() 
	{
		String result = null;
		
		result = "/WEB-INF/views/Main.jsp";;
		
		return result;
	}
}
