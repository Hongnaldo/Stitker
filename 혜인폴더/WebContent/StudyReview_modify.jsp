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

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp %>/js/util.js"></script>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.css">
<link href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/Write.css">
<link rel="stylesheet" href="css/Layout.css">
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

<div class="whole">
	<jsp:include page="header.jsp" flush="false"/>
	<div class="menu">
		<br> 
		<h1 class="text-center">정보공유</h1>
		<br><br>
		<nav>
			<ul>
				<li><a href="Board_inform_list.jsp">IT기술정보공유</a></li>
				<li><a href="Board_seminar_list.jsp">세미나 및 공모전</a></li>
				<li><a href="Board_interview_list.jsp" >면접/코딩테스트 후기</a></li>
				<li><a href="Board_free_list.jsp">자유게시판</a></li>
				<li><a href="Board_Q&A_list.jsp">Q&A</a></li>
				<li><a href="Board_studyReview_list.jsp" class="selected">스터디 후기</a></li>
			</ul>
		</nav>
	</div>
	
	<div class="content">
		<br>
		<p class="category">스터디 후기 수정하기</p>
		<form action="" method="post" name="myForm" role="form" class="form-inline">
		<table class="table table-borderless" id="table">
			<tr>
				<th>
					말머리
				</th>
				<td>
					<select name="searchCategory" class="form-control" required="required">
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
				<th>
					제목
				</th>
				<td>
					<input type="text" class="form-control" placeholder="제목을 입력하세요" required="required" id="title"
					value="수정전의 제목을 받아옴">
				</td>
			</tr>
			<tr>
			<tr>
				<td colspan="2">
					<textarea class="form-control" placeholder="내용을 입력하세요"  style="height: 170px;" required="required" name="editordata" id="summernote"
					>수정전 글의 내용을 받아옴</textarea>
				</td>
			</tr>
			<tr>
				<th>패스워드</th>
				<td>
					<input type="password" class="form-control" placeholder="패스워드를 입력하세요" required="required">
				</td>
			</tr>
			
			
		</table>
		<div id="btnSet">
			<input type="submit" value="수정하기" class="btn btn-outline-primary">
			<input type="button" value="취소하기" class="btn btn-outline-primary" id="cancel" >	
		</div>
		</form>
	
	</div>
	<jsp:include page="footer.jsp" flush="false"/>
</div>
 
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
</body>
</html>