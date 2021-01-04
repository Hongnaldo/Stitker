<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Support_Q&A_answer.jsp</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<script src="https://kit.fontawesome.com/5cdf4f755d.js" crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>

<!-- 직접 설정한 CSS -->
<link rel="stylesheet" href="css/sumin/Layout.css">
<link rel="stylesheet" href="css/sumin/DetailPage.css">
<link rel="stylesheet" href="css/sumin/Q&A_detailPage.css">

<script type="text/javascript">

	function clickAnswer() {
		document.getElementById("answer").style.display = "block";
		document.getElementById("answerBtn").innerHTML = "답변등록하기";
	}

</script>
</head>
<body>

<div class="wrapper">
	<jsp:include page="header.jsp" flush="false"/>
	<div class="main-content"><br>
		<div class="menu">
		<br> 
			<h1 class="text-center">고객센터</h1>
			<br><br><br>
			<nav>
				<ul>
					<li><a href="Support_notice_list.jsp">공지사항</a></li>
					<li><a href="Support_Q&A_list.jsp" class="selected">1:1문의</a></li>
				</ul>
			</nav>
		</div>
		
		<div class="content">
			<table class="table">
				<tr>
					<th>제목</th>
					<td colspan="6">제목예시)스터디 개설과 관련한 질문입니다.</td>
				</tr>
				<tr class="title">
					<th>작성자</th>
					<td>허수민</td>
					<th>작성일</th>
					<td>2020/12/13</td>
					<th>답변</th>
					<td>답변 대기</td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="6">안녕하세요
					<br><br><br><br><br><br><br><br><br>
					</td>
				</tr>
				<tr>
					<th>답변</th>
					<td colspan="6">현재 등록된 답변이 없습니다.  답변 없을 때는 답변 등록 버튼 보임. 답변 있을 때는 등록 대신 수정 버튼이 보임.</td>
				</tr>
			</table>
			<div class="answer" id="answer">
				<span class="icon">
				<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-arrow-return-right" viewBox="0 0 16 16">
  					<path fill-rule="evenodd" d="M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5z"/>
				</svg>
				</span>
				<textarea class="form-control" rows="6" placeholder="답변을 입력하세요."></textarea>
			</div>
			<br>
			<div class="buttons">
				<button type="button" class="btn btn-outline-primary">답변수정하기</button>
				<button type="button" class="btn btn-outline-primary" onclick="window.location.href='Support_Q&A_list.jsp'">목록으로</button>
				<button type="button" class="btn btn-outline-primary" onclick="clickAnswer()" id="answerBtn">답변하기</button>
			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp" flush="false"/>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
</body>
</html>