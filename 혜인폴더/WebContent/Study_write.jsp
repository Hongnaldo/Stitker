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
<title>스터디 개설</title>
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
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/studywrite.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp %>/js/util.js"></script>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/jquery-ui.css">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.css">
<link href="css/bootstrap.min.css">
<script type="text/javascript" src="<%=cp %>/js/jquery-ui.js"></script>
    <script src="https://kit.fontawesome.com/5cdf4f755d.js" crossorigin="anonymous"></script>
    <script type="text/javascript">
	
	function sendIt()
	{
		// 필수사항 입력 안 하면 알림창 띄우고 입력 안 한 칸에 focus 주는 함수인데
		// 다른 건 required 속성이 적용이 되어서 주석처리 했고, 
		// 요일 선택하는 checkbox는 required 속성이 안 먹어서 살려 뒀어요
		// 혹시 알림창 띄우실 거면 다른 것도 풀어서 사용하시면 될 것 같아요
		
		f = document.myForm;
	
		/* // 제목 입력 확인
		str = f.title.value;
		str = str.trim();
		
		if(!str)
		{
			alert("\n제목을 입력하세요");
			f.title.focus();
			return; 
		}
		
		
		// 목적 및 목표 입력 확인
		str = f.purpose.value;
		str = str.trim();
		
		if(!str)
		{
			alert("\n목적 및 목표를 입력하세요");
			f.purpose.focus();
			return; 
		}
		
		// 스터디 분야 선택 확인
		str = f.studyCategory.value;
		str = str.trim();
		
		if(str=='select')
		{
			alert("\n스터디 분야를 선택하세요");
			f.studyCategory.focus();
			return; 
		}
		
		// 스터디 유형 선택 확인
		str = f.studyType.value;
		str = str.trim();
		
		if(str=='select')
		{
			alert("\n스터디 유형을 선택하세요");
			f.studyType.focus();
			return; 
		}
		
		// 시작 날짜 확인
		year = f.startYear.value;
		year = year.trim();
		
		month = f.startMonth.value;
		month = month.trim();
		
		date = f.startDate.value;
		date = date.trim();
		
		if(year=='select' || month=='select' || date=='select')
		{
			alert("\n스터디 시작 날짜를 선택하세요");
			f.startYear.focus();
			return; 
		}
		
		// 종료 날짜 확인
		year = f.endYear.value;
		year = year.trim();
		
		month = f.endMonth.value;
		month = month.trim();
		
		date = f.endDate.value;
		date = date.trim();
		
		if(year=='select' || month=='select' || date=='select')
		{
			alert("\n스터디 종료 날짜를 선택하세요");
			f.endYear.focus();
			return; 
		} */
		
		// 요일 입력 확인
		if ($("input:checkbox[name=day]").is(":checked") == false) 
		{
            alert("\n스터디 진행 요일을 선택하세요.");
		} 

	} 
	

	
	
	// 요일 선택 시 시간 입력
	function checkDay()
	{
	    if($('input:checkbox[id=sun]').is(':checked')){
	        $('#sunTime').show();
	    }else{
	        $('#sunTime').hide();
	    }
	    
	    if($('input:checkbox[id=mon]').is(':checked')){
	        $('#monTime').show();
	    }else{
	        $('#monTime').hide();
	    } 
	    
	    if($('input:checkbox[id=tue]').is(':checked')){
	        $('#tueTime').show();
	    }else{
	        $('#tueTime').hide();
	    } 
	    
	    if($('input:checkbox[id=wed]').is(':checked')){
	        $('#wedTime').show();
	    }else{
	        $('#wedTime').hide();
	    }
	    
	    if($('input:checkbox[id=thu]').is(':checked')){
	        $('#thuTime').show();
	    }else{
	        $('#thuTime').hide();
	    }
	    
	    if($('input:checkbox[id=fri]').is(':checked')){
	        $('#friTime').show();
	    }else{
	        $('#friTime').hide();
	    }
	    
	    if($('input:checkbox[id=sat]').is(':checked')){
	        $('#satTime').show();
	    }else{
	        $('#satTime').hide();
	    }
	}
	
	// 목적 및 목표 글자수 
	$(document).ready(function() {
	    $('#purpose').on('keyup', function() {
	        $('#purposeCnt').html("("+$(this).val().length+" / 300)");
	 
	        if($(this).val().length > 300) {
	            $(this).val($(this).val().substring(0, 300));
	            $('#purposeCnt').html("(300 / 300)");
	        }
	    });
	});
	
	// 시작날짜, 종료날짜 달력 선택
	$(document).ready(function()
	{
		$("#startDate").datepicker(
		{	
			dateFormat : "yy-mm-dd"
			, changeYear : true
			, changeMonth : true
		}); 
		
		$("#endDate").datepicker(
		{	
			dateFormat : "yy-mm-dd"
			, changeYear : true
			, changeMonth : true
		});
		
		// 날짜 선택 범위 설정
		/* $(selector).datepicker(
		{
			dateFormat: 'yy-mm-dd',
			minDate: new Date('2017-12-01'),
			maxDate: new Date('2017-12-31')
		}); */
	}); 


