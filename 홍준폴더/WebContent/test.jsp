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
<title>기본틀(test.jsp)</title>
<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/style.css">
	<script src="http://code.jquery.com/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="https://kit.fontawesome.com/5cdf4f755d.js"></script>
	<!-- Summernote-lite 가져오기 -->
	<script src="js/summernote-lite.js"></script>
	<script src="js/summernote-ko-KR.js"></script>
	<link rel="stylesheet" href="css/summernote-lite.css">  
<script type="text/javascript">
	
		$(document).ready(function() {
			$('#summernote').summernote({
				height: 500,
				minHeight: null,
				maxHeight: null,
				focus: true,
				lang: "ko-KR",
				placeholder: '내용을 입력하세요.'
	  		});
	  
		});
	
	</script>
</head>
<body>
<div class="wrapper">
 <jsp:include page="header.jsp" flush="false"/>
 <div class="main-content text-center"><br>
   	<form>
   		<table sty>
     		<tr>
     			<td>제목</td>
     			<td><input type="text"></td>
     		</tr>
     		<tr>
     			<td colspan="2"><textarea name="editordata" id="summernote"></textarea><td>
     		</tr>
     	</table>  
     </form>
  </div>
 <jsp:include page="footer.jsp" flush="false"/>
 </div>
</body>
</html>