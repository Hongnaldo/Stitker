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
<title></title>
<!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.css">
    <link href="css/bootstrap.min.css">
    <title>Mypage_evaluationComplete</title>
    <link rel="stylesheet" href="css/cal.css">
    
</head>
<body>
<div class="wrapper">
 <jsp:include page="header.jsp" flush="false"/>
 <div class="main-content text-center"><br>
   
   <div class="bg-dark text-white">
   		<h2 class="p-3 ms-4">출석부</h2>
   </div><br>  
   
  <div>
      <span class="fs-3 fw-bold">스터디명 : 자바스크립트 스터디</span><br>
     <span class="fs-6 fw-bold">기간 : 2020-10-11~ 2020-12-23</span><br>
  </div>
  <!-- 달력 -->

	



  	<div class="position-absolute mt-5 me-5 start-50 translate-middle">
	    <button type="button" class="btn btn-primary btn-lg me-5">외출</button>
	    <button type="button" class="btn btn-primary btn-lg">출석</button>
	</div>
</div><!-- main-content -->


 <jsp:include page="footer.jsp" flush="false"/>
 </div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
</body>
</html>