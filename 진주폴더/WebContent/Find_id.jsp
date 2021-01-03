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
<title>Find_id.jsp</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/style.css">
<script src="http://code.jquery.com/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/5cdf4f755d.js"></script>

<!-- 로그인 관련 페이지 공통 css-->
<link rel="stylesheet" href="<%=cp%>/css/login.css" />

<!-- 아이디 찾기, 비밀번호 찾기 페이지 공통 css -->
<link rel="stylesheet" href="<%=cp%>/css/find.css" />

<!-- 스크립트 처리 -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script type="text/javascript">
	$(document).ready(function()
	{
		$("#rdo_byEmail").click(function()
		{
			$("#findId_byEmail").css("display", "block");
			$("#findId_byTel").css("display", "none");
		});

		$("#rdo_byTel").click(function()
		{
			$("#findId_byTel").css("display", "block");
			$("#findId_byEmail").css("display", "none");
		});
	});
</script>

</head>
<body>
	<div class="wrapper">
		<jsp:include page="header.jsp" flush="false" />
		<div class="main-content"><br>

			<div class="login">
				<div class="divTop">
					<h5>
						아이디 찾기<br> <small>아이디 찾기 방법을 선택해 주세요.</small>
					</h5>
				</div>
				<br />


				<!-- 이메일로 찾기 -->
				<form action="">
					<div class="form-group">
						<label for="rdo_byEmail"> <input type="radio"
							id="rdo_byEmail" /><span class="findTxt"> 내 정보에 등록된 이메일로
								찾기</span>
						</label>

						<div id="findId_byEmail">
							<div class="form-group">
								<input type="text" class="form-control"
									placeholder="example@email.com" required="required" /> <span
									style="color: red; font-size: small;">입력한 이메일과 일치하는
									회원정보가 존재하지 않습니다.</span>
							</div>
							<button type="submit" class="btn btn-outline-primary">다음
								단계</button>
						</div>
					</div>
				</form>
				<br /> <br />


				<!-- 휴대폰 번호로 찾기 -->
				<form action="">
					<div class="form-group">
						<label for="rdo_byTel"> <input type="radio" id="rdo_byTel" /><span
							class="findTxt"> 내 정보에 등록된 휴대폰 번호로 찾기</span>
						</label>

						<div id="findId_byTel">
							<div class="form-group">
								<input type="text" class="form-control"
									placeholder="012-3456-7890" required="required" /> <span
									style="color: red; font-size: small;">입력한 번호와 일치하는 회원정보가
									존재하지 않습니다.</span>
							</div>
							<button type="submit" class="btn btn-outline-primary">다음
								단계</button>
						</div>
					</div>
				</form>
				<br /> <br />


				<div class="divBot">
					<small>비밀번호를 찾으시나요? <a href="">비밀번호 찾기</a></small>
				</div>
			</div>

		</div>
		<jsp:include page="footer.jsp" flush="false" />
	</div>
</body>
</html>