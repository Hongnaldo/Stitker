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
        window.open("FreeBoard_delete_ok.jsp", "new", "toolbar=no, menubar=no, scrollbars=no, resizable=no, width=200, height=200, left=0, top=0" );
    }
	
</script>
</head>
<body>
<div>
	<input type="button" value="삭제하기" onclick="openPopup()">
</div>
</body>	
</html>