/*========================
 InformListController.java
=======================*/
package com.studyit.mybatis;

import java.util.ArrayList;

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
   public String informInsertForm(HttpServletRequest request, Model model)
   {
      String result = null;
      
	  IInterestDAO interest = sqlSession.getMapper(IInterestDAO.class); 
      IInformDAO inform = sqlSession.getMapper(IInformDAO.class);
      
      model.addAttribute("imList", interest.imList());
      
      // 글쓰기 버튼을 누르면 로그인 여부 판단 후 글 작성 페이지/로그인 페이지
      HttpSession session = request.getSession();
      if (session.getAttribute("code")!=null) // 로그인 사용자
      {
         if (session.getAttribute("admin")==null) // 어드민이 아닌 >> 일반 회원
         {
            String user_code = (String) session.getAttribute("code"); //세션에서 유저코드 얻어오기
                  
            //테스트
           // System.out.println(user_code); //--> UC1
            result = "/WEB-INF/views/Inform_write.jsp";
         }
      }
      else
      {
    	  result = "redirect:loginform.action";
      }

      return result;
   }
   
   @RequestMapping(value ="/informinsert.action", method = RequestMethod.GET)
   public String informInsert(HttpServletRequest request, InformDTO inform)
   {
      IInformDAO dao = sqlSession.getMapper(IInformDAO.class);
      
      String title = request.getParameter("title");
	  String content = request.getParameter("content");
	  String interest_mc = request.getParameter("interest_mc");

	  HttpSession session = request.getSession();
	  String user_code = (String)session.getAttribute("code");
	  
	  inform.setUser_code(user_code); 
	  inform.setTitle(title);
	  inform.setContent(content); 
	  inform.setInterest_mc_code(interest_mc);
	  
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
   
   
   @RequestMapping(value ="/infocmtinsert.action", method = RequestMethod.GET)
   public String informCommentInsert(HttpServletRequest request, CmtInformDTO dto)
   {
      ICmtInformDAO dao = sqlSession.getMapper(ICmtInformDAO.class);
      String result = null;
      
      // 댓글 등록 버튼을 누르면 로그인 여부 판단 후 글 작성 페이지/로그인 페이지
      HttpSession session = request.getSession();
      
      String post_code = request.getParameter("post_code");
      
      if (session.getAttribute("code")!=null) // 로그인 사용자
      {
         if (session.getAttribute("admin")==null) // 어드민이 아닌 >> 일반 회원
         {
            String user_code = (String)session.getAttribute("code"); //세션에서 유저코드 얻어오기
                  
            result = "redirect:informdetail.action?post_code=" + post_code;
         }
      }
      else
      {
    	  result = "redirect:loginform.action";
      }

      
	  String user_code = (String)session.getAttribute("code");
	  String commentBox = request.getParameter("commentBox");  

	  dto.setUser_code(user_code); 
		 
	  System.out.println(user_code);
	  System.out.println(commentBox);

	  dao.cmtAdd(dto); 
      
      return "redirect:informdetail.action?post_code=" + post_code;
   }

   
   
   

   
}