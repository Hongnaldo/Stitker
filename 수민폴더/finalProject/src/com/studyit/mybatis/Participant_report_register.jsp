<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Participant_report_register.jsp</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<script src="https://kit.fontawesome.com/5cdf4f755d.js" crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery.min.js"></script>

<!-- 직접 설정한 CSS -->
<link rel="stylesheet" href="css/sumin/Report_register.css">

</head>
<body>
<br>
<form action="">
	<div class="contents">
	<h3 class = "title">신고하기</h3>
	<br>
	<table class="table">
		<tr>
			<th>유형</th>
			<td>스터디원</td>
		</tr>
		<tr>
			<th>스터디</th>
			<td>스터디이름</td>
		</tr>
		<tr>
			<th>대상자</th>
			<td>사용자아이디불러와야함</td>			
		</tr>
	</table>
	<br>

    <span class="message">위 스터디에 대한 대표적인 신고사유 1개를 선택하세요.</span>
    <br><br>
	<div class="form-check">
		<label><input type="radio" name="report_category" onclick="hide_textarea()" class="form-check-input" required> 따돌림(카테고리 가져오기)</label><br>
		<label><input type="radio" name="report_category" onclick="hide_textarea()" class="form-check-input"> 부정출석 </label><br>
		<label><input type="radio" name="report_category" onclick="hide_textarea()" class="form-check-input"> 태도불량 </label><br>
		<label><input type="radio" name="report_category" onclick="hide_textarea()" class="form-check-input"> 불쾌감을 주는 언행 </label><br>
		<label><input type="radio" name="report_category" onclick="hide_textarea()" class="form-check-input"> 목적에 벗어난 참여(다단계, 종교 등) </label><br>
		<label><input type="radio" name="report_category" onclick="show_textarea()" class="form-check-input"> 기타</label><br>
	</div>
	<br>
	<textarea name="report_reason" id="report_reason"  class="form-control textArea"
	cols="40" rows="10" placeholder="구체적인 신고 사유를 입력해주세요."></textarea>
	<br>
	<button type="submit" class="btn btn-outline-primary">확인</button>
</div>
</form>
</body>
</html>

