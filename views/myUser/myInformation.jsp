<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.my_ul{border: 1px solid gray;}
	.my_ul >li {border: 1px solid gray;}
	#my_one{ display: none;}
	#my_two{display: none;}
	div.mb-3{margin-top: 10%;
	margin-left: 40%;
		}
	
</style>
<link rel="stylesheet" href="//stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="//stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src='https://code.jquery.com/jquery-3.5.1.min.js'></script>
<script type="text/javascript">
function open(one) {
	if(document.getElementById(one).style.display=='none'){
		
		document.getElementById(one).style.display='block';
	}else{
		document.getElementById(one).style.display='none';
	}
}
</script>
</head>
<body>
<%@ include file="../header.jsp" %>
<div class='container' style="padding-top: 150px;">
	<div class="row">
	    <input type="hidden" name="user_idx" value="${dto.user_idx}">
	    <input type="hidden" name="user_nickname" value="${sessionScope.s_user.user_nickname}">
	    <div class="col-xs-12">
	    	<div style="padding-top: 48px;">
	    		<div class="card">
				  <div class="card-header">
				    마이페이지
				  </div>
				  <div class="card-body">
				 <div class='col-xs-6' style="margin: 0px auto">
	    		<img src="${pageContext.request.contextPath}/user/${dto.user_idx}/profile.png" style="width: 200px; height: 200px; margin: 0px auto; display: block;">
	    			</div>   
				    <div class="row">
			
				      <div class='col-6'>
				      	아이디 :<p>${dto.user_email}</p>
				      </div>
				      <div class='col-6'>
				      	전화번호 :<p>${dto.user_tel}</p>
				      </div>
				       <div class='col-6'>
				      	주소 :<p>${dto.user_addr}</p>
				      </div>
				      <div class='col-6'>
				      	상세주소 :<p>${dto.user_addr_detail}</p>
				      </div>
				       <div class="mb-3">
    					 <input type="submit" class="btn btn-primary" value="수정" id="userContent" onclick="location.href='userConfirm.do?user_idx=${dto.user_idx}'";/>
    					</div>
				      </div>
				     </div>
				    
				  </div>
				</div>
	    	</div>
		</div>
    </div>
<%@ include file="../footer.jsp" %>
</body>
</html>