<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BootEx02.html</title>

<link rel="stylesheet" href="css/bootstrap.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>

<style type="text/css">
	/* 테이블 기본 서식 */
	#table
	{
		width: 500px;
		border: 1px solid black;
		border-collapse: collapse;
		
	}
	
	#table td
	{
		border: 1px solid black;
	}
</style>

</head>
<body>

<h1>1. 기본 테이블<small>기본</small></h1>

<!-- table>(tr>td{cell}*4)*10 -->
<table>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
</table>


<h1>2. 기본 테이블<small>스타일 적용</small></h1>

<!-- table>(tr>td{cell}*4)*10 -->
<table id="table">
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
</table>


<h1>3. 부트스트랩 기본  테이블<small>기본</small></h1>

<!-- table>(tr>td{cell}*4)*10 -->
<table>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
</table>


<h1>4. 부트스트랩 기본 테이블<small>클래스 적용</small></h1>

<!-- table>(tr>td{cell}*4)*10 -->
<table class="table">
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
</table>


<h1>5. 부트스트랩 기본 테이블<small>클래스 적용 및 크기 설정</small></h1>

<!-- table>(tr>td{cell}*4)*10 -->
<table class="table" style="width: 500px;">
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
</table>


<h1>6. 부트스트랩 보더 테이블<small>클래스 활용</small></h1>

<!-- table>(tr>td{cell}*4)*10 -->
<table class="table table-bordered" >
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
</table>


<h1>7. 부트스트랩 스트라이프 테이블<small>클래스 활용</small></h1>

<!-- table>(tr>td{cell}*4)*10 -->
<table class="table table-striped" >
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
</table>


<h1>8. 부트스트랩 작은 테이블<small>클래스 활용</small></h1>

<!-- table>(tr>td{cell}*4)*10 -->
<table class="table table-condensed" >
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
</table>


<h1>9. 부트스트랩 호버 테이블<small>클래스 활용</small></h1>

<!-- table>(tr>td{cell}*4)*10 -->
<table class="table table-hover" >
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
</table>



<h1>10. 부트스트랩 테이블 종합 <small>클래스 활용</small></h1>

<!-- table>(tr>td{cell}*4)*10 -->
<table class="table table-striped table-condensed table-hover" >
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
	<tr>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
		<td>cell</td>
	</tr>
</table>

</body>
</html>