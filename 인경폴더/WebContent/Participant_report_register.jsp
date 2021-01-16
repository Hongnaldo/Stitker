<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Participant_report_register.jsp</title>
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
<!-- $.ajax() 로 target 을 #layer_pop  -->
<h3>신고하기</h3>
<div>
	<table>
		<tr>
			<th>유형</th>
			<td>스터디</td>
		</tr>
		<tr>
			<th>이름</th>
			<td>스터디이름불러와야함</td>
		</tr>
		<tr>
			<th>개설자</th>
			<td>스터디 개설자 불러와야함</td>
		</tr>
	</table>
</div>

<br><br>

<div>
    <span class="message">위 스터디에 대한 대표적인 신고사유 1개를 선택하세요.</span>
    <br><br>
	<label><input type="radio" name="report_category" onclick="hide_textarea()"> 따돌림</label><br>
	<label><input type="radio" name="report_category" onclick="hide_textarea()"> 부정출석 </label><br>
	<label><input type="radio" name="report_category" onclick="hide_textarea()"> 태도불량 </label><br>
	<label><input type="radio" name="report_category" onclick="hide_textarea()"> 불쾌감을 주는 언행 </label><br>
	<label><input type="radio" name="report_category" onclick="hide_textarea()"> 목적에 벗어난 참여(다단계, 종교 등) </label><br>
	<label><input type="radio" name="report_category" onclick="show_textarea()"> 기타</label><br>
	<br>
	<textarea name="report_reason" id="report_reason" cols="40" rows="10" onclick="click_reason()" placeholder="구체적인 신고 사유를 입력해주세요."></textarea>
	<br>
	<span class="btn"><button type="submit">확인</button></span>
</div>
</body>
</html>

