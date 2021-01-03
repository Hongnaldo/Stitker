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
<title>Main.jsp</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/style.css">
<script src="http://code.jquery.com/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/5cdf4f755d.js"></script>

<%-- <link rel="stylesheet" href="<%= cp %>/css/mainpage.css" /> --%>
<style type="text/css">
.content_Table {
	display: table;
	margin: 0px auto;
}

.content_Row {
	display: table-row;
}

.content_Cell {
	display: table-cell;
	/* vertical-align: middle; */
	/* margin: 20%; */
	/* text-align: center; */
	width: 350px;
	text-align: center;
}

.content_TableBody {
	display: table-row-group;
}

h5>span {
	color: blue;
	font-weight: bold;
}

.btn {
	font-size: 9pt;
}
small
{
	font-size: 10pt;
}
#cell1
{
	text-align: left;
		padding-left: 15px;
}
</style>
</head>
<body>
	<div class="wrapper">
		<jsp:include page="header.jsp" flush="false" />
		<div class="main-content">
			<br>
			<br>
			<div class="mainpage">


				<!-- 스터딧 장점 -->
				<div class="content_Table">
					<div class="content_TableBody">
						<div class="content_Row">
							<div class="content_Cell" id="cell1">

								<h5>
									<span>스터딧</span><small> 어떤 점이 좋나요?</small>
								</h5>
							</div>
							<div class="content_Cell"></div>
							<div class="content_Cell"></div>
						</div>
						<div class="content_Row">
							<div class="content_Cell">
								신뢰성<br> (그림)<br /> <span>노쇼 걱정 이제 그만!<br>믿음이
									가는 스터디
								</span>
							</div>
							<div class="content_Cell">
								맞춤형<br> (그림)<br> <span>관심분야를 설정할 수 있어요<br>
									내게 딱 맞는 스터디를 찾아보세요!
								</span>
							</div>
							<div class="content_Cell">
								유용성<br> (그림)<br> <span>정보공유/커뮤니티 게시판<br>
									유용한 정보들을 공유해보세요!
								</span>
							</div>
						</div>
					</div>
					<!-- content_TableBody -->
				</div>
				<!-- content_Table -->
			</div>

			<br />
			<br />

			<!-- 스터디 후기 -->
			<div class="content_Table">
				<div class="content_TableBody">
					<div class="content_Row">
						<div class="content_Cell" id="cell1">
							<h5>
								<span>스터딧</span><small> 에서의 모임은 어땠나요?</small>
							</h5>
						</div>
						<div class="content_Cell"></div>
						<div class="content_Cell">
							<button class="btn btn-outline-primary">
								전체 보기 <span class="btnTxt">></span>
							</button>
						</div>
					</div>
					<div class="content_Row">
						<div class="content_Cell">
							제목1<br> <br> (작성자 프사)<br> <br> <span>간략한
								내용</span>
						</div>
						<div class="content_Cell">
							제목2<br> <br> (작성자 프사)<br> <br> <span>간략한
								내용</span>
						</div>
						<div class="content_Cell">
							제목3<br> <br> (작성자 프사)<br> <br> <span>간략한
								내용</span>
						</div>
					</div>
				</div>
				<!-- content_TableBody -->
			</div>
			<!-- content_Table -->

			<br />
			<br />

			<!-- 스터디 후기 -->
			<div class="content_Table">
				<div class="content_TableBody">
					<div class="content_Row">
						<div class="content_Cell" id="cell1">
							<h5>
								<span>스터딧</span><small> 정보공유게시판</small>
							</h5>
						</div>
						<div class="content_Cell"></div>
						<div class="content_Cell">
							<button class="btn btn-outline-primary">
								전체 보기 <span class="btnTxt">></span>
							</button>
						</div>
					</div>
					<div class="content_Row">
						<div class="content_Cell">
							제목1<br> <span>간략한</span><br> <span>내용</span>
						</div>
						<div class="content_Cell">
							제목2<br> <span>간략한</span><br> <span>내용</span>
						</div>
						<div class="content_Cell">
							제목3<br> <span>간략한</span><br> <span>내용</span>
						</div>
					</div>
				</div>
				<!-- content_TableBody -->
			</div>
			<!-- content_Table -->

			<br />
			<br />

			<div class="footer2" style="background-color: #ccc; width: 500px;">
				<div class="content_Table">
					<div class="content_TableBody">
						<div class="content_Row">
							<div class="content_Cell">
								누적 스터디 멤버<br> <span>6 명</span>
							</div>
							<div class="content_Cell">
								현재까지 개설된 스터디<br> <span>1 개</span><br>
							</div>
							<div class="content_Cell">
								평균 만족도<br> <span>5/5 점</span><br>
							</div>
						</div>
					</div>
					<!-- content_TableBody -->
				</div>
				<!-- content_Table -->
			</div>


		</div>
		<jsp:include page="footer.jsp" flush="false" />
	</div>
</body>
</html>