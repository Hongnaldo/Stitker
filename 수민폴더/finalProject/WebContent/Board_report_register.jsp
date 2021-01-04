<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board_report_register.jsp</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.css">
<link href="css/bootstrap.min.css">
<script src="https://kit.fontawesome.com/5cdf4f755d.js" crossorigin="anonymous"></script>

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
			<td>스터디원</td>
		</tr>
		<tr>
			<th>이름</th>
			<td>스터디이름불러와야함</td>
		</tr>
		<tr>
			<th>대상자</th>
			<td>스터디원 ID(,등급) 불러와야함</td>
		</tr>
	</table>
</div>

<br><br>

<div>
    <span class="message">위 스터디에 대한 대표적인 신고사유 1개를 선택하세요.</span>
    <br><br>
    <form action="">
	<label><input type="radio" name="report_category" onclick="hide_textarea()"> 광고, 스팸</label><br>
	<label><input type="radio" name="report_category" onclick="hide_textarea()"> 욕설, 비방 </label><br>
	<label><input type="radio" name="report_category" onclick="hide_textarea()"> 음란, 유해 </label><br>
	<label><input type="radio" name="report_category" onclick="show_textarea()"> 기타</label><br>
	<br>
	<textarea name="report_reason" id="report_reason" class="form-control"
	cols="40" rows="10" onclick="click_reason()" placeholder="구체적인 신고 사유를 입력해주세요."></textarea>
	<br>
	<span><button type="submit" class="btn btn-outline-primary">확인</button></span>
	</form>
</div>

</body>
</html>

