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
    <title>Member_activity.jsp</title>
    <script src="https://kit.fontawesome.com/5cdf4f755d.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/Layout.css">
    <link rel="stylesheet" href="css/Mypage_activity.css">
</head>
<body>
<div class="wrapper">
 <jsp:include page="header.jsp" flush="false"/>
 <div class="main-content text-center"><br>

			<div class="menu">
				<nav>
					<ul>
						<li><a href="updateMember.jsp">내정보수정</a></li>
						<li><a href="Mypage_activity.jsp">내 스터디 목록</a></li>
						<li><a href="deleteMember.jsp">회원 탈퇴</a></li>
					</ul>
				</nav>
			</div>

			<div class="content">
				<center>
				<div><p>내 스터디 목록</p></div>
				<div class="table">
					<table class="table table-bordered  table-condensed table-hover">
						<tr >
							<th>번호</th>
							<th>스터디이름</th>
							<th>개설자</th>
							<th>스터디 기간</th>
							<th>스터디 상태</th>
						</tr>
						<tr>
							<td>1</td>
							<td>고급 자바</td>
							<td>홍길동</td>
							<td>2020.01.01~2020.01.31</td>
							<td>스터디 진행중</td>
						</tr>
						<tr>
							<td>2</td>
							<td>초급 자바</td>
							<td>김흥부</td>
							<td>2019.01.01~2019.01.31</td>
							<td>스터디 종료</td>
						</tr>
					</table>
				</div>
				<br>
				<div class="number"> 1 2 3 4 5 6 7 8 9 10 </div>
				</center>
			</div>
		</div>
 <jsp:include page="footer.jsp" flush="false"/>
 </div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
</body>
</html>