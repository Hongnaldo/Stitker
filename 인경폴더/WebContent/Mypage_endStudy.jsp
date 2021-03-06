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
<title>종료된 스터디</title>
<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="<%=cp %>/css/bootstrap.css">
	<link rel="stylesheet" href="<%=cp %>/css/style.css">
	<script src="http://code.jquery.com/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="https://kit.fontawesome.com/5cdf4f755d.js"></script>
</head>
<body>
<div class="wrapper">
 <jsp:include page="header.jsp" flush="false"/>
 <div class="main-content">
   <div class="title">
        <h3 class="titleTxt p-3 text-center">종료된 스터디</h3>
      </div>
      <div class="container"><br><br><br>
      <div class="row align-content-center">
          <div class="col-12">
          	<table class="table">
              <tr>
                <td class="fw-bold fs-5 bd">스터디명</td>
                <td class="bd cen">자바스크립트 스터디</td>
                <td class="fw-bold fs-5 bd">스터디 리더</td>
                <td class="cen">hsm11</td>
              </tr>
              <tr>
                <td class="fw-bold fs-5 bd">기간</td>
                <td class="bd cen">2020/12/21 ~ 2021/01/25</td>
                <td class="fw-bold fs-5 bd">장소</td>
                <td class="cen">서울특별시 홍대</td>
              </tr>
              <tr>
                <td class="fw-bold fs-5 bd">요일</td>
                <td class="bd cen">토요일, 일요일</td>
                <th class="bd fs-5">시간</th>
                <td class="cen">13:00 ~ 15:00</td>
              </tr>
              <tr>
               <td class="fw-bold bd fs-5">진행률</td>
               <td colspan="3"><div class="progress mt-2" style="width: 80%; margin: 0 auto;">
                <div class="progress-bar" role="progressbar" style="width: 20%;" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">20%</div>
              </div></td>
              </tr>
          </table>   
          </div>
           <div class="col-lg-12 col-md-8 col-sm-12 mt-3 mb-5" style="margin: 0 auto;">
               <div class="col-7 mt-3" style="margin: 0 auto;">
              <button type="button" class="btn btn-outline-primary">출석부</button>
              <!-- Button trigger modal -->
              <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#memberList">
                스터디원 목록
              </button>
              <!-- Modal -->
              <div class="modal fade" id="memberList" tabindex="-1" aria-labelledby="memberListLabel" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title fw-bold" id="memberListTitle">스터디원 목록</h5>
                    </div>
                    <div class="modal-body">
                      <table class="table">
                        <thead>
                          <tr>
                            <th scope="col">번호</th>
                            <th scope="col">아이디</th>
                            <th scope="col">평균 출석률</th>
                            <th scope="col">참가한 스터디 횟수</th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr>
                            <th scope="row">1</th>
                            <td>hsm11</td>
                            <td>100%</td>
                            <td>6</td>
                          </tr>
                          <tr>
                            <th scope="row">2</th>
                            <td>phi22</td>
                            <td>100%</td> 
                            <td>6</td>
                          </tr>
                          <tr>
                            <th scope="row">3</th>
                            <td>ljj33</td>
                            <td>100%</td>
                            <td>6</td>
                          </tr>
                        </tbody>
                      </table>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    </div>
                  </div>
                </div>
              </div>
              
              <!-- Button trigger modal --> 
              <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#myScore">
                내 점수
              </button>
              <!-- Modal -->
              <div class="modal fade" id="myScore" tabindex="-1" aria-labelledby="exampleModalLabel2" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title fw-bold" id="myScoreLabel">내 점수</h5>
                    </div>
                    <div class="modal-body fw-bold">
                      <span>평균 점수 : </span><span>100</span><br>
                      <span>총점 : </span><span>800</span><br>
                      <span class="fw-normal">(총점 = 평균 점수 * 스터디 횟수)</span>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    </div>
                  </div>
                </div>
              </div>
              <button type="button" class="btn btn-outline-primary">스터디 후기</button>
              <button type="button" class="btn btn-outline-primary">스터디원 평가</button>
          </div>
          </div>  
        <div>
          <br><br><br>
          <span class="fs-4 fw-bold">컨텐츠</span>
          <div class="list-group list-group-flush mt-3">
          <div class="stdcon">
          <table class="table mb-5">
			  <thead>
			    <tr>
			      <th scope="col" style="width:10%">번호</th>
			      <th scope="col" class="text-center"style="width:50%">제목</th>
			      <th scope="col" style="width:10%">작성자</th>
			      <th scope="col" style="width:20%">날짜</th>
			      <th scope="col" style="width:10%">조회수</th>
			    </tr>
			  </thead>
			  <tbody>
			    <tr>
			      <th scope="row">1</th>
			      <td class="text-center"><a href="#">일정 공유! 필독!!!</a></td>
			      <td>hsm11</td>
			      <td>2020-12-13</td>
			      <td>6</td>
			    </tr>
			    <tr>
			      <th scope="row">2</th>
			      <td class="text-center">자바스크립트란?</td>
			      <td>hsm11</td>
			      <td>2020-12-14</td>
			      <td>14</td>
			    </tr>
			     <tr>
			      <th scope="row">3</th>
			      <td class="text-center">자바스크립 변수</td>
			      <td>hsm11</td>
			      <td>2020-12-21</td> 
			      <td>16</td>
			    </tr> 
			  </tbody>
			</table> 
			</div> 
			<a href="" class="btn btn-outline-primary" style="width:90px; margin-top:-20px;">글쓰기</a><br>
			<br>
			<nav aria-label="Page navigation example" style="margin:0 auto;">
			  <ul class="pagination">
			    <li class="page-item"><a class="page-link" href="#">이전글</a></li>
			    <li class="page-item"><a class="page-link" href="#">1</a></li>
			    <li class="page-item"><a class="page-link" href="#">2</a></li>
			    <li class="page-item"><a class="page-link" href="#">3</a></li>
			    <li class="page-item"><a class="page-link" href="#">다음글</a></li>
			  </ul>
			</nav>
			
          </div>
           
            <br><br><br><br>
          </div>
          </div>
      </div>
    </div><!--main-content end-->
	     
 <jsp:include page="footer.jsp" flush="false"/>
 </div>
</body>
</html>