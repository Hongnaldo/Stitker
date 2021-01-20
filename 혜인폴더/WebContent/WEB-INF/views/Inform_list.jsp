<%@page import="javax.sql.DataSource"%>
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
<title>IT기술정보공유</title>

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/list.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp %>/js/util.js"></script>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.css">
<link href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/style.css">
<script src="https://kit.fontawesome.com/5cdf4f755d.js" crossorigin="anonymous"></script>
<style type="text/css">

#table2 th{text-align: center;}
#table2 th:nth-child(1){width: 50px;}
#table2 th:nth-child(2){width: 140px;}
#table2 th:nth-child(3){width: 330px;}
#table2 th:nth-child(4){width: 60px;}
#table2 th:nth-child(5){width: 100px;}
#table2 th:nth-child(6){width: 60px;}
#table2 th:nth-child(7){width: 60px;}

#table2 td{text-align: center;}
#table2 td:nth-child(3){text-align: left;}


</style>
<script type="text/javascript">

	function sendIt()
	{
		//alert("호출");
		
		f = document.myForm;
	
		// 검색어 입력 확인
		str = f.searchValue.value;
		str = str.trim();
		
		if(!str)
		{
			alert("\n검색어를 입력하세요");
			f.searchValue.focus();
			return; 
		} 
	}
	
	$(document).ready(function()
	{
		$('#write').click(function()
		{ 
			var url = "informinsertform.action";    //팝업창에 출력될 페이지 URL 
			location.href = url; 
		});

	
	});

</script>
   
</head>
<body>
<div class="wrapper">
 <jsp:include page="header.jsp" flush="false"/>
 <div class="main-content text-center"><br>
 
	<!-- <div class="menu">
	<br> 
		<h1 class="text-center">정보공유</h1>
		<br><br><br>
		<nav>
			<ul>
				<li><a href="informlist.action" class="selected">IT기술정보공유</a></li>
				<li><a href="Board_seminar_list.jsp">세미나 및 공모전</a></li>
				<li><a href="Board_interview_list.jsp">면접/코딩테스트 후기</a></li>
				<li><a href="Board_free_list.jsp">자유게시판</a></li>
				<li><a href="Board_Q&A_list.jsp">Q&A</a></li>
				<li><a href="Board_studyReview_list.jsp">스터디 후기</a></li>
			</ul>
		</nav>
	</div> -->
	
	<!--  메뉴 구성 영역 -->
   <div>
   <c:import url="BoardMenu.jsp"></c:import>
   </div>
   	
	
	<div class="main">
		
		<form action="informinsert.action" method="post" name="myForm">
		<table id="table1" class="table">
			<tr>
				<td>
					<select name="searchKey" id="searchKey" class="form-control">
						<option value="all">전체</option>
						<option value="title">제목</option>
						<option value="name">작성자</option>
						<option value="content">내용</option>
						<option value="titlecontent">제목+내용</option>
					</select>
					<select name="searchCategory" id="searchCategory" class="form-control">
						<!-- <option value="all">전체</option>
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
						<option value="edu">교육</option> -->
						<option value="">전체</option>
						 <c:forEach var="interest" items="${imList }">
							 <option value="${interest.interest_mc_code }">
							 	${interest.interest_mc }
						 </c:forEach>
					</select>
					<input type="text" name="searchValue" id="searchValue" class="form-control"
					placeholder="검색어를 입력하세요." style="width: 200px;">
					  <button class="btn btn-default" 
					  type="button" id="searchSort" data-bs-toggle="dropdown" aria-expanded="false">
					 	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-down-up" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M11.5 15a.5.5 0 0 0 .5-.5V2.707l3.146 3.147a.5.5 0 0 0 .708-.708l-4-4a.5.5 0 0 0-.708 0l-4 4a.5.5 0 1 0 .708.708L11 2.707V14.5a.5.5 0 0 0 .5.5zm-7-14a.5.5 0 0 1 .5.5v11.793l3.146-3.147a.5.5 0 0 1 .708.708l-4 4a.5.5 0 0 1-.708 0l-4-4a.5.5 0 0 1 .708-.708L4 13.293V1.5a.5.5 0 0 1 .5-.5z"/>
</svg>
					  </button>
					  <ul class="dropdown-menu" aria-labelledby="searchSort">
					    <li><a class="dropdown-item" href="#">등록일순</a></li>
					    <li><a class="dropdown-item" href="#">조회순</a></li>
					    <li><a class="dropdown-item" href="#">추천순</a></li>
					  </ul>
					<input type="button" value="검색" id="searchBtn" 
					class="btn btn-outline-primary btn-sm">	
				</td>
			</tr>
		</table>
		
		<table id="table2" class="table table-striped table-hover" >
			<tr>
				<th>번호</th>
				<th>말머리</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
				<th>추천수</th>
			</tr>
			
 			<c:forEach var="inform" items="${list }">
				<tr>
					<td>${inform.post_num }</td>
					<td>${inform.interest_mc}</td>
					<td><a href="informdetail.action?post_code=${inform.post_code}">${inform.title}</a></td>
					<td>${inform.user_name}</td>
					<td>${inform.write_date }</td>
					<td>${inform.hitcount}</td>
					<td>${inform.rec }</td>
				</tr>
			</c:forEach>  
			
		</table>
		
		<div id=btnSet>
			<input type="button" value="글쓰기" class="btn btn-primary" id="write">
			<input type="button" value="새로고침" class="btn btn-primary" >	
		</div>
		
		<div id="footer">
		
			<!-- <p> 1 Prev 21 22 23 24 25 26 27 28 29 30 Next 90 </p> -->
			 <div class="paginate">
                <div class="paging">
                    <a class="direction prev">
                        &lt;&lt;
                    </a>
                    <a class="direction prev">
                        &lt;
                    </a>
 
                    <a>1</a>
                    <a class="direction next">
                        &gt;
                    </a>
                    <a class="direction next">
                        &gt;&gt;
                    </a>
                </div>
            </div>
            <!-- /paginate -->

		</div><!-- #footer -->
		</form>
	</div>	
	
		
	

	
   
  </div>
  
 <jsp:include page="footer.jsp" flush="false"/>
 </div>
 
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
</body>
</html>