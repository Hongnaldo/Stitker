/*=================================
 *  SampleController.java
 *  - 사용자 정의 컨트롤러 클래스
 * ==============================*/

// ※ Spring 이 제공하는 『Controller』 인터페이스를 구현함으로써
//    사용자 정의 컨트롤러 클래스를 구성한다. 

package com.studyit.mvc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class SampleController implements Controller
{
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		//CharacterEncodingFilter
		
		return mav;
	}

}
