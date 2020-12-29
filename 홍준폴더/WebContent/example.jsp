<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Aticle.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/detailpage.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/article.css">
</head>
<body>

<div id=bbs>
	<div id="bbs_title">
		게 시 판 (JDBC 연동 버전)
	</div><!-- #bbs_title -->
	
	<div id="bbsArticle">
	
		<div id="bbsArticle_header">
			안녕하세요
		</div><!-- #bbsArticle_header -->
		
		<div class="bbsArticle_bottomLine">
			<dl>
				<dt>작성자</dt>
				<dd>박혜인</dd>
				<dt>말머리</dt>
				<dd>개발자</dd>
			</dl>
		</div><!-- .bbsArticle_bottomLine -->
		
		<div class="bbsArticle_bottomLine">
			<dl>
				<dt>등록일</dt>
				<dd>2020-11-30</dd>
				<dt id="hitCount">조회수</dt>
				<dd>0</dd>
				<dt id="likeCount">추천수</dt>
				<dd>0</dd>
			</dl>
		</div><!-- .bbsArticle_bottomLine -->
		
		<div id="bbsArticle_content">
			<table style="width: 600;">
				<tr>
					<td style="padding: 10px 40px 10px 10px; vertical-align: top; height: 150;">
						어쩌구 저쩌구 게시물의 내용입니다. 
					</td>
				</tr>
			</table>
		</div><!-- #bbsArticle_content-->
		
		<div class="bbsArticle_bottomLine">
			이전글 : (104) 분석 분야 게시물 -->
		</div><!-- .bbsArticle_bottomLine -->
		
		<div class="bbsArticle_noLine">
			 다음글 : (106) 분석 분야 게시물
		</div><!-- .bbsArticle_noLine -->
			
	</div><!-- #bbsArticle -->
	
	<div class="bbsArticle_noLine" style="text-align: right;">
		From : 211.238.142.154 
	</div><!-- .bbsArticle_noLine -->
	
	<div id="bbsArticle_footer">
	
		<div id="leftFooter">
			<!-- event -->
			<input type="button" value="수정" class="btn2">
			<input type="button" value="삭제" class="btn2">
		</div><!-- #leftFooter -->
		
		<div id="rightFooter">
			<!-- event -->
			<input type="button" value="리스트" class="btn2"">
		</div><!-- #rightFooter -->
		
	</div><!-- #bbsArticle_footer -->
	
	

</div><!-- #bbs -->


</body>
</html>