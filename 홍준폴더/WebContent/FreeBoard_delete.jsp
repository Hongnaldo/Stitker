<%@ page  contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8");
   String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FreeBoard_delete.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<script type="text/javascript">

	
	function openPopup(){
		confirm("정말 삭제하시겠습니까?");
	}
	
</script>
</head>
<body>
<div>
	<input type="button" value="삭제하기" onclick="openPopup()">
</div>
</body>	
</html>