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
<title>출석부</title>
<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/style.css">
	<link rel="stylesheet" href="css/calendar.css">
	<script src="http://code.jquery.com/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="https://kit.fontawesome.com/5cdf4f755d.js"></script>
</head>
<body>
<div class="wrapper">
 <jsp:include page="header.jsp" flush="false"/>
 <div class="main-content text-center"><br>
   <div class="container"><br>
      <div class="row" style="height: 550px;">
        <div id="calendarForm" class="col-12" style="height: 500px;"></div>
        <div class="col-12">
            <button type="button" class="btn btn-outline-primary btn-lg me-5">출석</button>
            <button type="button" class="btn btn-outline-primary btn-lg">외출</button>
        </div>
      </div>
    </div>
  </div><!--main-content end-->
  <br><script src="js/calendar.js"></script>   
 <jsp:include page="footer.jsp" flush="false"/>
 </div>
</body>
</html>