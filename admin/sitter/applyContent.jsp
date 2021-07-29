<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script>
function applyResult(button){
	//[타입(chat/alarm), to_idx, message]
	send('alarm', ${dto.user_idx},'시터 신청이 '+button.innerText+' 되었습니다');
	location.href='insertSitter.do?user_idx='+${dto.user_idx}+'&apply_idx='+${dto.apply_idx}+'&approval='+button.value;
}

</script>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>
<div class="container" style="padding-top: 150px;">
<table class="table font" style="border: 1px solid gray;">
	<tr>
		<td rowspan="2" style="width: 160px;"><img style="width: 150px; height: 150px;"src="${pageContext.request.contextPath}/user/${dto.user_idx}/profile.png"></td>
		<td>성명</td>
		<td>${dto.user_name}</td>
		<td>날짜</td>
		<td>${dto.apply_date }</td>
	</tr>
	<tr>
		<td>성별</td>
		<td>${dto.user_sex eq 1 ? '남자':'여자' }</td>
		<td>상태</td>
		<td>${dto.approval eq 2 ? '대기' : dto.approval eq 1 ? '승인':'거절' }</td>
	</tr>
	<tr>
		<td>주소</td>
		<td colspan="4">${dto.user_addr} ${dto.user_addr_detail}</td>
	</tr>
	<tr>
		<td>은행</td>
		<td>국민</td>
		<td>계좌번호</td>
		<td colspan="2">${dto.account}</td>
	</tr>
	<tr>
		<td>전화</td>
		<td>${dto.user_tel}</td>
		<td>E-mail</td>
		<td colspan="2">${dto.user_email}</td>
	</tr>
	<tr>
		<td colspan="2" style="text-align: center;"><img style="width: 300px;" height="200px;" src="${pageContext.request.contextPath}/sitter/${dto.user_idx}/license.png"></td>
		<td colspan="3"><textarea style="height: 200px;">${dto.introduce}</textarea></td>
	</tr>
	<tr>
		<td colspan="5" style="text-align: center;"><button value="1" onclick="applyResult(this);">승인</button><button value="0" onclick="applyResult(this);">거절</button></td>
	</tr>
</table>

</div>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>