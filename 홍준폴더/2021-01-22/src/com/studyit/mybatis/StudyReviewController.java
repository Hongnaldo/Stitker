/*==========================
	MemberMain.java
	- 컨트롤러
==========================*/

package com.studyit.mybatis;

import java.sql.SQLException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class StudyReviewController
{
	// mybatis 객체 의존성 (자동) 주입~!!!
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value="/studyreviewlist.action", method = RequestMethod.GET)
	public String memberList(ModelMap model) throws SQLException
	{
		IStudyReview dao = sqlSession.getMapper(IStudyReview.class);
		System.out.println("ss");
		model.addAttribute("interestlist", dao.interestlist());
		model.addAttribute("list",dao.list());
		
		return "WEB-INF/views/StudyReview_list.jsp";
		
	}
	
	/*
	 * @RequestMapping(value="/memberinsert.action", method=RequestMethod.POST)
	 * public String memberAdd(MemberDTO dto) { IMemberDAO dao
	 * =sqlSession.getMapper(IMemberDAO.class);
	 * 
	 * dao.add(dto);
	 * 
	 * return "redirect:memberlist.action";
	 * 
	 * }
	 * 
	 * @RequestMapping(value="/memberdelete.action", method=RequestMethod.GET)
	 * public String memberRemove(MemberDTO dto) { IMemberDAO dao =
	 * sqlSession.getMapper(IMemberDAO.class);
	 * 
	 * dao.remove(dto);
	 * 
	 * return "redirect:memberlist.action"; }
	 */
	 
	
}
