<%@ page  contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8");
   String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FreeBoard_delete_ok.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<div>
	정말 삭제 하시겠습니까?<br><br>
	<input type="button" value="예" id="yes" name="yes" onclick="window.close()">
	<input type="button" value="아니오" id="no" name="no" onclick="window.close()">
</div>

</body>	
</html>