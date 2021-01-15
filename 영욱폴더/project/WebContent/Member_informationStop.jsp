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
    <title>Member_informationStop</title>
    <script src="https://kit.fontawesome.com/5cdf4f755d.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="wrapper">
 <jsp:include page="header.jsp" flush="false"/>
 <div class="main-content text-center"><br>

			<div style="height:200px; align:center;">
				<center>
					<mark style="font-size: large;">안내사항</mark>
					<Br><Br>
					<table style="text-align: center; width:600px;" class="table table-bordered">
						<tr>
							<td colspan="2" style="color: red;">회원님의 아이디는 현재 계정
								정지 상태입니다.</td>
						</tr>
						<tr>
							<td>계정 정지 기간 :</td>
							<td>2020-01-01 ~ 2020-12-31</td>
						</tr>
						<tr>
							<td colspan="2">스터디 조회 및 신청, 정보공유 게시판에 접근 가능하나 <br>스터디
								참여 또는 게시물, 댓글 작성, 게시물 신고 등 <br> 사이트 이용이 제한됩니다
							</td>
						</tr>
					</table>

				</center>
			</div>
 </div>
 <jsp:include page="footer.jsp" flush="false"/>
 </div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
</body>
</html>
