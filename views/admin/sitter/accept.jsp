<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>
<div class="container font" style="padding-top: 150px;">
<h1>시터신청</h1>
<table>
	<thead>
		<tr>
			<th>번호</th>
			<th>이름</th>
			<th>날짜</th>
			<th>상태</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach var="dto" items="${list}">
		<tr onclick="location.href='applyContent.do?apply_idx=${dto.apply_idx}'" style="cursor:hand">
			<td>${dto.apply_idx }</td>
			<td><img src="${pageContext.request.contextPath}/user/${dto.user_idx}/profile.png" style="width: 50px; height: 50px;">${dto.user_name }</td>
			<td>${dto.apply_date}</td>
			<td>${dto.approval eq 2 ? '대기':dto.approval eq 1? '승인':'거절' }</td>
		</tr>
	</c:forEach>
	</tbody>
	<tfoot>
		<tr>
			<td colspan="4" style="text-align: center;">${page}</td>	
		</tr>
	</tfoot>
</table>
</div>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>