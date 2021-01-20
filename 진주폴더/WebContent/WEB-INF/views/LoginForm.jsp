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
<!-- 로그인 관련 페이지 공통 css-->
<link rel="stylesheet" href="<%=cp%>/css/login.css" />
<style type="text/css">
.login_input>p {
	color: red;
	font-size: 9pt;
	display: none;
}
.form-control {
	margin-bottom: 15px;
}
.divBot a
{
	text-decoration: none;
	color: gray;
}
.divBot a:hover
{
	color: SlateBlue;
	font-weight: bold;
}
</style>
</head>
<body>
	<div class="wrapper">
		<jsp:include page="header.jsp" flush="false" />
		<div class="main-content" style="margin-left:auto; margin-right:auto;">
			
			
			<div>
			<br><br>
			<div class="login">
				<div class="divTop">
					<h5><strong>로그인</strong></h5>
				</div>
				<br>
				
				<form action="login.action" method="post">
					<div class="login_input">
						<!-- 로그인 ID 입력 -->
						<input type="text" class="form-control" id="id" name="id"
							placeholder="아이디 입력" required="required"/><!-- value = "${id} -->

						<!-- 로그인 Password 입력 -->
						<input type="password" class="form-control" id="pw" name="pw"
							placeholder="비밀번호 입력" required="required" />
						<!-- <p>입력한 아이디와 비밀번호가 일치하지 않습니다. 아이디 또는 비밀번호를 다시 한번 입력해 주세요.</p> -->
						<p>${sessionScope.logres }</p>
						<br><br>
						
						<div class="custom-control custom-checkbox">
							<input type="checkbox" id="loginck" name="loginck" value="true" class="custom-control-input">
							<label class="custom-control-label" for="loginck">로그인 상태 유지</label>
						</div>		

						<!-- 로그인 버튼 -->
						<button type="submit" class="btn btn-outline-primary form-control" style="margin-top: 15px; margin-bottom: 22px;">로그인</button>
					</div>
				</form>
				
				
				<div class="divBot">
					<small><a href="">회원가입</a> | <a href="findidform.action">아이디 찾기</a> | <a href="findpwform.action">비밀번호 찾기</a></small>
				</div>
			</div><!-- end .login -->
			</div>
			
		</div><!-- end .main-content -->
		<jsp:include page="footer.jsp" flush="false" />
	</div><!-- end .wrapp -->
</body>
</html>