package com.studyit.mvc;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class StudyController
{
	 @Autowired
	  private SqlSession sqlSession;
	 
	 @RequestMapping(value = "/studylist.action", method = RequestMethod.GET)
	  public String studentList(ModelMap model)
	  {
		 IMystudyDAO dao = sqlSession.getMapper(IMystudyDAO.class);
	      
	     model.addAttribute("list", dao.endlist());
	     model.addAttribute("count", dao.count());
	     
	      return "WEB-INF/views/Mypage_study.jsp";
	   }
}
