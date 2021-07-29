<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel='stylesheet' href='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css' />
<script src="js/default.js"></script>
<link rel="stylesheet" href="css/default.css">
<link rel="stylesheet" href="css/index.css">
<link rel="stylesheet" href="css/header_bar.css">
<link rel="stylesheet" media="( min-width:701px ) and ( max-width:1000px )" href="css/tablet.css">
<link rel="stylesheet" media="( min-width:0px ) and ( max-width:700px )" href="css/mobile.css">
<link rel="stylesheet" href="css/starability-all.min.css">
</head>
<body>

<header>
     <div id="socketAlert" class="alert alert-info" role="alert" style="display: none;"></div>
        <div class="left">
            <h1><a href="index.do"></a></h1>
            <a href="#a" class="all"></a>
            <div class="nav">
                <h2>Menu</h2>
               <nav>
                <ul>
                    <li>
                    <c:if test="${!empty sessionScope.s_user }">
	   					<a href="#a"></a></c:if>
        			</li>
                    </ul>
                </nav>
                <div>
                  <c:if test="${empty sessionScope.s_user }">
                    <a href="#a">Sign in</a>
                    </c:if>
                      <c:if test="${!empty sessionScope.s_user }">
                      <a href="logout.do">로그아웃</a>
                    </c:if>
                    ${sessionScope.s_user.user_grade eq 'admin' ? '<a href="adminPage.do">관리자</a>' : sessionScope.s_user.user_grade eq 'sitter' ? '<a href="sitterMypage.do">시터페이지</a>' : '<a href="sitterApply.do">시터신청</a>'}
                    	
                </div>
                <a href="#a" class="close">Close</a>
            </div>
        </div>
        <ul>
        <li>
        <c:if test="${empty sessionScope.s_user }">
        <div><a href="login.do">Sign in</a></div>
        </c:if>
        <c:if test="${!empty sessionScope.s_user }">
		<div><a href="logout.do">로그아웃</a></div>
		</c:if>

        </li>
        <li>
        <c:if test="${sessionScope.s_user.user_grade eq 'admin'}"><a href="adminPage.do">관리자</a></c:if> 
        <c:if test="${sessionScope.s_user.user_grade eq 'sitter'}"><a href="sitterMypage.do?user_idx=${sessionScope.s_user.user_idx}">시터페이지</a></c:if> 
        <c:if test="${sessionScope.s_user.user_grade eq 'user'}"><a href="sitterApply.do">시터신청</a></c:if> 
        </li>
        <li class="join"><a href="userJoin.do">Join us</a></li>
       
        </ul>
    </header>
    <div class="dim"></div>

<div class='container' style="padding-top: 150px;">
 <!-- include : nav  해더에 포함하는게 좋을듯 ?-->
      <nav class='nav justify-content-center'>
         <a class='nav-link p-2' href="insertItemForm.do">상품 등록</a> 
         <a class='nav-link p-2' href="selectItemForm.do">상품 관리하기</a> 
         <a class='nav-link p-2' href="stockManageForm.do">재고 관리하기</a> 
         <a class='nav-link p-2' href="orderManageForm.do">주문 관리하기</a> 
         <a class='nav-link p-2' href='shopChartForm.do'>매출 현황</a>
         <a class='nav-link p-2' href="test.do">테스트</a>
         <a class='nav-link p-2' href="adminSitterAccept.do">시터 신청</a>
         <a class='nav-link p-2' href="adminSitterList.do">시터관리</a>
         <a class='nav-link p-2' href="adminChat.do">채팅</a>
      </nav>

  	<div class='gnbBar'>
    	<hr class='line'>
    </div>
    
    <!-- /include : nav  -->
      <div class='row'>
         <div class='offset-2 col-4'>
            <a href="userManager.do"
               class='btn btn-outline-primary d-flex justify-content-center align-items-center adminMainBtnSize'>회원수<br>${count}명
            </a>
         </div>
         <div class='col-4'>
            <a href='bbsManager.do'
               class='btn btn-outline-primary d-flex justify-content-center align-items-center adminMainBtnSize'>게시판 글의 수<br>${bbsManager} 개
            </a>
         </div>
      </div>
      <div class='row mt-4'>
         <div class='offset-2 col-4'>
            <a href='review/01.html'
               class='btn btn-outline-primary d-flex justify-content-center align-items-center adminMainBtnSize'> 후기 글의 수<br>4개
            </a>
         </div>
         <div class='col-4'>
            <a href='board/01.html'
               class='btn btn-outline-primary d-flex justify-content-center align-items-center adminMainBtnSize'> 신고 글의 수<br>5개
            </a>
         </div>
      </div>
      <div class='row mt-4'>
       	 <div class='offset-2 col-4'>
            <a href='board/01.html'
               class='btn btn-outline-primary d-flex justify-content-center align-items-center adminMainBtnSize'> 오늘 접속자 수<br>5명
            </a>
         </div>
         <div class='col-4'>
            <a href='board/01.html'
               class='btn btn-outline-primary d-flex justify-content-center align-items-center adminMainBtnSize'> 탈퇴 회원<br>5명
            </a>
         </div>
      </div>
       
</div>
</body>
</html>