<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Support_notice_detailpage.jsp</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<script src="https://kit.fontawesome.com/5cdf4f755d.js" crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>

<!-- 직접 설정한 CSS -->
<link rel="stylesheet" href="css/sumin/Layout.css">
<link rel="stylesheet" href="css/sumin/DetailPage.css">
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
					<li><a href="Support_notice_list.jsp" class="selected">공지사항</a></li>
					<li><a href="Support_Q&A_list.jsp">1:1문의</a></li>
				</ul>
			</nav>
		</div>
		
		<div class="content">
			<table class="table">
				<tr>
					<th>제목</th>
					<td colspan="5">예시)스터디 개설 시 주의사항입니다. 꼭 읽어주세요</td>
				</tr>
				<tr class="title">
					<th>작성자</th>
					<td>허수민</td>
					<th>작성일</th>
					<td>20/12/13</td>
					<th>조회수</th>
					<td>12</td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="5">안녕하세요
					<br><br><br><br><br><br><br>
					</td>
				</tr>
			</table>
			<br>
			<div class="buttons">
				<button type="button" class="btn btn-outline-primary">수정하기</button>
				<button type="button" class="btn btn-outline-primary">삭제하기</button>
				<button type="button" class="btn btn-outline-primary" onclick="window.location.href='Support_notice_list.jsp'">목록으로</button>
			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp" flush="false"/>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
</body>
</html>