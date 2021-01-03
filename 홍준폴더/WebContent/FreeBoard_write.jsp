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
<!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.css">
    <link href="css/bootstrap.min.css">
    <title>Mypage_evaluationComplete</title>
    <script src="https://kit.fontawesome.com/5cdf4f755d.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/style.css">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/create.css">    
<style type="text/css">

#BoardType {
	float: left;
	padding-left: 20px;
	padding-top: 100px;
	width: 150px;
	margin: 30px auto;
	text-align: left;
	font-weight: bold;
}

</style>  
</head>
<body>
<div class="wrapper">
 <jsp:include page="header.jsp" flush="false"/>
 <div class="main-content text-center"><br>
   
     <table id="bbs" style="width: 100%; height: 100%" class="table table-bordered">
		<tr>
			<td>
				<div id="BoardType">
					<ul>
						<li><a>세미나 및 공모전</a></li>
						<li><a>IT기술정보공유</a></li>
						<li><a>Q&A</a></li>
						<li><a>자유게시판</a></li>
						<li><a>면접/코딩테스트 후기</a></li>
						<li><a>스터디 후기</a></li>
					</ul>
				</div>
				<!-- #BoardType -->
			</td>
			
			<td colspan="2">
				<div id="BoardMenu">
					<a>홈</a> > <a>정보공유게시판</a> > <a>자유게시판</a> > <a>글 작성페이지</a>

				</div>



				<div id="bbs_title">자 유 게 시 판</div>

				<form action="" method="post" name="myForm" role="form">

					<div id="bbsCreated">

						<div class="bbsCreated_bottomLine">
							<dl>
								<dt>제&nbsp;&nbsp;&nbsp;&nbsp;목</dt>
								<dd>
									<input type="text" name="subject" size="74" maxlength="100"
										class="form-control" placeholder="제목을 입력하세요" required="required">
								</dd>
							</dl>
						</div>
						<!-- bbsCreated_bottomLine -->
						
						<div class="bbsCreated_bottomLine">
							<dl>
								<dt>말&nbsp;&nbsp;머&nbsp;&nbsp;리</dt>
								<dd>
									<select name="searchCategory" class="form-control" required="required">
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
								</dd>
							</dl>
						</div>

						<div id="bbsCreated_content" class="form-floating">
							<dl>
								<dt>내&nbsp;&nbsp;&nbsp;&nbsp;용</dt>
								<dd>
									<textarea class="form-control" placeholder="내용을 입력하세요" id="floatingTextarea" style="height: 170px;" required="required"></textarea>
 									 <label for="floatingTextarea"></label>
								</dd>
							</dl>
						</div>
						<!-- #bbsCreated_content -->


						<div id="bbsCreated_footer" class= "div">
							<input type="submit" value="게시물등록" class="btn btn-outline-primary"
								onclick="sendIt()"> 
							<input type="reset" value="전체삭제"
								class="btn btn-outline-primary" onclick="document.myForm.subject.focus()">
							<input type="button" value="작성취소" class="btn btn-outline-primary"
								onclick="javascript:location.href='<%=cp%>/List.jsp'">
						</div>
						<!-- #bbsCreated_footer -->



					</div>
					<!-- #bbsCreated -->

				</form>
			</td>
		</tr>
		
	</table>
   
  </div>
 <jsp:include page="footer.jsp" flush="false"/>
 </div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
</body>
</html>