package com.studyit.mybatis;

import javax.servlet.http.HttpServletRequest;

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
	
	// �������� ����Ʈ
	@RequestMapping(value="supportnoticelist.action", method=RequestMethod.GET)
	public String list(Model model)
	{
		String result = null;
		result = "/WEB-INF/views/Support_notice_list.jsp";
		
		ISupport_notice_list_DAO dao = sqlSession.getMapper(ISupport_notice_list_DAO.class);
		
		model.addAttribute("list", dao.list());
		
		return result;
	}
	
	// �������� ��������
	@RequestMapping(value="supportnoticedetail.action", method=RequestMethod.GET)
	public String detail(Model model, HttpServletRequest request)
	{
		String result = null;
		result = "/WEB-INF/views/Support_notice_detailpage.jsp";
		
		ISupport_notice_list_DAO dao = sqlSession.getMapper(ISupport_notice_list_DAO.class);
		
		String notice_code = request.getParameter("notice_code");
		
		dao.addHitCount(notice_code);
		model.addAttribute("detail", dao.detail(notice_code));
		
		return result;
	}
	
	// �������� �ۼ� ��
	@RequestMapping(value="supportnoticewrite.action")
	public String writeForm()
	{
		String result = null;
		result = "/WEB-INF/views/Support_notice_write.jsp";
		
		return result;
	}
	
	
	// �������� �ۼ�
	@RequestMapping(value="supportnoticeinsert.action", method=RequestMethod.POST)
	public String insert(Support_notice_list_DTO dto, Model model)
	{
		String result = null;
		result = "redirect:supportnoticelist.action";
		
		ISupport_notice_list_DAO dao = sqlSession.getMapper(ISupport_notice_list_DAO.class);
		dto.setAdmin_id("AD1");
		dao.insert(dto);
		
		return result;
	}
	
	// �������� ���� ��
	@RequestMapping(value="supportnoticemodifyf.action", method=RequestMethod.GET)
	public String modifyForm(HttpServletRequest request, ModelMap model)
	{
		String result = null;
		result = "/WEB-INF/views/Support_notice_modify.jsp";
		
		ISupport_notice_list_DAO dao = sqlSession.getMapper(ISupport_notice_list_DAO.class);
		model.addAttribute("dto", dao.searchCode(request.getParameter("notice_code")));
		
		return result;
	}
	
	// �������� ����
	@RequestMapping(value="supportnoticemodify.action", method=RequestMethod.POST)
	public String modify(Support_notice_list_DTO dto)
	{
		String result = null;
		result = "redirect:supportnoticedetail.action?notice_code="+dto.getNotice_code();
		
		ISupport_notice_list_DAO dao = sqlSession.getMapper(ISupport_notice_list_DAO.class);
		dao.modify(dto);
		
		
		return result;
	}
	
	// �������� ����
	@RequestMapping(value="supportnoticedelete.action", method=RequestMethod.GET)
	public String delete(HttpServletRequest request)
	{
		String result = null;
		result = "redirect:supportnoticelist.action";
		
		ISupport_notice_list_DAO dao = sqlSession.getMapper(ISupport_notice_list_DAO.class);
		dao.delete(request.getParameter("notice_code"));
		
		return result;
	}
}
