<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="../header.jsp" %>

<div class='container' style="padding-top: 150px;">

	<form name="meeting_s_write_add" action="meeting_s_write_add.do" method="post">
	
	 <div class='card-deck mt-3'>
         <div class='card'>
            <div class='reviewImg'>img</div>
            <div class='card-body'>
               <p class='card-text'>이름 : <input type="text" name="user_nickname" value="${sessionScope.s_user.user_nickname}" readonly="readonly"></p>
               <p class='card-text'>사진 : <input type="file" name="meeting_s_img"></p>
               <p class='card-text'>내용 : <textarea name="meeting_s_content" rows="200" cols="200"></textarea></p>
               <input type="text" name="user_idx" value="${sessionScope.s_user.user_idx}">
               <input type="text" name="user_img" value="${sessionScope.s_user.user_img}">
               <input type="text" name="user_x" value="${sessionScope.s_user.user_x}">
               <input type="text" name="user_y" value="${sessionScope.s_user.user_y}">
            </div>
            
            <div class='card-footer'>
               <small class='text-muter'>
               		<input type="submit" value="작성">
               </small>
            </div>
         </div>  
      </div>
	</form>
</div>
<%@ include file="../footer.jsp" %>
</body>
</html>