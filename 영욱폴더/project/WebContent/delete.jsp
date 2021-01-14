
<body>
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
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>

<body>

	<div id="container">
		<nav>
			<div class="loginBar" align="right">
				<a href="login.jsp">로그인</a>
				<a href="myPage.jsp">마이페이지</a> 
			    <a href="join.jsp">회원가입</a>
			</div>
			<!-- <div class="menubar">
			</div> -->

		</nav>
		
		
		<div align="left">
		
		<ul>
			<a href="updateMember.jsp"><li>내정보수정</li></a>
			<a href=""><li>내 스터디</li></a>
			<a href="deleteMember.jsp"><li>회원 탈퇴</li></a>
		</ul>
		</div>
		
		<div class="loginBox" align="center" >
			<center>
				<p>내 정보</p>
				<form class="login" name="newMem" action="loginOk.jsp" method="post">
					<table cellspacing=20>
						<tr>
							<td style="text-align: right;">아 이 디 :</td>
							<td><input type="text" name="id" style="height: 20px;"size:"10"; hidden="">abcd</td>
						</tr>

						<tr>
							<td style="text-align: right;">이 름 :</td>
							<td>
							<input type="text" name="name" style="height: 20px; width: 100px;" hidden="">홍길동
							</td>
						</tr>

						
						<tr>
							<td style="text-align: right;">지역</td>
							<td>
								강남,서초,송파
							</td>
						</tr>
						
						<tr>
							<td style="text-align: right;">직업:</td>
							<td>
								웹 개발자
							</td>
						</tr>
						
						<tr>
							<td style="text-align: right;">관심분야:</td>
							<td> 프로젝트 - 자바
							</td>
						</tr>

						<tr>
							<td style="text-align: right;">전화번호 :</td>

							<td>
							010-1234-5678
							</td>
						</tr>

						<tr>
							<td style="text-align: right;">이메일 주소 :</td>

							<td>naver123@naver.com</td>
						</tr>
						<tr>
							서울시 마포구 마포로 11
						</tr>

					</table>
					<div>
						<br>정말로 회원 탈퇴 하시겠습니까?<Br><Br>
						<button type="submit" name="submitBtn" value="회원탈퇴">회원탈퇴</button>
						<button type="button" name="resetBtn" value="취소">취소</button>
					</div>
				</form>
			</center>
		</div>
		

		<div class="footer" align="center">
			<p>© Copyright 2019 - All Rights Reserved U.S.A | +1
				(670) 789 8231 |</p>
		</div>
	</div>

</body>
</html>

</body>
</html>