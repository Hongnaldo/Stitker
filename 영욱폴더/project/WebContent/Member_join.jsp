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
<title>Member_join.jsp</title>
<script src="https://kit.fontawesome.com/5cdf4f755d.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="css/style.css">

<style type="text/css">
	
	.loginBox{width:90%;}
	
</style>

<script language="javascript">

		function checkId(){
			var id=newMem.id.value;
			if(newMem.id.value==""){
				alert("ID를 입력해주세요!");
				newMen.id.focus(); return;
			}
			window.open("checkId.jsp?id="+id,"win","width=255, height=145, scrollbars=no, resizable=no");
		}


		function checkValue(){
			if(newMem.id.value==""){
				alert("ID를 입력해주세요!");
				newMem.id.focus(); return;
			}
			if(newMem.pwd.value==""){
				alert("비밀번호를 입력해주세요!");
				newMem.pwd.focus(); return;
			}
			if(newMem.pwdCheck.value==""){
				alert("비밀번호 확인을 입력해주세요!");
				newMem.pwdCheck.focus(); return;
			}
			if(newMem.pwdSc1.value=="null"){
				alert("비밀번호 찾기 질문을 선택해주세요!");
				newMem.pwdSc1.focus(); return;
			}
			if(newMem.pwdSc2.value=="null"){
				alert("비밀번호 찾기 질문을 입력해주세요!");
				newMem.pwdSc2.focus(); return;
			}
			if(newMem.name.value==""){
				alert("이름을 입력해주세요!");
				newMem.name.focus(); return;
			}
			if(newMem.joomin1.value==""){
				alert("주민번호 앞자리를 입력해주세요!");
				newMem.joomin1.focus(); return;
			}
			if(newMem.joomin2.value==""){
				alert("주민번호 뒷자리를 입력해주세요!");
				newMem.joomin2.focus(); return;
			}
			if(newMem.region.value=="null"){
				alert("지역을 선택해주세요!");
				newMem.region.focus(); return;
			}
			if(newMem.job.value=="null"){
				alert("직업을 선택해주세요!");
				newMem.job.focus(); return;
			}
			if(newMem.interest1.value=="null"){
				alert("관심분야 대분류를 선택해주세요!");
				newMem.interest1.focus(); return;
			}
			if(newMem.interest2.value=="null"){
				alert("관심분야 중분류를 선택해주세요!");
				newMem.interest2.focus(); return;
			}
			
			
			
			
			if(newMem.hp2.value==""){
				alert("핸드폰번호 가운데자리를 입력해주세요!");
				newMem.hp2.focus(); return;
			}
			if(newMem.hp3.value==""){
				alert("핸드폰번호 뒷자리를 입력해주세요!");
				newMem.hp3.focus(); return;
			}
			if(newMem.email1.value==""){
				alert("이메일을 입력해주세요!");
				newMem.email1.focus(); return;
			}
			if(newMem.email2.value=="null"){
				alert("이메일 주소를 입력해주세요!");
				newMem.email2.focus(); return;
			}
			if(newMem.zipcode.value == "") {
				alert("집주소를 입력해 주세요! - (우편번호검색 버튼 클릭)");
				newMem.zipcode.focus(); return;
		    }
			if(newMem.address1.value == "") {
				alert("집주소를 입력해 주세요! - (우편번호검색 버튼 클릭)");
				newMem.address1.focus(); return;
		    }
		    if(newMem.address2.value == "") {
				alert("상세주소를 입력해 주세요!");
				newMem.address2.focus(); return;
		    }
			newMem.submit();
		}

		function idFocus(){
			newMem.id.focus();
			return;
		}
		function zipCheck()
		{
			window.open("zipCheck.jsp", "win", "width=600, height=200, scrollbars=yes, status=yes");
		}
		</script>
