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

<link rel="stylesheet" href="css/Report_list.css">
</head>
<body>
<div class="menu">
	<h1>신고확인</h1>
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
	<div class="table">
			<table>
			<tr class="first">
				<th>번호</th>
				<th class="title">제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
			<tr>
				<td>예시</td>
				<td>예시</td>
				<td>예시</td>
				<td>예시</td>
			</tr>
			<tr>
				<td>예시</td>
				<td>예시</td>
				
				<td>예시</td>
				<td>예시</td>
			</tr>
		</table>
	</div>
	<br>
	<div class="page">페이징처리필요 1 2 3 4 5 6 7 8 9 10 > >></div>
</div>	
</body>
</html>