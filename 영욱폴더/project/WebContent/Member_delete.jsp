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
    <script src="http://code.jquery.com/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
    <title>Member_delete.jsp</title>
    <script src="https://kit.fontawesome.com/5cdf4f755d.js"></script>
    <link rel="stylesheet" href="css/Layout.css">

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

			<div class="content" style="background-color:white;">
				<div class="table" >
					<center>
						<p style="font-weight: 700; ">내 정보</p>
						<form class="login" name="newMem" action="loginOk.jsp"
							method="post" >
							<table cellspacing=10 class="table table-striped table-condensed table-hover">
								<tr>
									<td>아 이 디 :</td>
									<td><input type="text" name="id" hidden="" class="form-control">abcd</td>
								</tr>

								<tr>
									<td>이 름 :</td>
									<td><input type="text" name="name" " hidden="">홍길동</td>
								</tr>

								<tr>
									<td>관심분야:</td>
									<td>프로젝트 - 자바</td>
								</tr>


								<tr>
									<td>지역</td>
									<td>강남,서초,송파</td>
								</tr>

								<tr>
									<td>직업:</td>
									<td>웹 개발자</td>
								</tr>

								<!-- <tr>
									<td>전화번호 :</td>

									<td>010-1234-5678</td>
								</tr> -->

								<tr>
									<td>이메일 주소 :</td>

									<td>naver123@naver.com</td>
								</tr>
								<tr>
									<td>주소 :</td>
									<td>서울시 마포구 마포로 11</td>
								</tr>
								
								<tr>
									<td>관심 스터디 유형</td>
									<td>...</td>
								</tr>
								

							</table>
						</form>
					</center>
				</div>
				<br>

				<div>
					<center>
						<br>정말로 회원 탈퇴 하시겠습니까?<Br> <Br>
						<button type="submit" name="submitBtn" value="회원탈퇴" class="btn btn-primary">회원탈퇴</button>
						<button type="button" name="resetBtn" value="취소" class="btn btn-primary">취소</button>
					</center>
				</div>
			</div>

		</div>
 <jsp:include page="footer.jsp" flush="false"/>
 </div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
</body>
</html>