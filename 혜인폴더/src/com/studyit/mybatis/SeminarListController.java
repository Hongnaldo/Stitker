/*========================
 StudentController.java
=======================*/
package com.studyit.mybatis;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class SeminarListController
{
   // SqlSession 을 활용하여 마이바티스 객체 의존성(자동) 주입 
   @Autowired
   private SqlSession sqlSession;
   
   // 매개변수를 등록하는 과정에서 매개변수 목록에 적혀있는
   // 클래스의 객체 정보는 스프링이 제공한다. 
   
   // 사용자의 요청 주소와 메소드를 매핑하는 과정 필요.
   // RequestMapping(value = "/요청주소", method = 전송방식)
   // 이 때, 전송 방식은 submit 액션인 경우만 POST
   // 나머지 모든 전송 방식은 GET 으로 처리한다. 
   
   @RequestMapping(value = "/seminarlist.action", method = RequestMethod.GET)
   public String seminarList(Model model)
   {
      String result = null;
      
      ISeminarDAO seminar = sqlSession.getMapper(ISeminarDAO.class);
      ISeminarCtgDAO seminarctg = sqlSession.getMapper(ISeminarCtgDAO.class);
      
      model.addAttribute("count", seminar.count());
      model.addAttribute("list" , seminar.list());
      model.addAttribute("scList", seminarctg.scList());
      
      result = "/WEB-INF/views/Seminar_list.jsp";
      
      return result;
   }
   
   @RequestMapping(value = "/seminarinsertform.action", method = RequestMethod.GET)
   public String seminarInsertForm(Model model)
   {
      String result = null;
      
      ISeminarCtgDAO seminarctg = sqlSession.getMapper(ISeminarCtgDAO.class);
      
      model.addAttribute("scList", seminarctg.scList());
      
      result = "/WEB-INF/views/Seminar_write.jsp";
      return result;
   }
   
   @RequestMapping(value ="/seminarinsert.action", method = RequestMethod.POST)
   public String seminarInsert(SeminarDTO seminar)
   {
      ISeminarDAO dao = sqlSession.getMapper(ISeminarDAO.class);
      
      dao.add(seminar);
      
      return "redirect:seminarlist.action";
   }
   
   
   @RequestMapping(value = "/seminardetail.action", method = RequestMethod.GET)
   public String seminarDetail(HttpServletRequest request, Model model)
   {
      String result = null;
      
      String post_num = request.getParameter("post_num");
      
      ISeminarDAO seminar = sqlSession.getMapper(ISeminarDAO.class);
      ISeminarCtgDAO seminarctg = sqlSession.getMapper(ISeminarCtgDAO.class);
      
      InformDTO dto = new InformDTO();
      
      model.addAttribute("count", seminar.count());
		/* model.addAttribute("hitcounts", seminar.hitcounts(post_num)); */
      model.addAttribute("detail" , seminar.detail(post_num));
      model.addAttribute("scList", seminarctg.scList());
      
      result = "/WEB-INF/views/Seminar_detail.jsp?post_num=" + post_num;
      
      return result;
   }
   

   
   
   

   
}