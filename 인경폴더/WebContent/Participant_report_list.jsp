<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Participant_report_list.jsp</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.css">
<link href="css/bootstrap.min.css">
<script src="https://kit.fontawesome.com/5cdf4f755d.js" crossorigin="anonymous"></script>

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
					<li><a href="Participant_report_list.jsp" class="selected">스터디원</a></li>
					<li><a href="Board_report_list.jsp">게시물</a></li>			
				</ul>
			</nav>
		</div>
	
		<div class="content">
			<div class="tableDiv">
				<table class="table table-hover">
					<thead>
					<tr class="first">
						<th>번호</th>
						<th class="title">스터디이름</th>
						<th>대상자</th>
						<th>개설일</th>
					</tr>
					</thead>
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
			<br><br>
		</div>
	</div>
	<jsp:include page="footer.jsp" flush="false"/>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
</body>
</html>