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
<title>Board_report_list.jsp</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<script src="https://kit.fontawesome.com/5cdf4f755d.js" crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>

<!-- 직접 설정한 CSS -->
<link rel="stylesheet" href="css/sumin/Layout.css">
<link rel="stylesheet" href="css/sumin/ListPage.css">

</head>
<body>


<div class="wrapper">
	<jsp:include page="header.jsp" flush="false"/>
	<div class="main-content">
		<div class="menu">
		<br> 
			<h1 class="text-center">신고확인</h1>
			<br><br><br>
			<nav>
				<ul>
					<li><a href="Study_report_list.jsp">스터디</a></li>
					<li><a href="Participant_report_list.jsp">스터디원</a></li>
					<li><a href="Board_report_list.jsp" class="selected">게시물</a></li>			
				</ul>
			</nav>
		</div>
		
		<div class="content">		
			<div class="tableDiv">
				<table class="table table-hover">
					<thead>
					<tr class="first">
						<th>번호</th>
						<th>게시판</th>
						<th class="title">제목</th>
						<th>작성자</th>
						<th>처리결과</th>
					</tr>
					</thead>
					<c:forEach var="report" items="${list }">
						<tr>
							<td>${report.rownum }</td>
							<td>${report.post_code }</td>
							<td>${report.title }</td>
							<td>${report.id }</td>
							<td>${report.handle_result }</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<br>
			<div class="page">페이징처리필요 1 2 3 4 5 6 7 8 9 10 > >></div>
		</div>	
	</div>
	<jsp:include page="footer.jsp" flush="false"/>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
		
</body>
</html>