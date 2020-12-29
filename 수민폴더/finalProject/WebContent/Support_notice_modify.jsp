<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Support_notice_write.jsp</title>

<script type="text/javascript">

	window.onload = function() {
		document.getElementById("content").focus();
	}
	
	
</script>

<style type="text/css">
	.title {height: 50px; font-size: 18pt;}
	.all {display: table; margin-left: auto; margin-right: auto;}
	.title, .content { width: 1000px;}
	button {width: 20px;}
	.option{margin-left: 20px; margin-top: 3px;}
	.options {background-color: Gainsboro; height: 30px;}
</style>
</head>
<body>

<h1>공지사항-수정하기</h1>
<br><br><br>
<div class="all">
	<input type="text" class="title" placeholder="제목을 입력하세요">
	<br><br>
	
	<div class="options">
		<button class="option" onclick="click_italic()">I</button>
		<button class="option" onclick="click_bold()">B</button>
		<select name="color" id="color" class="option" onchange="click_color(this)">
			<option>글자색</option>
			<option value="black">검정</option>
			<option value="red">빨강</option>
			<option value="blue">파랑</option>
			<option value="green">초록</option>
		</select>
		<select name="size" id="size" class="option" onchange="click_size(this)">
			<option>글자크기</option>
			<option value="small">small</option>
			<option value="medium">medium</option>
			<option value="big">big</option>
		</select>
	</div>
	<textarea rows="100" cols="100" id="content" class="content">수정할 파일 내용 불러와야 함.</textarea>
</div>
</body>
</html>