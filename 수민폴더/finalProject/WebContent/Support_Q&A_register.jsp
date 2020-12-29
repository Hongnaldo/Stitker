<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Support_Q&A_register.jsp</title>

<script type="text/javascript">

	window.onload = function() {
		document.getElementById("content").focus();
	}
	
	
</script>

<style type="text/css">
	.title {height: 50px; font-size: 18pt;}
	.all {display: table; margin-left: auto; margin-right: auto;}
	.title, .content { width: 800px;}
</style>
</head>
<body>

<h1>고객센터</h1>
<h3>1:1 질문 작성</h3>
<br><br><br>
<form action="">
	<div class="all">
	<input type="text" class="title" placeholder="제목을 입력하세요">
	<br><br>
	<textarea rows="40" cols="100" id="content" class="content">수정할 내용 불러오기</textarea>
	<button type="submit">수정</button>
</div>
</form>
</body>
</html>

