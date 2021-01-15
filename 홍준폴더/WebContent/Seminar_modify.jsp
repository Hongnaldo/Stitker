<%@ page  contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8");
   String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<script src="https://kit.fontawesome.com/5cdf4f755d.js" crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/Write.css">

<link rel="stylesheet" href="css/Layout.css">

<script src="js/summernote-lite.js"></script>
<script src="js/summernote-ko-KR.js"></script>	
<link rel="stylesheet" href="css/summernote-lite.css">

<script type="text/javascript">

	window.onload = function() {
		document.getElementById("title").focus();
	}
</script>

<script type="text/javascript">
	
		$(document).ready(function() {
			$('#summernote').summernote({
				height: 400,
				minHeight: null,
				maxHeight: null,
				focus: true,
				lang: "ko-KR",
				placeholder: '내용을 입력하세요.'
	  		});
			
			$("#cancel").click(function()
			{
				var result = confirm("취소 하시겠습니까?");
				
				if(result)
				{
					location.replace("Seminar_write.jsp");
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
				<li><a href="Board_inform_list.jsp" >IT기술정보공유</a></li>
				<li><a href="Board_seminar_list.jsp" class="selected">세미나 및 공모전</a></li>
				<li><a href="Board_interview_list.jsp" >면접/코딩테스트 후기</a></li>
				<li><a href="Board_free_list.jsp">자유게시판</a></li>
				<li><a href="Board_Q&A_list.jsp" >Q&A</a></li>
				<li><a href="Board_studyReview_list.jsp" >스터디 후기</a></li>
			</ul>
		</nav>
	</div>
	
	<div class="content">
		<p class="category">세미나/공모전 글 수정하기</p>
		<br>
		<form action="" method="post" name="myForm" role="form" class="form-inline">
		<table class="table table-borderless" id="table">
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
				<th>
					말머리
				</th>
				<td>
					<select name="searchCategory" class="form-control" required="required">
						<option value="name">세미나</option>
						<option value="content">공모전</option>
					</select>
				</td>
			</tr>
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

</body>	
</html>