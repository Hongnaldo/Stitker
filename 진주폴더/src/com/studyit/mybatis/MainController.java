package com.studyit.mybatis;

import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MainController
{
	@Autowired
	private SqlSession sqlSession;
	
	// 메인 페이지 
	@RequestMapping(value = "/studyit.action", method = RequestMethod.GET)
	public String mainPage(Model model) 
	{
		IMainDAO dao = sqlSession.getMapper(IMainDAO.class);
		
		String result = null;
		
		int stdCntInt = dao.stdCount();
		String stdCnt = NumberFormat.getInstance().format(stdCntInt);
		model.addAttribute("stdCnt", stdCnt);
		
		int memCnt = dao.memCount();
		model.addAttribute("memCnt", memCnt);
		
		double avgStdAssess = dao.avgAssess();
		model.addAttribute("avgStdAssess", avgStdAssess);
		
		ArrayList<MainInformDTO> informTop5 = dao.boardInformTop5();
		model.addAttribute("informTop5", informTop5);
		
		ArrayList<MainStdReviewDTO> stdReviewTop3 = dao.boardStdReviewTop3();
		model.addAttribute("stdReviewTop3", stdReviewTop3);
		
		
		
		
		SimpleDateFormat format = new SimpleDateFormat ( "yyyy년 MM월 dd일");
		Calendar time = Calendar.getInstance();
		String today = format.format(time.getTime());
		model.addAttribute("today", today);
		
		
		
		result = "/WEB-INF/views/Main.jsp";;
		
		return result;
	}
	
	
	
}
