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
<title>자유게시판</title>

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/list.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp %>/js/util.js"></script>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/bootstrap.min.css">

<title>Mypage_evaluationComplete</title>
<script src="https://kit.fontawesome.com/5cdf4f755d.js" crossorigin="anonymous"></script>
<style type="text/css">

#table2 th{text-align: center;}
#table2 th:nth-child(1){width: 50px;}
#table2 th:nth-child(2){width: 460px;}
#table2 th:nth-child(3){width: 100px;}
#table2 th:nth-child(4){width: 100px;}
#table2 th:nth-child(5){width: 55px;}
#table2 th:nth-child(6){width: 55px;}

#table2 td{text-align: center;}
#table2 td:nth-child(2){text-align: left;}

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


</script>
   
</head>
<body>
<div class="wrapper">
 <jsp:include page="header.jsp" flush="false"/>
 <div class="main-content text-center"><br>
 
	<div class="menu">
	<br> 
		<h1 class="text-center">정보공유</h1>
		<br><br><br>
		<nav>
			<ul>
				<li><a href="Board_inform_list.jsp">IT기술정보공유</a></li>
				<li><a href="Board_seminar_list.jsp">세미나 및 공모전</a></li>
				<li><a href="Board_interview_list.jsp">면접/코딩테스트 후기</a></li>
				<li><a href="Board_free_list.jsp" class="selected">자유게시판</a></li>
				<li><a href="Board_Q&A_list.jsp">Q&A</a></li>
				<li><a href="Board_studyReview_list.jsp">스터디 후기</a></li>
			</ul>
		</nav>
	</div>

	<div class="main">
		<form action="" name="myForm">
		<table id="table1" class="table">
			<tr>
				<td>
					<select name="searchKey" id="searchKeyFree" class="form-control">
						<option value="all">전체</option>
						<option value="title">제목</option>
						<option value="name">작성자</option>
						<option value="content">내용</option>
						<option value="titlecontent">제목+내용</option>
					</select>
					<input type="text" name="searchValue" id="searchValueFree" class="form-control"
					placeholder="검색어를 입력하세요.">
					  <button class="btn btn-default" 
					  type="button" id="searchSort" data-bs-toggle="dropdown" aria-expanded="false">
					 	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-down-up" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M11.5 15a.5.5 0 0 0 .5-.5V2.707l3.146 3.147a.5.5 0 0 0 .708-.708l-4-4a.5.5 0 0 0-.708 0l-4 4a.5.5 0 1 0 .708.708L11 2.707V14.5a.5.5 0 0 0 .5.5zm-7-14a.5.5 0 0 1 .5.5v11.793l3.146-3.147a.5.5 0 0 1 .708.708l-4 4a.5.5 0 0 1-.708 0l-4-4a.5.5 0 0 1 .708-.708L4 13.293V1.5a.5.5 0 0 1 .5-.5z"/>
</svg>
					  </button>
					  <ul class="dropdown-menu" aria-labelledby="searchSortFree">
					    <li><a class="dropdown-item" href="#">등록일순</a></li>
					    <li><a class="dropdown-item" href="#">조회순</a></li>
					    <li><a class="dropdown-item" href="#">추천순</a></li>
					  </ul>
					<input type="button" value="검색" id="searchBtnFree" class="btn btn-outline-primary btn-sm"
					>	
				</td>
			</tr>
		</table>
		
		<table id="table2" class="table table-striped table-hover">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
				<th>추천수</th>
			</tr>
			<tr>
				<td>5</td>
				<td>게시판 테스트입니다.</td>
				<td>이진주</td>
				<td>2020-10-12</td>
				<td>22</td>
				<td>22</td>
			</tr>
			<tr>
				<td>5</td>
				<td>게시판 테스트입니다.</td>
				<td>이진주</td>
				<td>2020-10-12</td>
				<td>22</td>
				<td>22</td>
			</tr>
			<tr>
				<td>5</td>
				<td>게시판 테스트입니다.</td>
				<td>이진주</td>
				<td>2020-10-12</td>
				<td>22</td>
				<td>22</td>
			</tr>
			<tr>
				<td>5</td>
				<td>게시판 테스트입니다.</td>
				<td>이진주</td>
				<td>2020-10-12</td>
				<td>22</td>
				<td>22</td>
			</tr>
			<tr>
				<td>5</td>
				<td>게시판 테스트입니다.</td>
				<td>이진주</td>
				<td>2020-10-12</td>
				<td>22</td>
				<td>22</td>
			</tr>
			<tr>
				<td>5</td>
				<td>게시판 테스트입니다.</td>
				<td>이진주</td>
				<td>2020-10-12</td>
				<td>22</td>
				<td>22</td>
			</tr>
			<tr>
				<td>5</td>
				<td>게시판 테스트입니다.</td>
				<td>이진주</td>
				<td>2020-10-12</td>
				<td>22</td>
				<td>22</td>
			</tr>
			<tr>
				<td>5</td>
				<td>게시판 테스트입니다.</td>
				<td>이진주</td>
				<td>2020-10-12</td>
				<td>22</td>
				<td>22</td>
			</tr>
			<tr>
				<td>5</td>
				<td>게시판 테스트입니다.</td>
				<td>이진주</td>
				<td>2020-10-12</td>
				<td>22</td>
				<td>22</td>
			</tr>
			<tr>
				<td>5</td>
				<td>게시판 테스트입니다.</td>
				<td>이진주</td>
				<td>2020-10-12</td>
				<td>22</td>
				<td>22</td>
			</tr>
			<tr>
				<td>5</td>
				<td>게시판 테스트입니다.</td>
				<td>이진주</td>
				<td>2020-10-12</td>
				<td>22</td>
				<td>22</td>
			</tr>
			<tr>
				<td>5</td>
				<td>게시판 테스트입니다.</td>
				<td>이진주</td>
				<td>2020-10-12</td>
				<td>22</td>
				<td>22</td>
			</tr>
			<tr>
				<td>5</td>
				<td>게시판 테스트입니다.</td>
				<td>이진주</td>
				<td>2020-10-12</td>
				<td>22</td>
				<td>22</td>
			</tr>
			<tr>
				<td>5</td>
				<td>게시판 테스트입니다.</td>
				<td>이진주</td>
				<td>2020-10-12</td>
				<td>22</td>
				<td>22</td>
			</tr>	
		</table>
		
		<div id=btnSet>
			<input type="button" value="글쓰기" class="btn btn-primary">
			<input type="button" value="새로고침" class="btn btn-primary" >	
		</div>
		
		</form>
		
		<div id="footer">
		
			<p> 1 Prev 21 22 23 24 25 26 27 28 29 30 Next 90 </p>

		</div><!-- #footer -->
	
	</div><!-- .main -->
	
		

	
   
  </div>
  
 <jsp:include page="footer.jsp" flush="false"/>
 </div>
 
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
</body>
</html>