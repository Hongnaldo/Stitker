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
<title>StudyReview_write.jsp</title>
<link rel="stylesheet" type="text/css" href="css/boardwrite.css">
</head>
<body>

<div id="BoardType">
		<ul>
			<li>
				<a>세미나 및 공모전</a>
			</li>
			<li>
				<a>IT기술정보공유</a>
			</li>
			<li>
				<a>Q&A</a>
			</li>
			<li>
				<a>자유게시판</a>
			</li>
			<li>
				<a>면접/코딩테스트 후기</a>
			</li>
			<li>
				<a>스터디 후기</a>
			</li>
		</ul>
</div><!-- #BoardType -->

<div id="BoardMenu">
	<a>홈</a> > <a>정보공유게시판</a> > <a>스터디 후기</a>

</div>

<div id="BoardWrite">
	
	<div id="BoardWrite_title">
		스터디 후기 작성
	</div><!-- #BoardWrite_title -->
	
	<form action="" method="post" name=myForm>
		
		<div id="BoardWriteCreated">
			<div class="BoardWriteCreated_bottonLine">
				<dl>
					<dt>말 머 리</dt>
					<dd>
						<select name="category" class="selectFiled">
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
					</dd>
				</dl>			
			</div><!-- .BoardWriteCreated_bottomLine -->
			
			<div class="BoardWriteCreated_bottomLine">
				<dl>
					<dt>제&nbsp;&nbsp;&nbsp;&nbsp;목</dt>
					<dd>
						<input type="text" name="subject" size="70"
						maxlength="100" class="boxTF">
					</dd>
				</dl>	
			</div><!-- .BoardWriteCreated_bottomLine -->
			
			
			<div id="BoardWriteCreated_content">
				<dl>
					<dt>내&nbsp;&nbsp;&nbsp;&nbsp;용</dt>
					<dd>
						<textarea name="content" cols="63" rows="15" 
						class="boxTA"></textarea>
					</dd>
				</dl>
			</div><!-- #BoardWriteCreated_content -->
			
			<div class="BoardWriteCreated_noLine">
				<dl>
					<dt>패스워드</dt>
					<dd>
						<input type="password" name="pwd" size="35"
						maxlength="10" class="boxTF" />
						&nbsp;<span style="font-size: 7pt;">(게시물 수정 및 삭제 시 필요)</span>
					</dd>
				</dl>
			</div><!-- .BoardWriteCreated_noLine -->	
		</div><!-- #BoardWriteCreated -->
	</form>

</div><!-- #BoardWrite -->

			<div id="BoardWriteCreated_footer">
				<input type="button" value="등록하기" class="btn2" onclick="sendIt()">
				<input type="reset"  value="다시입력" class="btn2" 
				onclick="document.myForm.subject.focus()">
				<input type="button"  value="작성취소" class="btn2">
			</div><!-- #BoardWriteCreated_footer -->



</body>
</html>