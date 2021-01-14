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
<title>스터디 평가</title>
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
       <h3 class="titleTxt p-3">스터디 평가</h3>
    </div>
    <div class="container"><br><br><br>
	  <form>
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
	  <br><br />
	  <hr />
		<h4>건의 사항 & 하고 싶은 말</h4>
      <div>
      	<textarea name="comments" id="comments" cols="100" rows="5"></textarea>
      </div>
		<br />
      <div class="modal-footer" style="margin:0 auto">
        <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">취소</button>
        <button type="submit" class="btn btn-primary">제출</button>
      </div>
      </form>
    </div>
    </div> 
 <jsp:include page="footer.jsp" flush="false"/>
 </div>
</body>
</html>