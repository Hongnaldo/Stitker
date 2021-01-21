/*==================================================
	SuspendFormController.java
==================================================*/

package com.test.mvc;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

//※ Spring 이 제공하는 『Controller』 인터페이스를 구현함으로써
//사용자 정의 컨트롤러 클래스를 구성한다.

public class SuspendFormController implements Controller
{
	
	// 인터페이스 자료형을 기반으로 속성 구성
	private ISuspendDAO suspendDAO;
	//private IEmployeeDAO employeeDAO;
	
	
	// setter 구성
	
	
	public void setSuspendDAO(ISuspendDAO suspendDAO)
	{
		this.suspendDAO = suspendDAO;
	}

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		// 세션 처리 과정 추가(로그인에 대한 확인 과정 추가) ---------------------------------
		HttpSession session = request.getSession();
				
		if(session.getAttribute("name") == null) //-- 로그인이 되어있지 않은 상황 
		{
			// 로그인이 되어있지 않은 상황에서의 처리
			mav.setViewName("redirect:loginform.action");
			return mav;
		}
		else if(session.getAttribute("admin")== null)
		{
			mav.setViewName("redirect:logout.action");
			return mav;
		}
		
		try
		{	
			// 데이터 수신(... 로 부터... suspend_code 수신)
			String suspend_code = request.getParameter("suspend_code");
			
			Suspend suspend = new Suspend();
			
			suspend = suspendDAO.searchId(suspend_code);
			
			
			
			mav.addObject("suspend", suspend);
			
			mav.setViewName("Member_informationStop");
			
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;	
	}
	
}