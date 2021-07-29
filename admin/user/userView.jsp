<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel='stylesheet' href='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css' />
<script type="text/javascript">
function showBen(user_idx) {
	if(confirm('정말 ben하시겠습니까?')){
		location.href='userBen.do?user_idx='+user_idx;
			/* alert("ben되었습니다."); */
	    }else {
	        
	    }

}
function showBenCancel(user_idx) {
	if(confirm('정말 ben을 취소하시겠습니까?')){
		location.href='userBenCancel.do?user_idx='+user_idx;
		/* window.location.reload(); */
			/* alert("ben되었습니다."); */
	    }else {
	        
	    }
}
</script>
</head>
<body>
<div class='container'>
 <!-- include : nav  해더에 포함하는게 좋을듯 ?-->
      <nav class='nav justify-content-center'>
         <a class='nav-link p-2' href="insertItemForm.do"><small>상품 등록</small></a> 
         <a class='nav-link p-2' href="selectItemForm.do"><small>상품 관리하기</small></a> 
         <a class='nav-link p-2' href="stockManageForm.do"><small>재고 관리하기</small></a> 
         <a class='nav-link p-2' href="orderManageForm.do"><small>주문 관리하기</small></a> 
         <a class='nav-link p-2' href='#'><small>매출 현황</small></a>
         <a class='nav-link p-2' href="test.do"><small>테스트</small></a>
         <a class='nav-link p-2' href="adminSitterAccept.do"><small>시터 신청</small></a>
         <a class='nav-link p-2' href="adminSitterList.do"><small>시터관리</small></a>
         <a class='nav-link p-2' href="adminChat.do"><small>채팅</small></a>
      </nav>

  	<div class='gnbBar'>
    	<hr class='line'>
    </div>
    
    <!-- /include : nav  -->
     <div class="main">
         <h3>회원 관리</h3> 
      </div>
      
      <div class='row'>
      	<div class='offset-2 col-4'>
        	<img src="..." class="img-thumbnail" alt="...">
        </div>
        <div class='col-4'>
        	<div class='form-group row'>
				<label for='userId' class='col-3 col-form-label'>이름</label>
				<div class='col-9'>
					<input type='email' class='form-control' id='userId' name='userId'
						readonly value='${dto.user_name}' />
				</div>
			</div>
        </div>
      </div>
      
    <div class='gnbBar'>
    	<hr class='line'>
    </div>
      
      <div class="row">
   		<div class='col-md-6'>
			<label for='userNick' class='col-6 col-form-label'>회원번호</label>
			<div class='col-9'>
				<input type='text' class='form-control' id='userNick' name='userNick' value='${dto.user_idx}' readonly />
			</div>
		</div>
		
    	<div class='col-md-6'>
			<label for='userNick' class='col-6 col-form-label'>성별</label>
			<div class='col-9'>
				<input type='text' class='form-control' id='userNick' name='userNick' value="${dto.user_sex eq '1'?'남':'여'}" readonly />
			</div>
		</div>
		
		<div class='col-md-6'>
			<label for='userNick' class='col-6 col-form-label'>아이디</label>
			<div class='col-9'>
				<input type='text' class='form-control' id='userNick' name='userNick' value='${dto.user_email}' readonly />
			</div>
		</div>
		
		<div class='col-md-6'>
			<label for='userNick' class='col-6 col-form-label'>전화번호</label>
			<div class='col-9'>
				<input type='text' class='form-control' id='userNick' name='userNick' value='${dto.user_tel}' readonly />
			</div>
		</div>
		
		<div class='col-md-6'>
			<label for='userNick' class='col-6 col-form-label'>회원등급</label>
			<div class='col-9'>
				<input type='text' class='form-control' id='userNick' name='userNick' value='${dto.user_grade}' readonly />
			</div>
		</div>
		
		<div class='col-md-6'>
			<label for='userNick' class='col-6 col-form-label'>가입날짜</label>
			<div class='col-9'>
				<input type='text' class='form-control' id='userNick' name='userNick' value='${dto.user_joindate}' readonly />
			</div>
		</div>
		
		<div class='col-md-6'>
			<label for='userNick' class='col-6 col-form-label'>주소</label>
			<div class='col-9'>
				<input type='text' class='form-control' id='userNick' name='userNick' value='${dto.user_addr}' readonly />
				<input type='text' class='form-control' id='userNick' name='userNick' value='${dto.user_addr_detail}' readonly />
			</div>
		</div>
		
	</div>
   
   <div class='gnbBar'>
    	<hr class='line'>
    </div>
    
   <div class='row justify-content-end'>
   <c:choose>
   		<c:when test="${dto.user_grade eq 'ben'}">
			<button type='button' class='btn btn-outline-info mr-2 mt-3' onclick="showBenCancel(${dto.user_idx})">Cancel</button>
		</c:when>
		<c:otherwise>
			<button type='button' class='btn btn-outline-info mr-2 mt-3' onclick="showBen(${dto.user_idx})">ben</button>
		</c:otherwise>
   </c:choose>
		<button type='submit' class='btn btn-outline-primary mt-3'>알림</button>
	</div>
   
</div>
</body>
</html>