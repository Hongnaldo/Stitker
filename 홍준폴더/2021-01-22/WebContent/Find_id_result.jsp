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
<title>Find_id_result.jsp</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/style.css">
<script src="http://code.jquery.com/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/5cdf4f755d.js"></script>

<!-- 로그인 관련 페이지 공통 css-->
<link rel="stylesheet" href="<%=cp%>/css/login.css" />

<!-- 아이디 찾기 결과, 비밀번호 찾기 결과 페이지 공통 css -->
<link rel="stylesheet" href="<%=cp%>/css/findresult.css" />

</head>
<body>
	<div class="wrapper">
		<jsp:include page="header.jsp" flush="false" />
		<div class="main-content"><br />

			<div class="login">
				<div class="divTop">
					<p class="category">
						아이디 찾기<br>
					</p>
				</div>
				<br />

				<div class="find_result">
					<!-- 아이디 찾기 결과 -->
					<span><span id="userInfo">test@example.com</span> 으로 찾은 아이디입니다.</span>
					<br />
					<br />

					<!-- 사용자 아이디 -->
					<span id="find_result">test12345</span> <br />
					<br />
					<br />
					<br />


					<div id="btn_gotoLogin" style="padding-bottom: 15px;">
						<form action="">
							<button type="submit" class="btn btn-outline-primary">로그인
								하러가기</button>
						</form>
					</div>
				</div>
				<br />
			</div>

		</div>
		<jsp:include page="footer.jsp" flush="false" />
	</div>
</body>
</html>