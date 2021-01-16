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
<title>세미나 및 공모전</title>

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/detailpage.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp %>/js/util.js"></script>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.css">
<link href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/style.css">
<title>Mypage_evaluationComplete</title>
<script src="https://kit.fontawesome.com/5cdf4f755d.js" crossorigin="anonymous"></script>
<style type="text/css">

#table2 th{text-align: center;}
#table2 th:nth-child(1){width: 100px;}
#table2 th:nth-child(2){width: 400px;}
#table2 th:nth-child(3){width: 100px; text-align: right;}


#table2 td{text-align: center;}
#table2 td:nth-child(2){text-align: left;}

</style>
<script type="text/javascript">

	$(document).ready(function() {
	    $('#commentBox').on('keyup', function() {
	        $('#commentCnt').html("("+$(this).val().length+" / 300)");
	 
	        if($(this).val().length > 300) {
	            $(this).val($(this).val().substring(0, 300));
	            $('#commentCnt').html("(300 / 300)");
	        }
	    });
	});


</script>
   
</head>
<body>
<div class="wrapper">
 <jsp:include page="header.jsp" flush="false"/>
 <div class="main-content text-center"><br>
 
 	<div id="BoardMenu">
 		<table id="tblTop">
 			<tr>
 				<td>
					<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
					  <ol class="breadcrumb">
					    <li class="breadcrumb-item"><a href="#">Home</a></li>
					    <li class="breadcrumb-item"><a href="#">정보공유게시판</a></li>
					    <li class="breadcrumb-item"><a href="#">세미나 및 공모전</a></li>
					    <li class="breadcrumb-item active" aria-current="page">어쩌구글</li>
					  </ol>
					</nav>
				</td>
			</tr>
		</table>
	</div>
	
	<br>
 	 	
 	<div id="BoardList_title">
		세미나 및 공모전
	</div><!-- #BoardList_title -->

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

	<div class="main">
		<form action="" name="myForm">
		<table id="table1" class="table">
			<tr>
				<th colspan="2">공모전</th>
				<th colspan="6" style="background-color: #ffffff;">게시판 테스트입니다.</th>
			</tr>
			<tr>
				 <th>작성자</th>
				 <td>이진주</td>
				 <th>작성일</th>
				 <td>2020-01-02</td>
				 <th>조회수</th>
				 <td>10</td>
				 <th>추천수</th>
				 <td>5</td>
			</tr>
			<tr>
				<td colspan="8" style="height: 300px;">글내용</td>
			</tr>
			<tr>
				<td colspan="8">
					<div class="BoardDetail_noLine">
						이전글 : (1) 반갑습니다
					</div><!-- .BoardDetail_noLine -->
				</td>
			</tr>
			<tr>
				<td colspan="8">
					<div class="BoardDetail_noLine">
						다음글 : (3) 개발자입니다
					</div><!-- .BoardDetail_noLine -->
				</td>
			</tr>
			<tr>
				<td colspan="4" style="border-bottom: #ffffff;">
					<input type="button" value="리스트" class="btn btn-primary btn-sm">
				</td>
				<td colspan="4" style="text-align: right; border-bottom: #ffffff;">
					<input type="button" value="신고" class="btn btn-danger btn-sm">
				</td>
			</tr>
		</table>
		<br><br>
		
			<div id="commentFooter">
				<p> 1 2 </p>
			</div><!-- #commentFooter -->
			

	</div><!-- .main -->

	</form>
   
  </div>
  
 <jsp:include page="footer.jsp" flush="false"/>
 </div>
 
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
</body>
</html>