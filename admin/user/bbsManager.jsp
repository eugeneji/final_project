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
      
      <form action="userSearch.do">
    <div class="row">
      <div class="col-md-4">
      	<div class="input-group mb-3">
		  <label class="input-group-text" for="inputGroupSelect01">Options</label>
		  <select class="form-select" id="inputGroupSelect01">
		    <option selected>게시물</option>
		    <option value="more_sitter">시터</option>
		    <option value="more_meeting_m">모임</option>
		    <option value="more_">제보하기</option>
		    <option value="more_">찾아요</option>
		  </select>
		</div>
	 </div>
	 <div class="col-md-4">
      	<div class="input-group mb-3">
		  <label class="input-group-text" for="inputGroupSelect01">Options</label>
		  <select class="form-select" id="inputGroupSelect01">
		    <option selected>세부사항</option>
		    <option value="user_nickname">닉네임</option>
		    <option value="meeting_m_subject">제목</option>
		    <option value="meeting_m_writedate">작성날짜</option>
		  </select>
		</div>
	 </div>
	 
		 <div class="col-md-4">
			 <div class="input-group mb-3">
		 	 <input type="text" class="form-control" placeholder="Keyword를 선택하여 검색하기" aria-label="Recipient's username" aria-describedby="button-addon2">
		 	 <button class="btn btn-outline-secondary" type="submit" id="button-addon2">검색</button>
			</div>
		</div>
     </div>
     </form>
      
      <div class='row'>
        	<table class="table">
			  <thead>
			    <tr>
			      <th scope="col">#</th>
			      <th scope="col">회원번호</th>
			      <th scope="col">제목</th>
			      <th scope="col">이름</th>
			      <th scope="col">작성날짜</th>
			    </tr>
			  </thead>
			  <tbody>
			  <c:forEach var="arr" items="${list_m}">
			    <tr>
			      <th scope="row">-</th>
			      <td>${arr.user_idx}</td>
			      <td><a href="meeting_m_content.do?meeting_m_idx=${arr.meeting_m_idx}&user_idx=${arr.user_idx}">${arr.meeting_m_subject}</a></td>
			      <td>${arr.user_nickname}</td>
			      <td>${arr.meeting_m_writedate}</td>
			    </tr>
			 </c:forEach>
			  </tbody>
			</table>
      </div>
      
      		<!-- 페이징 부분 -->  
		<div class='d-flex justify-content-center mt-3'>
			<ul class='pagination'>
				<li class='page-item'>${pageStr}</li>
			</ul>
		</div>
       
</div>
</body>
</html>