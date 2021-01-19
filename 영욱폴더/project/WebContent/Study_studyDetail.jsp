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
    <title>Study_studyList.jsp</title>
    <script src="https://kit.fontawesome.com/5cdf4f755d.js"></script>
    <link rel="stylesheet" href="css/Layout.css">
    <link rel="stylesheet" href="css/Study_apply.css">

</head>
<body>
<div class="wrapper">
 <jsp:include page="header.jsp" flush="false"/>
 <div class="main-content text-center"><br>

			<div class="menu">
				<br>
				<br>
				<h1 class="text-center">스터디</h1>
				<br>
				<br>
				<br>
				<nav>
					<ul>
						<li><a>스터디</a></li>
						<li><a>스터디 개설</a></li>
						<li><a  class="selected">스터디 상세페이지</a></li>
					</ul>
				</nav>
			</div>

			<div class="content">
			<br>
			<p class="category">조회한 스터디의 상세 정보</p><br>
			<div class="tableDiv">
				<table class="table">		
					<tr>
						<th>스터디 이름</th>
						<td class="left">자바 중급 / 오라클 스터디</td>
						<th>스터디 종류</th>
						<td>프로젝트</td>
					</tr>
					<tr>
						<th>스터디 리더 등급</th>
						<td> 3등급 </td>
						<th>모집 상태</th>
						<td> 모집중 </td>
					</tr>
					<tr>
						<th>개설자</th>
						<td>홍길동</td>
						<th>개설일</th>
						<td>2020 / 01 / 01</td>
					</tr>
					<tr>
						<th>시작날짜</th>
						<td>2020 / 02 / 01</td>
						<th>종료날짜</th>
						<td>2021 / 03 / 01</td>
					</tr>
					<tr>
						<th rowspan="2">횟수</th>
						<td rowspan="2">2</td>
						<th rowspan="2" class="narrow">요일 및 시간</th>
						<td>월요일 13:00~15:00</td>
					</tr>
					<tr>	
						<td>수요일 16:00~18:00</td>
					</tr>
					<tr>
						<th>장소</th>
						<td colspan="5">서울시 마포구</td>
					</tr>
					<tr>
						<th>현재 참여 신청 인원</th>
						<td> 3명 </td>
						<th>마감 인원</th>
						<td> 5명 </td>
					</tr>
					
					<tr>
						<th>스터디 설명 및 안내</th>
						<td colspan="5" class="left">x월 x일 스터디가 시작됩니다. x월 x일 이후에 스터디 참가 취소를 하게 되면 패널티가 있습니다.
						<br>스터디 참여 가능한 인원을 벗어나거나 최소 인원이 넘을 경우 리더가 스터디원을 선택하여 스터디를 취소하게 됩니다.
						<br>이 경우에 선택되지 않더라도 패널티가 부여되지 않습니다.
						<br>등등 안내사항 정리
						</td>
					</tr>
				</table>
				</div>
				<div class="buttons">
					<button type="submit" class="btn btn-outline-primary" onclick="click_confirm()">신청하기</button>
					<button type="submit" class="btn btn-outline-primary">돌아가기</button>
				</div>
			<br>
		</div>

		</div>
 <jsp:include page="footer.jsp" flush="false"/>
 </div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
</body>
</html>