<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String cp = request.getContextPath(); %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스터디 컨텐츠</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="<%=cp %>/css/style.css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery.min.js"></script>

<!-- Summernote-lite 가져오기 -->
<script src="js/summernote-lite.js"></script>
<script src="js/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="css/summernote-lite.css">

<!-- 직접 설정한 CSS -->
<link rel="stylesheet" href="css/sumin/Layout.css">
<link rel="stylesheet" href="css/sumin/Support_write.css">

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
  
	});

</script>

<style type="text/css">

.table .textareaTd {padding-right: 10%;}

</style>
</head>
<body>
<div class="wrapper">
	<jsp:include page="header.jsp" flush="false"/>
	<div class="main-content">
		<div class="container">
		<br><br><br>
		<form action="" name="myForm">
		<table class="table"> 
			<tr>
				<th colspan="2">스터디이름</th>
				<th colspan="6" style="background-color: #ffffff;">스터디 컨텐츠</th>
			</tr>
			<tr>
				 <th>작성자</th>
				 <td>khj77</td>
				 <th>작성일</th>
				 <td>2020-01-02</td>
				 <th>조회수</th>
				 <td>10</td>
				 <th>추천수</th>
				 <td>0</td>
			</tr>
			<tr>
				<td colspan="8" style="height: 300px;">맛있는 해남고구마 10kg 2만원 파격행사!!</td>
			</tr>
			<tr>
				<td colspan="8">
					<div class="BoardDetail_noLine">
						이전글 : 없음.
					</div><!-- .BoardDetail_noLine -->
				</td>
			</tr>
			<tr>
				<td colspan="8">
					<div class="BoardDetail_noLine">
						다음글 : (2) 스터디 일정 필독!!
					</div><!-- .BoardDetail_noLine -->
				</td>
			</tr>
		</table>
		<br><br> 
		<button  type="button" value="전체목록" class="btn btn-outline-primary btn-sm">전체목록</button>
	</form>
    </div>
	</div>
	<jsp:include page="footer.jsp" flush="false"/>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>	
</div>	
</body>
</html>