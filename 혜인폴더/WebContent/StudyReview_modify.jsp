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
<title>스터디 후기 수정</title>

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/boardwrite.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp %>/js/util.js"></script>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.css">
<link href="css/bootstrap.min.css">
<title>Mypage_evaluationComplete</title>
<script src="https://kit.fontawesome.com/5cdf4f755d.js" crossorigin="anonymous"></script>

<script type="text/javascript">

	$(document).ready(function() {
	    $('#commentBox').on('keyup', function() {
	        $('#commentCnt').html("("+$(this).val().length+" / 300)");
	 
	        if($(this).val().length > 300) {
	            $(this).val($(this).val().substring(0, 300));
	            $('#commentCnt').html("(300 / 300)");
	        }
	    });
	});


</script>
   
</head>
<body>
<div class="wrapper">
 <jsp:include page="header.jsp" flush="false"/>
 <div class="main-content text-center"><br>
 
 	<div class="menu">
	<br> 
		<h1 class="text-center">정보공유</h1>
		<br><br><br>
		<nav>
			<ul>
				<li><a href="Board_inform_list.jsp" >IT기술정보공유</a></li>
				<li><a href="Board_seminar_list.jsp">세미나 및 공모전</a></li>
				<li><a href="Board_interview_list.jsp" >면접/코딩테스트 후기</a></li>
				<li><a href="Board_free_list.jsp">자유게시판</a></li>
				<li><a href="Board_Q&A_list.jsp">Q&A</a></li>
				<li><a href="Board_studyReview_list.jsp" class="selected">스터디 후기</a></li>
			</ul>
		</nav>
	</div>

	<div class="main">
		<form action="" name="myForm">
		<table id="table1" class="table">
			<tr>
				<th>말머리</th>
				<td>
					<select name="studyCategory1" class="selectFiled">
						<option value="select">선택</option>
						<option value="dba">DBA/데이터베이스</option>
						<option value="network">네트워크/서버/보안</option>
						<option value="developer">개발자</option>
						<option value="pm">기획자/PM</option>
						<option value="marketing">마케팅</option>
						<option value="designer">디자이너</option>
						<option value="contents">컨텐츠/사이트운영</option>
						<option value="game">게임</option>
						<option value="bigdata">빅데이터/AI</option>
						<option value="videomaking">동영상제작/편집</option>
						<option value="software">소프트웨어/하드웨어</option>
						<option value="erp">ERP/시스템분석/설계</option>
						<option value="edu">교육</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>제목</th>
				 <td>
				 	<input type="text" id="title" size="120" maxlength="100">
				 </td>
			</tr>
			<tr>
				<td colspan="8" style="height: 300px;">
					<textarea name="content" cols="" rows="" class="boxTA"></textarea>
				</td>
			</tr>
			<tr>
				 <th>패스워드</th>
				 <td colspan="3">
				 	<input type="password" id="pwd" size="50">
				 </td>
			</tr>

		</table>
		<br><br>
		
		<div id="btnSet">
			<button type="button" class="btn btn-primary" onclick="sendIt()">수정</button>
			<button type="button" class="btn btn-primary">재입력</button>
			<button type="reset" class="btn btn-primary">취소</button>
		</div><!-- #footer -->
		
		</form>
	
	</div><!-- .main -->
	

	</form>
   
  </div>
  
 <jsp:include page="footer.jsp" flush="false"/>
 </div>
 
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
</body>
</html>