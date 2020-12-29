<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Nav.html</title>
   <!-- Required meta tags -->
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
   <link rel="stylesheet" href="/css/bootstrap.css">
    <link href="/css/bootstrap.min.css">
    <link rel="stylesheet" href="style.css">
    <script src="https://kit.fontawesome.com/5cdf4f755d.js" crossorigin="anonymous"></script>
</head>
<body>
<!--nav-->
<nav class="navbar navbar-expand-sm navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand m-sm-3" href="#">
            <img src="images/logo3.jpg" alt="" width="150px" height="70px">
          </a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item">
            <a class="nav-link" aria-current="page" href="#">스터딧소개</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">스터디 찾기</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              정보공유 게시판
            </a>
            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
              <li><a class="dropdown-item" href="#">세미나</a></li>
              <li><a class="dropdown-item" href="#">면접후기</a></li>
              <li><hr class="dropdown-divider"></li>
              <li><a class="dropdown-item" href="#">자유게시판</a></li>
            </ul>
          </li>
        
        </ul>
        <form class="d-flex">
          <input class="form-control me-2" type="search" placeholder="검색" aria-label="Search">
        </form>
        <!--account-->
    <nav style="--bs-breadcrumb-divider: '|';" aria-label="breadcrumb">
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="#">로그인</a></li>
          <li class="breadcrumb-item"><a href="#">회원가입</a></li>
          <li class="breadcrumb-item"><a href="#">고객센터</a></li>
        </ol>
    </nav>
      </div>
    </div>
</nav> 
</body>
</html>