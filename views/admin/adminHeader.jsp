<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <link rel='stylesheet' href='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css' />
<script src="js/default.js"></script>
<link rel="stylesheet" href="css/default.css">
<link rel="stylesheet" href="css/index.css">
<link rel="stylesheet" href="css/header_bar.css">
<link rel="stylesheet" media="( min-width:701px ) and ( max-width:1000px )" href="css/tablet.css">
<link rel="stylesheet" media="( min-width:0px ) and ( max-width:700px )" href="css/mobile.css">
<link rel="stylesheet" href="css/starability-all.min.css">
<header>
     <div id="socketAlert" class="alert alert-info" role="alert" style="display: none;"></div>
        <div class="left">
            <h1><a href="index.do"></a></h1>
            <a href="#a" class="all"></a>
            <div class="nav">
                <h2>Menu</h2>
                
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