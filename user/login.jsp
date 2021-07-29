<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<link rel='stylesheet' href='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css' />
<body>
<%@ include file="../header.jsp" %>
<div class='container' style="padding-top: 150px;">
	<a href="javascript:kakaoLogin();"><img
		scr=https://www.gb.go.kr/Main/Images/ko/member/certi_kakao_login.png /></a>
	<div id ="loginWrap">	
	<c:if test="${not empty cookie.saveid.value}">
		<c:set value="checked" var="checked" />
	</c:if>
	
	<div class="card" style="width: 40rem; margin: 150px auto;">
  <div class="card-body">
    <h5 class="card-title" style="text-align: center;">Login</h5><br>
    <h6 class="card-subtitle col-md-6 text-muted" style="text-align: center;"></h6>
    <p class="card-text">
		<form name="loginCheck" action="loginCheck.do" method="post">
		
			<div class="row">
				<div class="col-xs-4 col-sm-4" style="text-align: center;">이메일</div>
				<div class="col-xs-8 col-sm-8">
				<input type="text" name="user_email"
				value="${cookie.saveid.value}"  class= "text" style="text-align: left;">
				</div>
			</div>
			
			<br>
			
			<div class="row">
				<div class="col-xs-4 col-sm-4" style="text-align: center;">비밀번호</div>
				<div class="col-xs-8 col-sm-8"><input type="password" name="user_pwd"  class= "text" style="text-align: left;"></div>
			</div>
			
			<br>
			
			<div class="row">
				<div class="col-xs-12 col-sm-12" style="text-align: center;">이메일 기억하기
				<input type="checkbox" id="saveid"
					name="saveid"
					<c:if test="${not empty cookie.saveid.value}">checked='checked'</c:if>><br>
			
			<div class="d-grid gap-2 col-6 mx-auto">
			  <button class="btn btn-primary" type="submit" id="loginbtn">로그인</button>
			</div>
						
				<br>
				<a href="findId.do">아이디를 찾기</a><br>
				<a href="findPwd.do">비밀번호를 잊으셨나요?</a></div><br><br>
				
				<div class="col-xs-12 col-sm-12" style="text-align: center;">
				<a id="kakao-login-btn"></a> <a
				href="http://developers.kakao.com/logout"></a>
				</div>
			</div>
	
		
		<script type='text/javascript'>
			Kakao.init('13e68cd504b2e3e8e1a913d636ed1128');
			Kakao.Auth.createLoginButton({
				container : '#kakao-login-btn',
				success : function(authObj) {
					alert(JSON.stringify(authObj));
				},
				fail : function(err) {
					alert(JSON.stringify(err));
				}
			});
		</script>
	</form>
	</p>

  </div>
</div>
	
	
	
	</div>

</div>
<%@ include file="../footer.jsp" %>
</body>
</html>