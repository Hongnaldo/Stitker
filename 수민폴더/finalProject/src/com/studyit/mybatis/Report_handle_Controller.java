package com.studyit.mybatis;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class Report_handle_Controller
{
	@Autowired
	private SqlSession sqlSession;
	
	// 스터디원 경고 등록
	@RequestMapping(value="/insertwarning.action", method=RequestMethod.GET)
	public String insertWarning(HttpServletRequest request, ModelMap model)
	{
		String result = null;
		
		// HashMap 선언 및 파라미터 저장
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("reported_user_code", request.getParameter("reported_user_code"));
		
		// 경고 등록 프로시저 호출
		sqlSession.selectOne("com.studyit.mybatis.IParticipant_report_list_DAO.insertWarning", param);
		
		// 신고처리 결과 등록
		IParticipant_report_list_DAO dao = sqlSession.getMapper(IParticipant_report_list_DAO.class);
		dao.updateRhParti(request.getParameter("reported_parti_code"));
		
		// 원래 있었던 페이지 호출
		model.addAttribute("result", "WarningSuccess");
		model.addAttribute("reported_parti_code", request.getParameter("reported_parti_code"));
		result = "redirect:memreportdetail.action";
		return result;
	}
	
	// 신고수 초기화
	@RequestMapping(value="/updateReg.action", method=RequestMethod.GET)
	public String updateReg(HttpServletRequest request, ModelMap model)
	{
		String result = null;
		
		IParticipant_report_list_DAO dao = sqlSession.getMapper(IParticipant_report_list_DAO.class);
		
		// 신고처리 데이터 삭제
		dao.deleteRhParti(request.getParameter("reported_parti_code"));
		
		// 신고등록 데이터 삭제
		dao.deleteRegParti(request.getParameter("reported_parti_code"));
		
		// 원래 있었던 페이지 호출
		model.addAttribute("result", "UpdateSuccess");
		model.addAttribute("reported_parti_code", request.getParameter("reported_parti_code"));
		result = "redirect:memreportdetail.action";
		
		return result;
	}
	
	// 신고수 초기화 + 경고등록(허위신고)
	@RequestMapping(value="/updateAndInsertWarning.action", method=RequestMethod.GET)
	public String updateRegAndInsertWarning(HttpServletRequest request, ModelMap model)
	{
		String result = null;

		IParticipant_report_list_DAO dao = sqlSession.getMapper(IParticipant_report_list_DAO.class);
		
		// 신고처리 데이터 삭제
		dao.deleteRhParti(request.getParameter("reported_parti_code"));
		// 신고등록 데이터 삭제
		dao.deleteRegParti(request.getParameter("reported_parti_code"));
		
		String[] report_user_code = request.getParameterValues("report_user_code");
		HashMap<String, String> param;
		
		// 경고등록(허위신고)
		for (int i = 0; i < report_user_code.length; i++)
		{
			param = new HashMap<String, String>();
			param.put("reported_user_code", report_user_code[i]);
			System.out.println(report_user_code[i]);
			sqlSession.selectOne("com.studyit.mybatis.IParticipant_report_list_DAO.insertWarning", param);
		}
		
		// 원래 있었던 페이지 호출
		model.addAttribute("result", "UpdateAndWarningSuccess");
		model.addAttribute("reported_parti_code", request.getParameter("reported_parti_code"));
		result = "redirect:memreportdetail.action";
		
		return result;
	}
}