</head>
<body>
	<div class="wrapper">
		<jsp:include page="header.jsp" flush="false" />
		<div class="main-content text-center">
		

		<div class="loginBox" align="center">
		<center>
		<p style="font-size:x-large;">회원가입</p>
		<form class="login form-control" name="newMem" action="" method="post">
			<table cellspacing=20 style="width:1000px"
			class="table table-striped table-condensed table-hover" align:center;" border="1">
				<tr>
					<td style="text-align: right;">아 이 디 :</td>
					<td><input type="text" name="id" style="height: 20px;"size:"10"; required>&nbsp;&nbsp;<a
						href="javascript:checkId()"><img src="images/checkIdBtn.png"
							style="width: 60px;"></a></td>
				</tr>

				<tr>
					<td style="text-align: right;">비밀번호 :</td>
					<td><input type="password" name="pwd" style="height: 20px;"size:"12"></td>
				</tr>

				<tr>
					<td style="text-align: right;">비밀번호 확인 :</td>
					<td><input type="password" name="pwdCheck"
						style="height: 20px;"size:"12"></td>
				</tr>

				<tr>
					<td style="text-align: right;">비밀번호 찾기 질문:</td>
					<td><select name="pwdSc1">
							<option value="null" selected>선택해주세요.</option>
							<option value="bF">가장 친한 친구 이름은?</option>
							<option value="FF">가장 좋아하는 음식은?</option>
							<option value="ES">초등학교의 이름은?</option>
					</select></td>
				</tr>

				<tr>
					<td style="text-align: right;">비밀번호 찾기 답변 :</td>
					<td><input type="password" name="pwdSc2"
						style="height: 20px;"size:"12"></td>
				</tr>

				<tr>
					<td style="text-align: right;">이 름 :</td>
					<td><input type="text" name="name"
						style="height: 20px; width: 100px;"> <input type="radio"
						name="sex" value="남" checked>남 <input type="radio"
						name="sex" value="여">여</td>
				</tr>

				<tr>
					<td style="text-align: right;">주민등록번호 :</td>
					<td><input type="text" name="jumin1"
						style="height: 20px; width: 80px;"> -<input type="text"
						name="jumin2" style="height: 20px; width: 80px;"></td>
				</tr>

				<tr>
					<td style="text-align: right;">지역</td>
					<td><select region>
							<option value="null" selected>선택해주세요.</option>
							<optgroup label="서울">
								<option value="1">강남,서초,송파</option>
								<option value="2">강서,양천,영등포</option>
								<option value="3">금천,구로,관악</option>
								<option value="4">광진,동대문,중구</option>
								<option value="5">강북,성북,종로</option>
								<option value="6">노원,중랑,도봉</option>
								<option value="7">마포,서대문,은평</option>
							</optgroup>
							<optgroup label="경기도">
								<option value="8">인천</option>
								<option value="9">안양</option>
								<option value="10">수원</option>
								<option value="11">부천</option>
							</optgroup>
							<optgroup label="충청도">
								<option value="12">천안</option>
								<option value="13">대전</option>
							</optgroup>

							<optgroup label="전라도">
								<option value="14">광주</option>
								<option value="15">전주</option>
							</optgroup>

							<optgroup label="경상도">
								<option value="16">대구</option>
								<option value="17">울산</option>
								<option value="18">부산</option>
							</optgroup>
					</select></td>
				</tr>

				<tr>
					<td style="text-align: right;">직업:</td>
					<td><select name="job">
							<option value="" selected>선택해주세요.</option>
							<option value="웹개발자" >웹 개발자</option>
							<option value="웹디자이너">웹 디자이너</option>
							<option valeu="기획자">기획자</option>
					</select></td>
				</tr>

				<tr>
					<td style="text-align: right;">관심분야:</td>
					<td><select name="interest1">
							<option value="null" selected>대분류를 선택해주세요.</option>
							<option value="1">프로젝트</option>
							<option value="2">자격증</option>
					</select> <select name="interest2">
							<option value="null" selected>중분류 선택해주세요.</option>
							<option value="1">자바</option>
							<option value="2">파이썬</option>
					<!-- </select> <select>
							<option selected>중분류 선택해주세요.</option>
							<option>정보처리기사</option>
							<option>OCNA</option>
					</select></td> -->
				</tr>

				<tr>
					<td style="text-align: right;">핸드폰번호 :</td>

					<td><select name="hp1" style="height: 20px; width: 60px;">
							<option value="010" selected>010
							<option value="011">011
							<option value="016">016
					</select> - <input type="text" name="hp2" size="4"
						style="height: 20px; width: 60px;"> - <input type="text"
						name="hp3" size="4" style="height: 20px; width: 60px;"></td>
				</tr>

				<tr>
					<td style="text-align: right;">이메일 주소 :</td>

					<td><input type="text" name="email1"
						style="height: 20px; width: 155px;"> @ <select
						name="email2" style="height: 20px; width: 155px;">
							<option value="null" selected>--이메일선택--
							<option value="naver.com">naver.com
							<option value="nate.com">nate.com
							<option value="daum.net">daum.net
							<option value="gmail.com">gmail.com
					</select></td>
				</tr>
				<tr>
					<td style="text-align: right;">거주지 :</td>
					<td><input type="text" name="zipcode" size="7" readonly>
						<input type="button" value="우편번호검색"
						style="font-size:12px; height:26px;"class="btn btn-success" onClick="zipCheck()"><br>
						<br> <input type="text" name="address1" size="40" readonly><br>
						<br> <input type="text" name="address2" size="40">&nbsp<font
						size=2>(상세주소입력)</font></td>
				</tr>

			</table>
		</form>
			
			<center>
				<button type="submit" name="submitBtn" value="회원가입" class="btn btn-primary"
				onclick="checkValue()">회원탈퇴</button>
				<button type="button" name="resetBtn" value="취소" class="btn btn-primary"
				>취소</button>
			</center>
		<br>
	    </center>
</div>
		

		</div>
		<jsp:include page="footer.jsp" flush="false" />
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW"
		crossorigin="anonymous"></script>
</body>
</html>






