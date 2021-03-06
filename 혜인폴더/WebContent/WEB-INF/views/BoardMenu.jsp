<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BoardMenu.jsp</title>

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/menu.css">
<!-- <script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script> -->
<script type="text/javascript" src="<%=cp %>/js/util.js"></script>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.css">
<link href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/style.css">
<script src="https://kit.fontawesome.com/5cdf4f755d.js" crossorigin="anonymous"></script>
<script type="text/javascript">

	$("#menu>li>a").click(function(e){
		e.stopPropagation();  
		
	
		   $("#menu>li>a").off("click").on("click", function() 
		   {

	
		/* if( !$(this).hasClass("on") )
		{
			$("#menu>li>a").removeClass("on");
		}
		else
		{
			$(this).addClass("on");
		} */
		
				if ($(this).hasClass("on")) 
				{ 
					$("#menu>li>a").removeClass("on");
				}
				else 
				{
					$("#menu>li>a").addClass("on");
				}

		   	});


	});
	
	



</script>

</head>
<body>
 
	<div class="menu">
	<br> 
		<h1 class="text-center">정보공유</h1>
		<br><br><br>
		<nav>
			<ul id="menu">
				<li><a class="on" href="informlist.action">IT기술정보공유</a></li>
				<li><a href="seminarlist.action">세미나 및 공모전</a></li>
				<li><a href="interviewlist.action">면접/코딩테스트 후기</a></li>
				<li><a href="freelist.action">자유게시판</a></li>
				<li><a href="questionlist.action">Q&A</a></li>
				<li><a href="studyreviewlist.action">스터디 후기</a></li>
			</ul>
		</nav>
	</div>

	
  

 
</body>
</html>