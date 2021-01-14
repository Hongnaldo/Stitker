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
<script src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">


		
		$(document).ready(function()
		{
			$("#delete").click(function()
			{
				var result = confirm("정말 삭제 하시겠습니까?");
				
				if(result)
				{
					location.replace("FreeBoard_write.jsp");
				}
			});
		});
	
</script>
</head>
<body>
<div>
	<input type="button" value="삭제하기" id="delete">
</div>
</body>	
</html>