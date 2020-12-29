<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FreeBoard_write.jsp</title>

<script type="text/javascript" src="<%=cp%>/js/util.js"></script>

<script type="text/javascript">

	function sendIt()
	{
		//alert("호출");
		
		f = document.myForm;
		
		// 제목 입력 확인 -------------------------------------
		str = f.subject.value;
		str = str.trim();
		
		// ※ javascript 에는 trim() 이 존재하지 않음.
		//    외부에서 참조한 util.js 에 만들어두었음.
		
		// 테스트
		//alert("|" + str + "|");
		
		if(!str)
		{
			alert("\n제목을 입력하세요~!!!");
			f.subject.focus();
			return;
		}
		
		// ------------------------------------- 제목 입력 확인
		

		
		
		// 패스워드 입력 확인 -------------------------------------
		str = f.pwd.value;
		str = str.trim();
		if(!str)
		{
			alert("\n패스워드를 입력하세요~!!!");
			f.pwd.focus();
			return;
		}
		// ------------------------------------- 패스워드 입력 확인 
	
		f.action = "<%=cp%>/Create_ok.jsp";
		f.submit();

	}
</script>
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

#BoardType a {
	font-size: 10pt;
	font-weight: bold;
}

#BoardType li {
	font-size: 10pt;
	border-bottom: 1px solid;
	padding-top: 10px;
	padding-bottom: 10px;
}
#BoardBottom{
	text-align: left;
}
a {
	cursor: pointer;
	color: #000000;
	text-decoration: none;
	font-size: 9pt;
	line-height: 150%;
}

a:hover, a:active {
	font-size: 9pt;
	color: #8000ff;
	text-decoration: underline;
}

ul {
	list-style: none;
}
#bbs_title
{
	width: 574px;
	padding-left: 20px;
	height: 40px;
	border: 3px solid black;
	text-align: left;
	font-weight: bold;
	line-height: 40px;
	font-size: 10pt;
	margin-bottom: 30px;
}
</style>
</head>
<body>

	<table id="bbs" style="width: 100%; height: 100%">
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
					<a>홈</a> > <a>정보공유게시판</a> > <a>자유게시판</a> > <a>글 수정페이지</a>

				</div>



				<div id="bbs_title">자 유 게 시 판</div>

				<form action="" method="post" name="myForm">

					<div id="bbsCreated">

						<div class="bbsCreated_bottomLine">
							<dl>
								<dt>제&nbsp;&nbsp;&nbsp;&nbsp;목</dt>
								<dd>
									<input type="text" name="subject" size="74" maxlength="100"
										class="boxTF" value="글의 수정전 제목이 나와야됨">
								</dd>
							</dl>
						</div>
						<!-- bbsCreated_bottomLine -->

						<div class="bbsCreated_bottomLine">
							<dl>
								<dt>말&nbsp;&nbsp;&nbsp;&nbsp;머&nbsp;&nbsp;&nbsp;&nbsp;리</dt>
								<dd>
									<select name="searchCategory" class="selectFiled">
										<option value="all">전체</option>
										<option value="dba" selected="selected">DBA/데이터베이스</option>
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

						<div id="bbsCreated_content">
							<dl>
								<dt>내&nbsp;&nbsp;&nbsp;&nbsp;용</dt>
								<dd>
									<textarea rows="12" cols="63" name="content" class="boxTA">글의 수정전 내용이 나와야됨 ㅎㅎ</textarea>
								</dd>
							</dl>
						</div>
						<!-- #bbsCreated_content -->

						<div id="bbsCreated_noLine">
							<dl>
								<dt>패스워드</dt>
								<dd>
									<input type="password" name="pwd" size="35" maxlength="10"
										class="boxTF"> &nbsp;<span style="font-size: 7pt;"></span>
								</dd>
							</dl>
						</div>
						<!-- #bbsCreated_noLine -->

						<div id="bbsCreated_footer">
							<input type="button" value="게시물수정" class="btn2"
								onclick="sendIt()"> <input type="reset" value="전체삭제"
								class="btn2" onclick="document.myForm.subject.focus()">
							<input type="button" value="수정취소" class="btn2"
								onclick="javascript:location.href='<%=cp%>/List.jsp'">
						</div>
						<!-- #bbsCreated_footer -->



					</div>
					<!-- #bbsCreated -->

				</form>
			</td>
		</tr>
		<tr>
			<td>
				
			<td>
			<td id="BoardBottom">
				개인정보이용약관 | 고객센터전화번호:070-8435-6825 | 오시는길 : 서울시 마포구 가마산로 18길
			</td>
		</tr>
	</table>
	<!-- #bbs -->

</body>
</html>