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
<title>LoginForm.jsp</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/style.css">
<script src="http://code.jquery.com/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/5cdf4f755d.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<!-- 로그인 관련 페이지 공통 css-->
<link rel="stylesheet" href="<%=cp%>/css/login.css" />
<style type="text/css">
.login_input>p {
	color: red;
	font-size: 9pt;
	display: none;
}
.divBot a {
	cursor: pointer;
	color: #000000;
	text-decoration: none;
	font-size: 9pt;
	line-height: 150%;
}
.form-control {
	margin-bottom: 15px;
}
</style>
</head>
<body>
	<div class="wrapper">
		<jsp:include page="header.jsp" flush="false" />
		<div class="main-content">
			<br>
			<div class="login">
				<div class="divTop">
					<h5>로그인</h5>
				</div>
				<br>
				
				
				<form action="login.action" method="post">
					<div class="login_input">
						<!-- 로그인 ID 입력 -->
						<input type="text" class="form-control" id="id" name="id"
							placeholder="아이디 입력" required="required" />

						<!-- 로그인 Password 입력 -->
						<input type="password" class="form-control" id="pw" name="pw"
							placeholder="비밀번호 입력" required="required" />
						<p>입력한 아이디와 비밀번호가 일치하지 않습니다. 아이디 또는 비밀번호를 다시 한번 입력해 주세요.</p>

						<div class="custom-control custom-checkbox">
						<input type="checkbox" id="loginck" class="custom-control-input">
						<label class="custom-control-label" for="loginck">로그인 상태 유지</label>
						</div>		

						<!-- 로그인 버튼 -->
						<button type="submit" class="btn btn-outline-primary form-control"
							style="margin-top: 15px;">로그인</button>
					</div>
				</form>
				
				
				<div class="divBot">
					<a href="">회원가입</a> | <a href="<%= cp %>/find_id.jsp">아이디 찾기</a> | <a href="<%= cp %>/find_pw.jsp">비밀번호 찾기</a>
				</div>
			</div>
		</div>
		<jsp:include page="footer.jsp" flush="false" />
	</div>
</body>
</html>