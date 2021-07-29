<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<link rel="stylesheet" href="css/starability-all.min.css">
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>
	<div class='container' style="padding-top: 150px;">
		
		<div class="col-sm-12 mt-5 mb-5" style="height: auto;">
			<h3 class="text-center titleFont " >MORE PET 시터 후기</h3>
			<c:forEach var="review" items="${reviewList}">
			<c:if test="${!empty review.review_img }">
			<div class="reviewDto col-sm-6 mt-5 p-1 rounded font" style="background-color: white; border-radius:10px; box-shadow: rgb(235, 235, 235) 1px 1px 12px 0px;">
				
				<div id="carousel-example-generic${review.review_idx }" class="carousel slide col-sm-12 p-0">
					<ol class="carousel-indicators">
					<c:forEach var="idx" begin="0" end="${fn:length(review.review_img)-1}">
						<li data-target="#carousel-example-generic${review.review_idx }" data-slide-to="${idx}" class="active"></li>
					</c:forEach>
					</ol>
					<div class="carousel-inner col-sm-12" role="listbox">
					<c:forEach var="idx" begin="0" end="${fn:length(review.review_img)-1 }">
						<div class="item ${idx == '0'? 'active' : ''} rounded">
							<img src="${pageContext.request.contextPath}/review/${review.book_idx}/${idx}.png" style=" object-fit: fill ;width: 100%;">
							<div class="carousel-caption" style="color: white;">시터 집안 이미지</div>
						</div>
					</c:forEach>
					</div>
					<a class="left carousel-control" href="#carousel-example-generic${review.review_idx }" role="button" data-slide="prev">
						<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
					</a>
					<a class="right carousel-control" href="#carousel-example-generic${review.review_idx }" role="button" data-slide="next">
						<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
					</a>
				</div>
				
				
				<div class="sitterInfo col-sm-12 " >
					<div class="pt-5"></div>
					<div class="col-sm-12">
						<div class="col-xs-6 font ">${review.pet_name += ' 보호자님'}</div>
						<div class="col-xs-6 ">
							<fieldset class="starability-fade float-right"> 
	
							     <input type="radio"   value="1" disabled="disabled" ${review.star == '1' ? 'checked' : ''}/>
							    <label for="rate5" title="Amazing">5 stars</label>
							
							    <input type="radio"   value="2" disabled="disabled" ${review.star == '2' ? 'checked' : ''}/>
							    <label for="rate4" title="Very good">4 stars</label>
							
							    <input type="radio"  " value="3" disabled="disabled" ${review.star == '3' ? 'checked' : ''}/>
							    <label for="rate3" title="Average">3 stars</label>
							
							    <input type="radio"   value="4" disabled="disabled" ${review.star == '4' ? 'checked' : ''}/>
							    <label for="rate2" title="Not good">2 stars</label>
							
							    <input type="radio"   value="5" disabled="disabled" ${review.star == '5' ? 'checked' : ''}/>
							    <label for="rate1" title="Terrible">1 star</label>
							    
	  						</fieldset>
						
						</div>
						
					</div>
					<div class="col-sm-12" style="height: 150px;">${review.review_content }</div>
					<div class="text-center col-sm-12">
						<span style="border-radius:12px; background-color: white; display:inline-block; height: 30px;">
       						<button class="btn btn-outline-warning font" style="border-radius:12px; width: 150px; height: 30px; font-size: 15px" onclick="location.href='reviewContent.do?review_idx=${review.review_idx}'">자세히 보기</button>
       					</span>
					</div>
					<div class="col-sm-12 mt-5"> 이 후기의 펫시터가 궁금 하다면?</div>
					<div class="col-sm-12 p-3" onclick="location.href='sitterProfile.do?user_idx=${review.sitter_idx}'">
						<div class="col-sm-12 pt-3" style="height:90px; background-color: lightgray">
							<div style="float: left; margin-right: 10px;">
								<img src="${pageContext.request.contextPath}/user/${review.sitter_idx}/profile.png" style="width: 70px; height: 70px; border-radius: 20px;">
							</div>
							<div>
								<div style="font-size: 15px;">${review.sitter_name +='펫시터 . ' += review.sitter_addr}</div>
								<div>${review.subject }</div>
							</div>
						</div>
					</div>
				</div>
				
			</div>
			</c:if>
			</c:forEach>
		</div>	
	</div>	
<%@ include file="/WEB-INF/views/footer.jsp" %>

</body>
</html>