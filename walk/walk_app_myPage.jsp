<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="//stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
</head>
<script>
function updatePet(idx){
	var url= 'm_walk_app_petUpdate.do?pet_idx='+idx;
	Android.more_intent(url);
}
function userUpdate(){
	var url= 'm_walk_app_petRegister.do';
	Android.more_intent(url);
}
function android_logout(){
	Android.logout();
}
</script>
<body>
<div class="container" style="padding-top: 25px;">
	<div class="row" style="padding: 0px;">
		<div style="width: 95vw; margin: 0px auto;">
			<div class="col-xs-12" style="">
				<div class="col-xs-9" style="font-size: 17px; font-weight: bold;"><i style="background: url('${pageContext.request.contextPath}/images/profile_icon.png'); background-size: cover;width: 15px;height: 15px;display: inline-block;background-repeat: no-repeat; vertical-align: middle;">　</i>　사용자</div>
				<div class="col-xs-3" style="font-size: 17px; font-weight: bold; text-align: right;" onclick="userUpdate();">수정</div>
			</div>
			<hr class="col-xs-12" style="width: 90%; margin: 10px auto;">
			<div class="col-xs-12" style="height: 70px; line-height: 30px;" onclick="userUpdate();">
				<div class="col-xs-4" style="vertical-align: middle; margin-left: 10px;">
					<div style="font-size: 17px;">${dto.user_name}</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row" style="padding: 0px;">
		<div style="width: 95vw; margin: 0px auto; ">
			<div class="col-xs-12" style="">
				<div class="col-xs-9" style="font-size: 17px; font-weight: bold;"><i style="background: url('${pageContext.request.contextPath}/images/woo_icon.png'); background-size: cover;width: 20px;height: 20px;display: inline-block;background-repeat: no-repeat; vertical-align: middle;">　</i>　반려동물</div>
				<div class="col-xs-3" style="font-size: 17px; font-weight: bold; text-align: right;">추가</div>
			</div>
			<hr class="col-xs-12" style="width: 90%; margin: 10px auto;">
			<c:forEach var="list" items="${list}">
				<div class="col-xs-12" style="height: 70px; margin: 5px 0px; line-height: 50px;" onclick="updatePet('${list.PET_IDX}')">
					<div class="col-xs-11" >
						<div style="vertical-align: middle; display: inline-block; background-image: url('${pageContext.request.contextPath}/pet/${list.PET_IDX}/profile.png'); background-size:cover; width: 30px; padding-bottom:30px; border-radius: 100%;"></div>
						<div style="vertical-align: middle; display:inline-block; line-height: 30px; font-size: 17px;">　${list.PET_NAME}</div>
					</div>
					<div class="col-xs-1" style=" margin-top: 15px; vertical-align: middle; background-image: url('${pageContext.request.contextPath}/images/right.png'); padding: 0px; background-size:cover; width: 20px; height: 20px;"></div>
				</div>
			</c:forEach>
			<c:if test="${empty list}">
				<div class="col-xs-12" style="height: 70px; margin: 5px 0px; line-height: 50px;")">
					<div class="col-xs-12" style="line-height: 70px; height: 70px; text-align: center; color:#757575;">등록된 반려동물이 없습니다.</div>
				</div>
			</c:if>
		</div>
	</div>
	<div class="row" style="margin-top: 40px;">
		<div  style="width: 95vw; margin: 0px auto; ">
			<div class="col-xs-12">
				<div class="col-xs-12" onclick="android_logout();" style="font-size: 17px; height: 50px; border-style: solid; border-width: 2px; border-color: #E0E0E0; line-height: 50px; font-weight: bold;"><i style="background: url('${pageContext.request.contextPath}/images/logout_icon.png'); background-size: cover;width: 15px;height: 15px;display: inline-block;background-repeat: no-repeat; vertical-align: middle;">　</i>　로그아웃</div>
			</div>
		</div>
	</div>
	<div class="row" style="margin-top: 40px;">
		<div class="col-xs-12">
			<div style="text-align: center; margin: 0px auto; font-size: 12px; color: #757575; height: 50px;">서비스 이용약관</div>
			<div style="text-align: center; margin: 0px auto; font-size: 12px; color: #757575; height: 50px;">위치 서비스 이용약관</div>
		</div>
	</div>
</div>
</body>
</html>