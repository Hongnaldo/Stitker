<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Report_detailpage</title>
<style type="text/css">
	table {border-collapse: collapse; width: 500px;}
	th {border-bottom: 1px solid black; height: 30px; text-align: left;}
	td {height: 25px;}
	.reason {background-color: Gainsboro;}
	button {margin-right: 30px;}
	.buttons {display :table; margin-left: auto; margin-right: auto;}
</style>
<link rel="stylesheet" href="css/Report_list.css">

<script type="text/javascript">

	function clickBtn(args) 
	{
		var message = "";
		var type = 1;
		
		if (args=="글삭제") 
			message = "글을 삭제하시겠습니까? (제재 없음)";	
		else if (args=="경고1회") 
			message = "대상자에게 경고 1회를 부여하겠습니까?";	
		else
		{	
			message = "신고대상이 아니므로 신고수를 초기화하겠습니까?";
			type = 2;
		}	
		
		var response = confirm(message);
		
		if(response && type==2)
		{
			var response2 = confirm("신고자에게 허위신고로 경고 1회를 부여하겠습니까?");
		}	
	}
</script>

</head>
<body>
<div class="menu">
	<h1>신고확인</h1>
	<br><br><br>
	<nav>
		<ul>
			<li><a href="Study_report_list.jsp">스터디</a></li>
			<li><a href="Participant_report_list.jsp">스터디원</a></li>
			<li><a href="Board_report_list.jsp">게시물</a></li>			
		</ul>
	</nav>
</div>

<div class="content">
	신고내역<br>
	<div class="table">
		<table>
			<tr class="first">
				<th>번호</th>
				<th>신고사유</th>
				<th>신고자</th>
				<th>신고일자</th>
			</tr>
			<tr>
				<td>1</td>
				<td>예시스팸,광고</td>
				<td>예시허수민</td>
				<td>예시2020/12/25</td>
			</tr>
			<tr>
				<td>2</td>
				<td>예시기타</td>
				<td>예시허수민</td>
				<td>예시2020/12/25</td>
			</tr>
			<tr>
				<td></td>
				<td colspan="3" class="reason">기타를 선택한 경우 사유(해당 게시물은 저작권을 침해한 게시물입니다.)</td>
			</tr>
			<tr>
				<td>3</td>
				<td>예시스팸,광고</td>
				<td>예시허수민</td>
				<td>예시2020/12/25</td>
			</tr>
		</table>
	</div>
	<br><br>
	<div>
		게시물 상세페이지 가져오기
	</div>
	<br><br>
	<form action="">
		<div class="buttons">
			<button type="submit" onclick="clickBtn(this.innerText)">글삭제</button>
			<button type="submit" onclick="clickBtn(this.innerText)">경고1회</button>
			<button type="submit" onclick="clickBtn(this.innerText)">신고대상아님</button>
		</div>
	</form>
</div>
</body>
</html>