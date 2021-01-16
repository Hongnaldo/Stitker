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
<title>내스터디</title>
<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="<%=cp %>/css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="<%=cp %>/css/style.css">
	<link rel="stylesheet" type="text/css" href="<%=cp %>/css/bootstrap-reboot.css">
	<script src="http://code.jquery.com/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="https://kit.fontawesome.com/5cdf4f755d.js"></script>
</head>
<body>
<div class="wrapper">
 <jsp:include page="header.jsp" flush="false"/>
 <div class="main-content text-center"> 
    <div class="bg-dark col-12 title">
        <h3 class="titleTxt p-3">내 스터디</h3>
      </div>
      <div class="container" style="height: 700px;"><br><br><br>
        <ul class="nav nav-tabs col-12" id="myTab" role="tablist">
          <li class="nav-item" role="presentation">
            <a class="nav-link active" id="now-tab" data-bs-toggle="tab" href="#now" role="tab" aria-controls="now" aria-selected="true">진행 중인 스터디</a>
          </li>
          <li class="nav-item" role="presentation">
            <a class="nav-link" id="upcoming-tab" data-bs-toggle="tab" href="#upcoming" role="tab" aria-controls="upcoming" aria-selected="false">진행 예정인 스터디</a>
          </li>
          <li class="nav-item" role="presentation">
            <a class="nav-link" id="end-tab" data-bs-toggle="tab" href="#end" role="tab" aria-controls="end" aria-selected="false">종료된 스터디</a>
          </li>
          <li class="nav-item" role="presentation">
            <a class="nav-link" id="cancel-tab" data-bs-toggle="tab" href="#cancel" role="tab" aria-controls="cancel" aria-selected="false">취소된 스터디</a>
          </li>
        </ul>
        <div class="tab-content" id="myTabContent">
          <br>
          <div class="tab-pane fade show active mt-4" id="now" role="tabpanel" aria-labelledby="now-tab">
            <table class="table">
              <thead>
                <tr>
                  <th scope="col" class="fs-5">번호</th>
                  <th scope="col" class="fs-5">스터디 이름</th>
                  <th scope="col" class="fs-5">스터디 기간</th>
                  <th scope="col" class="fs-5">리더</th>
                  <th scope="col" class="fs-5">요일</th>
                  <th scope="col" class="fs-5">시간</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td scope="row">1</td>
                  <td><a href="#">코딩천재 hsm과 함께하는 자바스터티</a></td>
                  <td>2020/12/01 ~ 2021/01/23</td>
                  <td>hsm11</td>
                  <td>토</td>
                  <td>13:00 ~ 14:00</td>
                </tr>
                <tr>
                  <td scope="row">2</td>
                  <td><a href="#">망원동 khj의 오라클 스터디</a></td>
                  <td>2020/12/01 ~ 2021/01/24</td>
                  <td>khj00</td>
                  <td>일</td>
                  <td>13:00 ~ 14:00</td>
                </tr>
              </tbody>
            </table>
          </div>
          <br><br>
          <div class="tab-pane fade" id="upcoming" role="tabpanel" aria-labelledby="upcoming-tab">
            <table class="table">
              <thead>
                <tr>
                  <th scope="col" class="fs-5">번호</th>
                  <th scope="col" class="fs-5">스터디 이름</th>
                  <th scope="col" class="fs-5">스터디 기간</th>
                  <th scope="col" class="fs-5">리더</th>
                  <th scope="col" class="fs-5">요일</th>
                  <th scope="col" class="fs-5">시간</th>
                </tr>
              </thead>
              <tbody>
                <!-- <tr>
                  <td scope="row">1</td>
                  <td><a href="#">코딩천재 hsm과 함께하는 자바스터티</a></td>
                  <td>2020/12/01 ~ 2021/01/23</td>
                  <td>hsm11</td>
                  <td>토</td>
                  <td>13:00 ~ 14:00</td>
                </tr>
                <tr>
                  <td scope="row">2</td>
                  <td><a href="#">망원동 불주먹 khj의 오라클 스터디</a></td>
                  <td>2020/12/01 ~ 2021/01/24</td>
                  <td>khj00</td>
                  <td>일</td>
                  <td>13:00 ~ 14:00</td>
                </tr> -->
       
              </tbody>
            </table>
          </div>
          <div class="tab-pane fade" id="end" role="tabpanel" aria-labelledby="end-tab">
            <table class="table">
              <thead>
                <tr>
                  <th scope="col" class="fs-5">번호</th>
                  <th scope="col" class="fs-5">스터디 이름</th>
                  <th scope="col" class="fs-5">스터디 기간</th>
                  <th scope="col" class="fs-5">리더</th>
                  <th scope="col" class="fs-5">요일</th>
                  <th scope="col" class="fs-5">시간</th>
                </tr>
              </thead>
              <tbody>
                <!-- <tr>
                  <td scope="row">1</td>
                  <td><a href="#">홍대 자바 주말반</a></td>
                  <td>2020/11/01 ~ 2020/12/23</td>
                  <td>asd11</td>
                  <td>토</td>
                  <td>13:00 ~ 14:00</td>
                </tr>
                <tr>
                  <td scope="row">2</td>
                  <td><a href="#">망원동 불주먹 khj의 오라클 스터디</a></td>
                  <td>2020/12/01 ~ 2020/12/24</td>
                  <td>khj00</td>
                  <td>일</td>
                  <td>13:00 ~ 14:00</td>
                </tr> -->
                 <c:if test="${count == 0 }">
					<td>종료된 스터디가 없습니다.</td>
				</c:if>
				<c:if test="${count>0 }">
                <c:forEach var="end" items="${endlist }">
                	<tr>
                	<td>${end.rnum }</td>
                	<td>${end.study_name }</td>
                	<td>${end.period }</td>
                	<td>${end.leader }</td>
                	<td>${end.weekday }</td>
                	</tr>
                </c:forEach>
                </c:if>
              </tbody>
            </table>
          </div>
          <div class="tab-pane fade mt-4" id="cancel" role="tabpanel" aria-labelledby="cancel-tab">
            <h2>취소된 스터디가 없습니다.</h2>
          </div>
        </div>
      </div><br><br>
    </div><!--main-content end-->
     
 <jsp:include page="footer.jsp" flush="false"/>
 </div>
</body>
</html>