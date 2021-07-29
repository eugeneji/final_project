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
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="container" style="padding-top: 150px;">
	<ul style="font-size: 20px;">
		<li><a href = "sitterProfile.do?user_idx=${sessionScope.s_user.user_idx }">프로필 </a></li>
		<li><a href = "bookSitterList.do">예약현황</a></li>
		<li><a href = "review.do">후기</a></li>
		<li><a href = "income.do">통계</a></li>
	</ul>
</div>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>