<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Study_apply_confirm.jsp</title>
<style type="text/css">
	table { border-collapse: collapse; width: 80%; height: 80%; margin-right: auto; margin-left: auto;}
	td, th { border-bottom: 1px solid lightGray; }
	th { background-color: #F5F5F5; width: 20%; height: 40px;}
	.buttons {position: absolute; right:10%;}
</style>
</head>
<body>

<h1>스터디</h1>
<h3>스터디 신청 확인</h3>

<table>
	<tr>
		<th>이름</th>
		<td colspan="5"></td>
	</tr>
	<tr>
		<th>개설자</th>
		<td colspan="2"></td>
		<th>개설일</th>
		<td colspan="2"></td>
	</tr>
	<tr>
		<th>시작날짜</th>
		<td colspan="2"></td>
		<th>종료날짜</th>
		<td colspan="2"></td>
	</tr>
	<tr>
		<th>횟수</th>
		<td></td>
		<th>요일</th>
		<td></td>
		<th>시간</th>
		<td></td>
	</tr>
	<tr>
		<th>장소</th>
		<td colspan="5"></td>
	</tr>
	<tr>
		<th class="content">안내사항</th>
		<td colspan="5">x월 x일 이후 나가면 패널티. 잘 확인하라는 메시지.
		<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
		</td>
	</tr>
</table>
<br>
<button type="submit" class="buttons">신청확인</button>

</body>
</html>