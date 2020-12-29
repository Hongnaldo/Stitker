<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String cp = request.getContextPath(); %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Support_notice_write.jsp</title>
<script type="text/javascript" src="<%=cp %>/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>

<style type="text/css">
	.title {height: 50px; font-size: 18pt;}
	.all {display: table; margin-left: auto; margin-right: auto;}
	.title { width: 1000px;}
	button {width: 20px;} 
</style>
</head>
<body>

<h1>공지사항-작성하기</h1>
<br><br><br>
<div class="all">
	<input type="text" class="title" placeholder="제목을 입력하세요">
	<br><br>

	<textarea name="ir1" id="ir1" rows="10" cols="100">에디터에 기본으로 삽입할 글(수정 모드)이 없다면 이 value 값을 지정하지 않으시면 됩니다.</textarea>
</div>	
</body>

<script type="text/javascript">

	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
	 oAppRef: oEditors,
	 elPlaceHolder: "ir1",
	 sSkinURI: "./se2/SmartEditor2Skin.html",
	 fCreator: "createSEditor2"
	});	

</script>
</html>

