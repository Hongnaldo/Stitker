/*========================
 InformListController.java
=======================*/
package com.studyit.mybatis;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class InformListController
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
   
   @RequestMapping(value = "/informlist.action", method = RequestMethod.GET)
   public String informList(Model model)
   {
      String result = null;
      
      IInformDAO inform = sqlSession.getMapper(IInformDAO.class);
	  IInterestDAO interest = sqlSession.getMapper(IInterestDAO.class); 
      
      model.addAttribute("count", inform.count());
      model.addAttribute("list" , inform.list());
      model.addAttribute("imList", interest.imList());
      
      result = "/WEB-INF/views/Inform_list.jsp";
      
      return result;
   }
   
   @RequestMapping(value = "/informinsertform.action", method = RequestMethod.GET)
   public String informInsertForm(Model model)
   {
      String result = null;
      
	  IInterestDAO interest = sqlSession.getMapper(IInterestDAO.class); 
      IInformDAO inform = sqlSession.getMapper(IInformDAO.class);
      
      model.addAttribute("imList", interest.imList());
      
      result = "/WEB-INF/views/Inform_write.jsp";
      return result;
   }
   
   @RequestMapping(value ="/informinsert.action", method = RequestMethod.POST)
   public String informInsert(HttpServletRequest request)
   {
      IInformDAO dao = sqlSession.getMapper(IInformDAO.class);
      
      String title = request.getParameter("title");
	  String content = request.getParameter("content");
	  String interest_mc = request.getParameter("interest_mc");
      
	  HttpSession session = request.getSession();
	  InformDTO inform = (InformDTO)session.getAttribute("inform");
	  String id = (String)session.getAttribute("id");
	  String pw = (String)session.getAttribute("pw");
	  
	  String user_code = inform.getUser_code();
	  String user_name = inform.getUser_name();
	  String interest_mc_code = inform.getInterest_mc_code();
	  
 
	  dao.add(inform);
      
      return "redirect:informlist.action";
   }
   
   
   @RequestMapping(value = "/informdetail.action", method = RequestMethod.GET)
   public String informDetail(HttpServletRequest request, Model model)
   {
      String result = null;
      
      String post_code = request.getParameter("post_code");
      
      IInformDAO inform = sqlSession.getMapper(IInformDAO.class);
	  IInterestDAO interest = sqlSession.getMapper(IInterestDAO.class); 
      ICmtInformDAO comment = sqlSession.getMapper(ICmtInformDAO.class);
      
      InformDTO dto = new InformDTO();
      
	  inform.hitcounts(post_code);
      
      model.addAttribute("count", inform.count());
      model.addAttribute("detail" , inform.detail(post_code));
      model.addAttribute("imList", interest.imList());
      model.addAttribute("cmtList", comment.cmtList(post_code));
      model.addAttribute("cmtCount", comment.cmtCount(post_code));
      
      result = "/WEB-INF/views/Inform_detail.jsp?post_code=" + post_code;
      
      return result;
   }
   

   
   
   

   
}