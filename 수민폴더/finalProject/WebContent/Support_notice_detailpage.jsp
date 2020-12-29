<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Support_notice_detailpage.jsp</title>

<style type="text/css">
	
	table { border-collapse: collapse; width: 80%; height: 80%; margin-right: auto; margin-left: auto;}
	td, th { border-bottom: 1px solid lightGray; }
	th { background-color: #F5F5F5; }
	.title { width: 20%; height: 40px;}
	.btn {margin-rignt: 10px; width: 80px; height: 30px;}
	.buttons {position: absolute; right:10%;}
	
</style>
</head>
<body>

<h1>고객센터</h1>
<h3>공지사항</h3>

<table>
	<tr>
		<th class="title">제목</th>
		<td colspan="5"></td>
	</tr>
	<tr>
		<th class="title">작성자</th>
		<td></td>
		<th class="title">작성일</th>
		<td></td>
		<th class="title">조회수</th>
		<td></td>
	</tr>
	<tr>
		<th class="content">내용</th>
		<td colspan="5">안녕하세요
		<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
		</td>
	</tr>
</table>
<br>
<div class="buttons">
	<button type="submit" class="btn">수정하기</button>
	<button type="submit" class="btn">삭제하기</button>
	<button type="submit" class="btn">목록으로</button>
</div>


</body>
</html>