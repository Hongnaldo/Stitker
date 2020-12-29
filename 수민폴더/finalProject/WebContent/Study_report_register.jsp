<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Study_report_register.jsp</title>

<link rel="stylesheet" href="css/Report_register.css">

<script type="text/javascript">
	/* 신고사유 보이기 */
	function show_textarea() {
		document.getElementById("report_reason").style.display="block";
	}
	
	/* 신고사유 감추기 */
	function hide_textarea() {
		document.getElementById("report_reason").style.display="none";
	}
</script>
</head>
<body>

<h3>신고하기</h3>

<div>
	<table>
		<tr>
			<th>유형</th>
			<td>스터디</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>제목불러와야함</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>작성자불러와야함</td>
		</tr>
	</table>
</div>

<br><br>

<div>
    <span class="message">위 게시물에 대한 대표적인 신고사유 1개를 선택하세요.</span>
    <br><br>
	<label><input type="radio" name="report_category" onclick="hide_textarea()"> 광고, 스팸</label><br>
	<label><input type="radio" name="report_category" onclick="hide_textarea()"> 욕설, 비방 </label><br>
	<label><input type="radio" name="report_category" onclick="hide_textarea()"> 음란, 유해 </label><br>
	<label><input type="radio" name="report_category" onclick="show_textarea()"> 기타</label><br>
	<br>
	<textarea name="report_reason" id="report_reason" cols="40" rows="10" onclick="click_reason()" placeholder="구체적인 신고 사유를 입력해주세요."></textarea>
	<br>
	<span class="btn"><button type="submit">확인</button></span>
</div>

</body>
</html>

