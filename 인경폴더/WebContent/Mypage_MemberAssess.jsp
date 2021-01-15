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
<title>스터디원 평가</title>
<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="<%=cp %>/css/style.css">
	<script src="http://code.jquery.com/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="https://kit.fontawesome.com/5cdf4f755d.js"></script>
</head>
<body>
<div class="wrapper"> 
 <jsp:include page="header.jsp" flush="false"/>
 <div class="main-content text-center">
	<div class="bg-dark col-12 titleas">
       <h3 class="titleTxt p-3">스터디원 & 스터디 평가</h3>
    </div>
    <div class="container"><br><br><br>
        <table class="table"> 
            <thead>
              <tr>
                <th scope="col">번호</th>
                <th scope="col">회원 아이디</th>
                <th scope="col">회원 평가 여부</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <th scope="row">1</th>
                <td>hsm</td>
                <td><button type="button" id="eval" class="btn btn-outline-success col-4" disabled data-bs-toggle="button" autocomplete="off">완료</button></td>
              </tr>
              <tr>
                <th scope="row">2</th>
                <td>phi</td>
                <td><!-- Button trigger modal -->
                  <button type="button" class="btn btn-outline-primary col-4" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                    평가하기
                  </button>
                  
                  <!-- Modal -->
                  <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                    <div class="modal-dialog">
                      <div class="modal-content">
                        <div class="modal-header">
                          <span class="fs-4">phi</span><h5 class="modal-title" id="staticBackdropLabel">스터디원 평가</h5>
                          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                          <form action="">
                            과제 <br><div>
                              <label>
                                  <input type="radio" name="task" value="5" checked>
                                  <span>매우 잘함</span>
                              </label>
                              <label class="radio">
                                  <input type="radio" name="task" value="4">
                                  <span>잘함</span>
                              </label>
                              <label class="radio">
                                  <input type="radio" name="task" value="3">
                                  <span>보통</span>
                              </label>
                              <label class="radio">
                                <input type="radio" name="task" value="2">
                                <span>부족함</span>
                            </label>
                            <label class="radio">
                              <input type="radio" name="task" value="1">
                              <span>매우 부족함</span>
                          </label>
                          </div>
                          <hr>
                            의사소통 능력
                            <br><div>
                              <label>
                                  <input type="radio" name="communication" value="5" checked>
                                  <span>매우 잘함</span>
                              </label>
                              <label class="radio">
                                  <input type="radio" name="communication" value="4">
                                  <span>잘함</span>
                              </label>
                              <label class="radio">
                                  <input type="radio" name="communication" value="3">
                                  <span>보통</span>
                              </label>
                              <label class="radio">
                                <input type="radio" name="communication" value="2">
                                <span>부족함</span>
                            </label>
                            <label class="radio">
                              <input type="radio" name="communication" value="1">
                              <span>매우 부족함</span>
                          </label>
                          </div>
                          <hr>                  
                            참여도 <br><div>
                              <label>
                                  <input type="radio" name="participation" value="5" checked>
                                  <span>매우 잘함</span>
                              </label>
                              <label class="radio">
                                  <input type="radio" name="participation" value="4">
                                  <span>잘함</span>
                              </label>
                              <label class="radio">
                                  <input type="radio" name="participation" value="3">
                                  <span>보통</span>
                              </label>
                              <label class="radio">
                                <input type="radio" name="participation" value="2">
                                <span>부족함</span>
                            </label>
                            <label class="radio">
                              <input type="radio" name="participation" value="1">
                              <span>매우 부족함</span>
                          </label>
                          </div>
                        
                        </div>
                        <div class="modal-footer">
                          <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">취소</button>
                          <button type="submit" class="btn btn-primary">제출</button>
                        </div>
                     </div>
                    </div>
                  </div>
                 </td>
              </tr>
              <tr>
                <th scope="row">3</th>
                <td>ljj</td>
                <td><a href="#" id="eval" class="btn btn-outline-primary col-4" role="button" data-bs-toggle="button">평가하기</a></td>
              </tr>
            </tbody>
          </table>
        </div> 
        <br><br>
	  <h4>스터디 만족도</h4>
	  <div class="form-check form-check-inline mt-4">
		  <input class="form-check-input" type="radio" name="inlineRadioOptions" id="Radio1" value="1">
		  <label class="form-check-label" for="Radio1">1</label>
	  </div>
	  <div class="form-check form-check-inline">
		  <input class="form-check-input" type="radio" name="inlineRadioOptions" id="Radio2" value="2">
		  <label class="form-check-label" for="Radio2">2</label>
	  </div>
	  <div class="form-check form-check-inline">
		  <input class="form-check-input" type="radio" name="inlineRadioOptions" id="Radio3" value="3">
		  <label class="form-check-label" for="Radio3">3</label>
	  </div>
	  <div class="form-check form-check-inline">
		  <input class="form-check-input" type="radio" name="inlineRadioOptions" id="Radio4" value="4">
		  <label class="form-check-label" for="Radio4">4</label>
	  </div>
	  <div class="form-check form-check-inline">
		  <input class="form-check-input" type="radio" name="inlineRadioOptions" id="Radio5" value="5">
		  <label class="form-check-label" for="Radio5">5</label>
	  </div>
	  <br><br>
      <div class="mb-5" style="margin:0 auto">
        <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">취소</button>
        <button type="submit" class="btn btn-primary">제출</button>
      </div>
      </form>
    </div><!--main-content end-->   
     
 <jsp:include page="footer.jsp" flush="false"/>
 </div>
</body>
</html>