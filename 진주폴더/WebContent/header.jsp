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
</head>
<body>
	<nav class="navbar navbar-expand-sm navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand m-sm-3" href="#"> <img
				src="images/logo3.png" alt="" width="150px" height="70px">
			</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<!-- <li class="nav-item">
                <a class="nav-link" aria-current="page" href="#">스터딧소개</a>
              </li> -->
					<li class="nav-item"><a class="nav-link" href="#">스터디 찾기</a></li>
					<li class="nav-item"><a class="nav-link" href="#">스터디 개설</a></li>
					<li class="nav-item"><a class="nav-link" href="#">스터디 후기</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">
							정보공유 게시판 </a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="#">세미나/공모전 알림</a></li>
							<li><a class="dropdown-item" href="#">면접/코딩테스트 후기</a></li>
							<li><a class="dropdown-item" href="#">IT기술정보 공유</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="#">자유게시판</a></li>
							<li><a class="dropdown-item" href="#">Q&A</a></li>
						</ul>
				</ul>
				<form class="d-flex">
					<input class="form-control me-2" type="search" placeholder="검색"
						aria-label="Search">
				</form>
				<!--account-->
				<nav style="-bs-breadcrumb-divider: '|';" aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="#">로그인</a></li>
						<li class="breadcrumb-item"><a href="#">회원가입</a></li>
						<li class="breadcrumb-item"><a href="#">고객센터</a></li>
					</ol>
				</nav>
			</div>
		</div>
	</nav>

</body>
</html>