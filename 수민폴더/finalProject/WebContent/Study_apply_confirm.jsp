<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Study_apply_confirm.jsp</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<script src="https://kit.fontawesome.com/5cdf4f755d.js" crossorigin="anonymous"></script>

<!-- 직접 설정한 CSS -->
<link rel="stylesheet" href="css/sumin/Layout.css">
<link rel="stylesheet" href="css/sumin/Study_apply.css">

<script type="text/javascript">

	function click_confirm() {
		
		var response = confirm("안내사항을 모두 확인하셨습니까?");
		
		if (response) {
			window.location.href="Study_apply_complete.jsp";
		}
	}

</script>
</head>
<body>

<div class="wrapper">
	<jsp:include page="header.jsp" flush="false"/>
	<div class="main-content"><br>
		<div class="menu">
		<br><br> 
			<h1 class="text-center">스터디</h1>
			<br><br><br>
			<nav>
				<ul>
					<li><a class="selected">스터디</a></li>
					<li><a >스터디 개설</a></li>
				</ul>
			</nav>
		</div>

		<div class="content">
			<br>
			<p class="category">아래 항목을 다시 한 번 확인해주세요.</p><br>
			<div class="tableDiv">
				<table class="table">		
					<tr>
						<th>스터디 이름</th>
						<td colspan="4" class="left">자바 중급 / 오라클 스터디</td>
					</tr>
					<tr>
						<th>개설자</th>
						<td>허수민</td>
						<th>개설일</th>
						<td>2020 / 12 / 20</td>
					</tr>
					<tr>
						<th>시작날짜</th>
						<td>2020 / 1 / 1</td>
						<th>종료날짜</th>
						<td>2021 / 5 / 31</td>
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
						<th>안내사항</th>
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