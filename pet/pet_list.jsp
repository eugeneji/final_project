<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="//stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="//code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
function pet_detail(idx){
	location.href="pet_update.do?pet_idx="+idx;
}
</script>
</head>
<body>
<%@ include file="../header.jsp" %>
<div class="container" style="padding-top: 150px; color: #4b5f5a; font-family: 'Lato', Arial, sans-serif; margin-bottom: 80px;">
	<div class="row">
		<div class="col-xs-10 col-sm-10 col-md-10 " style="width:100%; height: 100%; margin:0px auto; background-color: white; border-radius: 15px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.35); padding-bottom: 20px;">
			<h1 style="text-align: center; margin: 30px;">반려동물 목록 <i style="font-style: normal; font-variant: normal; text-rendering: auto; line-height: 1; display: inline-block; font-size: 25px; background-image: url('${pageContext.request.contextPath}/images/plus_icon.png'); background-size: cover; border-radius: 100%;" onclick="location.href='pet_register.do'">　</i></h1>
			<div id="pet_list_form">
				<c:forEach items="${pet_list}" var="pet">
					<div class="col-xs-6 col-sm-3 col-md-3" >
						<div class="col-xs-12" onclick="pet_detail(${pet.PET_IDX});" style="cursor: pointer; padding-bottom: 100%; background: url('${pageContext.request.contextPath}/pet/${pet.PET_IDX}/profile.png'); background-size: cover; border-radius: 100%; border-style: solid; border-width: 3px; border-color: #94b8ff; box-sizing: border-box;"></div>
						<div class="col-xs-12" style="text-align: center; font-size: 15px; font-weight: bold; margin-top: 8px;">${pet.PET_NAME}</div>
					</div>
				</c:forEach>
				<c:if test="${empty pet_list}">
					<div class="col-xs-12">
						<div style="width: 50%; height: 150px; line-height: 150px; text-align: center; margin: 0px auto; color: #757575; font-size: 15px;">등록된 반려동물이 없습니다.</div>
					</div>
				</c:if>
			</div>
		</div>
	</div>
</div>
<div class="col-xs-12 col-sm-12 col-md-12" style="width: 100vw; padding: 0px;">
	<%@ include file="../footer.jsp" %>
</div>
</body>
</html>