</script>
   
</head>
<body>
<div class="wrapper">
 <jsp:include page="header.jsp" flush="false"/>
 <div class=" main main-content text-center"><br>
   
    <div id="StudyOpen">
    
	<div id="StudyOpen_title">
		스터디 개설 신청
	</div><!-- #StudyOpen_title -->
	
	<div class="main">
	<form action="" method="post" name=myForm>
	
	<p class="header_left">스터디 개설 정보 입력</p>
	
	<table id="table1" class="table table-striped table-bordered">
		<tr>
			<th>스터디 이름</th>
			<td><input type="text" maxlength="60" name="title" class="form-control" id="title"
			required></td>
		</tr>
		<tr>
			<th>스터디의 목적 및 목표</th>
			<td>
				<textarea rows="2" cols="40" name="purpose" id="purpose" class="form-control"
				required></textarea>
				<div style="font-size: 7pt;" id="purposeCnt">(0 / 300)</div>
			</td>
		</tr>
		<tr>
			<th>스터디 분야</th>
			<td>
				<select name="studyCategory" class="form-control" id="studyCategory"
				required>
					<option value="">선택</option>
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
			</td>
		</tr>
		<tr>
			<th>스터디 유형</th>
			<td>
				<select name="studyType" class="form-control" id="studyType"
				required>
					<option value="">선택</option>
					<option value="dba">면접</option>
					<option value="network">코딩테스트</option>
					<option value="developer">프로젝트</option>
					<option value="pm">프로그래밍언어</option>
					<option value="marketing">알고리즘</option>
					<option value="etc">기타</option>
				</select>
			</tr>
		<tr>
			<th>시작 날짜</th>
			<td>
				<input type="text" id="startDate" name="startDate" class="form-control"
				placeholder="스터디 시작일" required>
			</td>
		</tr>
		<tr>
			<th>종료 날짜</th>
			<td>
				<input type="text" id="endDate" name="endDate" 
				class="form-control" placeholder="스터디 종료일" required>
				<span class="errMsg" style="font-size: 7pt;">
				*종료 날짜는 시작 날짜로부터 1년까지 선택할 수 있습니다.</span>
			</td>
		</tr>
		<tr>
			<th>스터디 진행 요일 및 시간</th>
			<td>
				<div id="studyDate" name="studyDate" class="form-control" required>
						<label>
							<input type="checkbox" name="day" id="sun" 
							value="sun" onchange="checkDay()">일요일
						</label>
						
						<div id="sunTime" class="form group">
							<input type="text" id="hour" class="form-control" 
							style="display:inline-block">
							<label for="hour">시</label>
							<input type="text" id="minute" class="form-control" 
							style="display:inline-block">
							<label for="minute">분</label>
						</div>
						<br>
						
						<label>
							<input type="checkbox" name="day" id="mon" 
							value="mon" onchange="checkDay()">월요일
						</label>
						<div id="monTime">
							<input type="text" id="hour" class="form-control" 
							style="display:inline-block">
							<label for="hour">시</label>
							<input type="text" id="minute" class="form-control" 
							style="display:inline-block">
							<label for="minute">분</label>
						</div><br>
						
						<label>
							<input type="checkbox" name="day" id="tue" 
							value="tue" onchange="checkDay()">화요일
						</label>
						<div id="tueTime">
							<input type="text" id="hour" class="form-control" 
							style="display:inline-block">
							<label for="hour">시</label>
							<input type="text" id="minute" class="form-control" 
							style="display:inline-block">
							<label for="minute">분</label>
						</div><br>
						
						
						<label>
							<input type="checkbox" name="day" id="wed" 
							value="wed" onchange="checkDay()">수요일
						</label>
						<div id="wedTime">
							<input type="text" id="hour" class="form-control" 
							style="display:inline-block">
							<label for="hour">시</label>
							<input type="text" id="minute" class="form-control" 
							style="display:inline-block">
							<label for="minute">분</label>
						</div><br>
						
						<label>
							<input type="checkbox" name="day" id="thu" 
							value="thu" onchange="checkDay()">목요일
						</label>
						<div id="thuTime">
							<input type="text" id="hour" class="form-control" 
							style="display:inline-block">
							<label for="hour">시</label>
							<input type="text" id="minute" class="form-control" 
							style="display:inline-block">
							<label for="minute">분</label>
						</div><br>
						
						<label>
							<input type="checkbox" name="day" id="fri" 
							value="fri" onchange="checkDay()">금요일
						</label>
						<div id="friTime">
							<input type="text" id="hour" class="form-control"
							style="display:inline-block">
							<label for="hour">시</label>
							<input type="text" id="minute" class="form-control" 
							style="display:inline-block">
							<label for="minute">분</label>
						</div><br>
						
						<label>
							<input type="checkbox" name="day" id="sat" 
							value="sat" onchange="checkDay()">토요일
						</label>
						<div id="satTime">
							<input type="text" id="hour" class="form-control" 
							style="display:inline-block">
							<label for="hour">시</label>
							<input type="text" id="minute" class="form-control"
							style="display:inline-block">
							<label for="minute">분</label>
						</div><br>
					</div>
			</td>
		</tr>
		<tr>
			<th>지역</th>
			<td>
				<select name="regionGroup1" id="regionGroup1" class="form-control" required>
					<option value="">선택</option>
					<option value="seoul">서울</option>
					<option value="incheon">인천</option>
					<option value="gyeonggi">경기</option>
					<option value="kangwon">강원</option>
					<option value="daejeon">대전</option>
					<option value="chungnam">충남</option>
					<option value="chungbuk">충북</option>
					<option value="gwangju">광주</option>
					<option value="jeonnam">전남</option>
					<option value="jeonbuk">전북</option>
					<option value="daegu">대구</option>
					<option value="busan">부산</option>
					<option value="gwangju">광주</option>
					<option value="ulsan">울산</option>
					<option value="gyeongnam">경남</option>
					<option value="gyeongbuk">경북</option>
					<option value="jeju">제주</option>
				</select>
				<select name="regionGroup2" id="regionGroup2" class="form-control" required>
					<option value="">선택</option>
					<option value="1">강남구</option>
					<option value="2">강동구</option>
					<option value="3">영등포구</option>
					<option value="4">용산구</option>
				</select>
			</td>
		</tr>
		<tr>
			<th>최소인원수</th>
			<td>
				<select name="memCount" id="memCount" class="form-control" required>
					<option value="">선택</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
				</select>
				<span style="font-size: 7pt;">
				*스터디 개설이 가능한 인원수는 3명 이상, 8명 이하입니다.</span>
			</td>
		</tr>
		<tr>
			<th>최대인원수</th>
			<td>
				<select name="memCount" id="memCount" class="form-control" required>
					<option value="">선택</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
				</select>
				<span style="font-size: 7pt;">
				*스터디 개설이 가능한 인원수는 3명 이상, 8명 이하입니다.</span>
			</td>
		</tr>
		<tr>
			<th>참여최소등급</th>
			<td>
				<select name="grade" id="grade" class="form-control" required>
					<option value="">선택</option>
					<option value="1">1등급</option>
					<option value="2">2등급</option>
					<option value="3">3등급</option>
					<option value="4">4등급</option>
					<option value="5">5등급</option>
					<option value="6">6등급</option>
				</select>
				<span style="font-size: 7pt;">
				*참여최소등급은 개설자의 등급보다 높을 수 없습니다.</span>
			</td>
		</tr>
	</table>
	
	<div id="footer">
		<button type="submit" id="sendBtn" class="btn btn-primary" onclick="sendIt()">등록</button>
		<button type="button" class="btn btn-primary">재입력</button>
		<button type="reset" class="btn btn-primary">취소</button>
	</div><!-- #footer -->
	
	</form>
	</div>
	
</div><!-- #StudyOpen -->
   
  </div>
 <jsp:include page="footer.jsp" flush="false"/>
 </div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
</body>
</html>