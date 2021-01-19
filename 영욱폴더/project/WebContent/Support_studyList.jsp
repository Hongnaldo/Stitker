<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Study_list.jsp</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<script src="https://kit.fontawesome.com/5cdf4f755d.js" crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>





<!-- 직접 설정한 CSS -->
<link rel="stylesheet" href="css/sumin/Layout.css">






</head>
<body>

<div class="wrapper">
	<jsp:include page="header.jsp" flush="false"/>
	<div class="main-content">
		<div class="menu">
		<br><br>
			<h1 class="text-center">고객센터</h1>
			<br><br><br>
			<nav>
				<ul>
					<li><a href="Support_notice_list.jsp">공지사항</a></li>
					<li><a href="Support_Q&A_list.jsp"  class="selected">1:1문의</a></li>
				</ul>
			</nav>
		</div>

		<div class="content">	
			<br>	
			<a href="Support_Q&A_register.jsp" class="btn btn-outline-primary">글 작성하기</a>
			<br><br>
			<div class="tableDiv">
				
				<table class="table table-hover">
					<thead>
					<tr class="category">
						<td>
							<select>
								<option selected value="">키워드 검색</option>
								<option value="">스터디이름</option>
								<option value="">스터디 리더 아이디/닉네임</option>
								<option value="">스터디번호(게시물 식별자)</option>
							</select>
					    </td>
						<td><input type="text" name="search"></td>
					</tr>
					<tr>
						<td>카테고리 선택</td>
					</tr>
					<tr>
						<td>
							<select>
								<option selected value="">지역 선택</option>
								<optgroup label="서울-구">
									<option value="s1"></option>
								</optgroup>
								<optgroup label="경기-시 ">
									<option value=""></option>
								</optgroup>
								<optgroup label="나머지 도">
									<option value=""></option>
								</optgroup>
								<optgroup label="광역시 ">
									<option value=""></option>
								</optgroup>
								<optgroup label="온라인 ">
									<option value=""></option>
								</optgroup>
							</select>
						</td>
						<td></td>
						<td >
							<select>
								<option value="" selected>스터디 대분류</option>
								<option value=""></option>
							</select>
						</td>
						<td>
							<select>
								<option value="" selected>스터디 중분류</option>
								<option value=""></option>
							</select>
						</td>
						<td>
							<select>
								<option value="" selected>스터디 리더 등급</option>
								<option value=""></option>
							</select>
						</td>
						
						<td>
							<select>
								<option value="" selected>요일</option>
								<option value="">월</option>
								<option value="">화</option>
								<option value="">수</option>
								<option value="">목</option>
								<option value="">금</option>
								<option value="">토</option>
								<option value="">일</option>
							</select>
						<td>
						
						<td>
							<select>
								<option value="" selected>상태</option>
								<option value="">모집중</option>
								<option value="">마감</option>
								<option value="">진행중</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>정렬방법</td>
						<td>
							<select>
								<option value="" selected>정렬방법</option>
								<option value="">등록순</option>
								<option value="">마감임박순-기간</option>
								<option value="">마감임박순-인원</option>
							</select>
						</td>
						<td>
							<select>
								<option value="" selected>오름차순</option>
								<option value="">내림차순</option>
							</select>
						<td>	
					</tr>
					<tr class="first">
						<th>번호</th>
						<th>스터디명</th>
						<th>스터디리더</th>
						<th>스터디리더등급</th>
						<th>기간</th>
						<th>요일</th>
						<th>지역</th>
						<th>상태</th>
						
					</tr>
					</thead>
					<tr >
						<td>예시)1</td>
						<td>예시)스터디관련질문입니다.</td>
						<td>예시)2020/12/26</td>
						<td>예시)답변완료</td>
						<td>예시</td>
						<td>예시</td>
						<td>예시</td>
						<td>예시</td>
					</tr>
					<tr onclick="window.location.href='Study_studyDetail.jsp'">
						<td>예시</td>
						<td>예시</td>
						<td>예시</td>
						<td>예시</td>
						<td>예시</td>
						<td>예시</td>
						<td>예시</td>
						<td>예시</td>
					</tr>
				</table>
			</div>
			<br>
			<div class="page">페이징처리필요 1 2 3 4 5 6 7 8 9 10 > >></div>
		</div>	
	</div>
	<jsp:include page="footer.jsp" flush="false"/>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
		
</body>
</html>