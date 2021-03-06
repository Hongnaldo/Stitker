<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Support_Q&A_list_admin.jsp</title>

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
	<div class="main-content"><br>
		<div class="menu">
		<br> 
			<h1 class="text-center">고객센터</h1>
			<br><br><br>
			<nav>
				<ul>
					<li><a href="Support_notice_list.jsp">공지사항</a></li>
					<li><a href="Support_Q&A_list.jsp"  class="selected">1:1문의</a></li>
				</ul>
			</nav>
		</div>

		<div class="content">		
			<br><br>
			<div class="tableDiv">
				<table class="table table-hover">
					<thead>
					<tr class="first">
						<th>번호</th>
						<th class="title">제목</th>
						<th>작성일</th>
						<th>답변</th>
					</tr>
					</thead>
					<tr>
						<td>예시)1</td>
						<td>예시)스터디관련질문입니다.</td>
						<td>예시)2020/12/26</td>
						<td>예시)답변완료</td>
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
	</div>
	<jsp:include page="footer.jsp" flush="false"/>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
		
</body>
</html>