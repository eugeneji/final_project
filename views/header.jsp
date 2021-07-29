<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="js/default.js"></script>
<script>
function openToggle(){
	if($('#toggleBar').hasClass('closeToggle')){
		$('#toggleBar').addClass('openToggle');
		$('#toggleBar').removeClass('closeToggle');
	}else{
		$('#toggleBar').removeClass('openToggle');
		$('#toggleBar').addClass('closeToggle');
	}
	
	
}
</script>
<style>
#toggleBar{
position:absolute; 
background-color: white; 
overflow: hidden; 
transition: 0.5s;
border-radius:  0px 0px 10px 10px;
}
.closeToggle{
height: 0px;
}
.openToggle{

height: calc(33px*7);
border-bottom-width: 3px;
border-bottom-style: solid;
border-bottom-color: #E0E0E0;

}
.toggleItem{
padding: 7px 0px 7px 0px;
font-size: 13px;
width: 96px;
height: 33px;
text-align: center;
}
.toggleItem:hover{
color: #94b8ff;
}
</style>
<link rel="stylesheet" href="css/default.css">
<link rel="stylesheet" href="css/index.css">
<link rel="stylesheet" href="css/header_bar.css">
<link rel="stylesheet" media="( min-width:701px ) and ( max-width:1000px )" href="css/tablet.css">
<link rel="stylesheet" media="( min-width:0px ) and ( max-width:700px )" href="css/mobile.css">
<link rel="stylesheet" href="css/starability-all.min.css">
    
     <header>
     <div id="socketAlert" class="alert alert-info" role="alert" style="display: none; z-index: 5;"></div>
        <div class="left">
            <h1><a href="index.do"></a></h1>
            <a href="#a" class="all"></a>
            <div class="nav">
                <h2>Menu</h2>
                <nav>
                    <ul>
                    <li><a href="walk_stats.do">산책</a></li>
                    <li><a href="bookMain.do">시터</a></li>
                    <li><a href="meeting.do">모임</a></li>
                    <li><a href="goShopList.do">쇼핑몰</a></li>
                    <li><a href="lostPet.do">유기동물</a></li>
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
        <li class="join">
       		<c:choose>
       			<c:when test="${empty sessionScope.s_user}">
       				<a href="userJoin.do">Join us</a>
       			</c:when>
       			<c:otherwise>
       				<a href="javascript:openToggle();">My</a>
       				<div id="toggleBar" class="closeToggle">
       					<div class="toggleItem" onclick="location.href='myInformation.do'">마이페이지</div>
       					<div class="toggleItem" onclick="location.href='pet_list.do'">반려동물 리스트</div>
       					<div class="toggleItem" onclick="location.href=''">내가 작성한 글</div>
       					<div class="toggleItem" onclick="location.href='goWishList.do'">위시리스트</div>
       					<div class="toggleItem" onclick="location.href='goCartList.do'">장바구니</div>
       					<div class="toggleItem" onclick="location.href='orderList.do'">구매내역</div>
       					<div class="toggleItem" onclick="location.href='bookList.do'">예약내역</div>
       				</div>
       			</c:otherwise>
       		</c:choose>
        </li>
       
        </ul>
    </header>
    <div class="dim"></div>






