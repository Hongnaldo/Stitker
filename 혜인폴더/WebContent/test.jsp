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
<title></title>
<!-- 스터디 개설 페이지 css -->
<style type="text/css">
	#sunTime{display: none;}
	#monTime{display: none;}
	#tueTime{display: none;}
	#wedTime{display: none;}
	#thuTime{display: none;}
	#friTime{display: none;}
	#satTime{display: none;}



	
</style>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/list.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp %>/js/util.js"></script>

<!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.css">
    <link href="css/bootstrap.min.css">
    <title>Mypage_evaluationComplete</title>
    <script src="https://kit.fontawesome.com/5cdf4f755d.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="wrapper">
 <jsp:include page="header.jsp" flush="false"/>
 <div class="main-content text-center"><br>
   
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
	<a>홈</a> > <a>정보공유게시판</a> > <a>자유게시판</a>

</div>

<div id="BoardList">
	<div id="BoardList_title">
		자유게시판
	</div><!-- #BoardList_title -->

	<div id="BoardList_header">
		<div id="leftHeader">
			<form action="" name="searchForm" method="post">
				<select name="searchKey" class="selectFiled">
					<option value="all">전체</option>
					<option value="title">제목</option>
					<option value="name">작성자</option>
					<option value="content">내용</option>
					<option value="titlecontent">제목+내용</option>
				</select>
				
				<select name="searchCategory" class="selectFiled">
					<option value="all">전체</option>
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
				<input type="text" name="searchValue" class="textField" />
				<select name="searchSort" class="selectFiled">
					<option value="date">등록일순</option>
					<option value="hitCount">조회순</option>
					<option value="likeCount">추천순</option>
				</select>
				<input type="button" value="검색" class="btn">
			</form>		
		</div><!-- #leftHeader -->
		
		<div id="rightHeader">
			<!-- event -->
			<input type="button" value="글올리기" class="btn">
			
		</div><!-- #rightHeader -->
		
		
	</div><!-- #BoardList_header -->
	
	<div id="BoardList_list">
		<div id="head">
			<dl>
				<dt class="num">번호</dt>
				<dt class="subject">말머리</dt>
				<dt class="title">제목</dt>
				<dt class="name">작성자</dt>
				<dt class="created">작성일</dt>
				<dt class="likeCount">추천수</dt>
				<dt class="hitCount">조회수</dt>
			</dl>
		</div><!-- #head -->
		
		<div id="lists">
			<dl>
				<dd class="num">1</dd>
				<dd class="subject">ERP/시스템분석/설계</dd>
				<dd class="title">안녕하세요</dd>
				<dd class="name">박혜인</dd>
				<dd class="created">2020-12-25</dd>
				<dd class="likeCount">0</dd>
				<dd class="hitCount">0</dd>
			</dl>
			<dl>
				<dd class="num">2</dd>
				<dd class="subject">개발자</dd>
				<dd class="title">안녕하세요</dd>
				<dd class="name">허수민</dd>
				<dd class="created">2020-12-25</dd>
				<dd class="likeCount">0</dd>
				<dd class="hitCount">0</dd>
			</dl>
			
		</div><!-- #lists -->
		
		<div id="footer">
		
			<p> 1 Prev 21 22 23 24 25 26 27 28 29 30 Next 90 </p>

		</div><!-- #footer -->
	
	</div><!-- #BoardList_list -->
	
</div><!-- #BoardList -->
   
  </div>
 <jsp:include page="footer.jsp" flush="false"/>
 </div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
</body>
</html>