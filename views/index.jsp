<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi">	
<meta name="format-detection" content="telephone=no">
<title>MORE PET</title>

<!-- body -->
<link rel="stylesheet" href="css/demo.css">
<script src='https://code.jquery.com/jquery-3.5.1.min.js'></script>
<script src='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js'></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
<link rel='stylesheet' href='http://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css'>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css" integrity="sha384-vp86vTRFVJgpjF9jiIGPEEqYqlDwgyBgEF109VFjmqGmIY/Y4HV4d3Gp2irVfcrp" crossorigin="anonymous">
<!-- font -->

</head>
<body>
    
<%@ include file="header.jsp" %>
    
   
    <!-- 메인사진 컨탠츠 영역 -->
   
     <div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel" style="padding-top: 150px; z-index: -1">
  <div class="carousel-inner">
    <div class="carousel-item active">
        <img src="images/main/desktop_image7.jpg" class="d-block w-100" style="object-fit: cover; width: 100%">
    </div>
    <div class="carousel-item">
        <img src="images/main/desktop_image3.jpg" class="d-block w-100" style="object-fit: cover; width: 100%">
    </div>
    <div class="carousel-item">
        <img src="images/main/desktop_image7.jpg" class="d-block w-100" style="object-fit: cover; width: 100%">
    </div>
  </div>

</div>
      
   <!-- 메인사진 컨탠츠 영역 -->
   <div class="container_m">
		
			<div class="codrops-header">
				<h1 style="margin-top: 50px;">믿을 수 있고 안심할 수 있어요 <span>Walking Sitter Meeting Report Shop</span><span>모든 플렛폼을 MORE PET 에서 즐겨보세요.</span></h1>	
			</div>
			
			<section>
				<figure class="stack stack-spread">
					
				</figure>
			</section>
			<section>
				<figure class="stack stack-fanout" style="margin: 0 0 0rem;">
				<span>어느 위치에서 산책하는지 실시간 GPS가 바로 기록돼요!</span>
					<img src="images/main/walk_img.png" style="object-fit: contain;">
				</figure>
			</section>
			<section style="background: rgb(252,252,252);">
				<h2 style="padding-top: 50px;">까다로운 펫시터 선발·관리 체계와 안전 시스템을 구축하였습니다</h2>
				<button style="margin-bottom: 100px;"><small>바로가기</small></button>
				<figure class="stack stack-randomrot" style="margin: 0 0 0rem;">
					<img src="images/main/sitter_img1.png" style="object-fit: contain; width: 135px; height: 162px; margin-right: 100px; margin-bottom: 100px;"/>
					<span style="margin-right: 100px; margin-bottom: 100px;"><small>4단계 신원 검증</small></span>
					<img src="images/main/sitter_img2.png" style="object-fit: contain; width: 135px; height: 162px; margin-right: 100px; margin-bottom: 100px;"/>
					<span style="margin-bottom: 100px;"><small>모든 돌봄 과정 촬영</small></span><br>
					<img src="images/main/sitter_img3.png" style="object-fit: contain; margin-right: 50px; margin-bottom: 100px;"/>
					<span style="margin-right: 100px; margin-bottom: 100px;"><small>최고 전문진과 교육 협업</small></span>
					<img src="images/main/sitter_img4.png" style="object-fit: contain; width: 135px; height: 162px; margin-right: 50px; margin-bottom: 100px;"/>
					<span style="margin-right: 50px; margin-bottom: 100px;"><small>안전 보상 프로그램</small></span>
				</figure>
			</section>
			<section style="background: rgb(253,242,242);">
				<h2 style="padding-top: 50px;">내 근처 반려동물 친구를 찾아보세요.</h2>
				<button style="margin-bottom: 50px;">이동버튼</button>
				<figure class="stack stack-sideslide" style="margin: 0 0 0rem;">
					<img src="images/main/meeting_img.png" style="object-fit: contain; margin-right: 50px; margin-bottom: 100px;"/>
					<span style=""><small>같이 산책할 모어펫 친구들을 찾아보세요.</small></span>
				</figure>
			</section>
			<section style="background: rgb(252,252,252);">
				<h2 style="padding-top: 50px;">상품의 결이 다른 질 좋은 SHOP</h2>
				<button style="margin-bottom: 50px;">이동경로</button>
				<figure class="stack stack-sideslide" style="margin: 0 0 0rem; padding-bottom: 100px;">
				
					<div class='container'>
					<div class="row">
					
					<div class="col-md-3">
					<div class="card" style="width: 18rem;">
					  <img src="images/main/sitter_img4.png" class="card-img-top" alt="..." style="object-fit:cover;">
					  <div class="card-body">
					    <p class="card-text">상품명 : cat blablabla</p>
					    <p class="card-text">가격 : ~~~원</p>
					  </div>
					</div>
					</div>
					
					<div class="col-md-3">
					<div class="card" style="width: 18rem;">
					  <img src="images/main/sitter_img4.png" class="card-img-top" alt="..." style="object-fit:cover;">
					  <div class="card-body">
					    <p class="card-text">상품명 : dog blablabla</p>
					    <p class="card-text">가격 : ~~~원</p>
					  </div>
					</div>
					</div>
					
					<div class="col-md-3">
					<div class="card" style="width: 18rem;">
					  <img src="images/main/sitter_img4.png" class="card-img-top" alt="..." style="object-fit:cover;">
					  <div class="card-body">
					    <p class="card-text">상품명 : dog blablabla</p>
					    <p class="card-text">가격 : ~~~원</p>
					  </div>
					</div>
					</div>
					
					<div class="col-md-3">
					<div class="card" style="width: 18rem;">
					  <img src="images/main/sitter_img4.png" class="card-img-top" alt="..." style="object-fit:cover;">
					  <div class="card-body">
					    <p class="card-text">상품명 : dog blablabla</p>
					    <p class="card-text">가격 : ~~~원</p>
					  </div>
					</div>
					</div>
					
					</div>
					</div>
				</figure>
			</section>
			<section style="background: rgb(255,255,255);">
				<h2 style="margin-top: 50px;">App Download</h2>
					<button style="margin-bottom: 50px;"><i class="fab fa-android" style="font-size: 50px;"></i></button>
					<button style="margin-bottom: 50px;"><i class="fab fa-apple" style="font-size: 50px;"></i></button>
				<figure class="stack stack-fanout" style="margin: 0 0 0rem;">
					<img src="images/main/app_m.png" style="object-fit: contain;">
				</figure>
					
			</section>
			
			
		</div>

     <%@ include file="footer.jsp" %>
</body>
</html>
