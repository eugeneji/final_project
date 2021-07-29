<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi">	
<meta name="format-detection" content="telephone=no">
<title>MORE PET</title>
<!-- body -->
<script src='https://code.jquery.com/jquery-3.5.1.min.js'></script>
<script src='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js'></script>
<link rel='stylesheet' href='http://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css'>
<link href="css/lostpet/lostpet.css" rel="stylesheet"/>
</head>
<body>
<%@include file="/WEB-INF/views/header.jsp"%>
    <!-- 해더 아래 구분선 -->
    <div class='reviewBar'>
         <hr>
		<div class='reviewBarFont'><a href="petCenter.do">유기동물</a></div>
		<div class='reviewBarFont'><a href="findBbsList.do">강아지&고양이를 찾습니다</a></div>
         <div class='reviewBarFont'><a href="reportBbsList.do">제보하기</a></div>
         <hr>
      </div>
    <!-- body 컨탠츠 영역 -->
    <div class='container' style="padding-top: 150px;">
    
      <div class='carousel slide' data-ride='carousel'>
      <div id='mainCarou' class='carousel slide' data-ride='carousel'>
            <ol class='carousel-indicators'>
               <li data-target='#mainCarou' data-slide-to='0'></li>
               <li data-target='#mainCarou' data-slide-to='1'></li>
               <li data-target='#mainCarou' data-slide-to='2'></li>
            </ol>
            <div class='carousel-inner'>
               <div class='carousel-item active'>
                  <div class='carouImg' style="background-color: white;"></div>
                  <div class='carousel-caption text-dark' style="background-color: white;">
                  <img src="data:image/jpeg;base64,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" width="800" height="500">
                     <a href='petCenter.do' class="font">동물보호소목록 바로가기</a>
                  </div>
               </div>
               <div class='carousel-item'>
                  <div class='carouImg' style="background-color: white;"></div>
                  <div class='carousel-caption text-dark' style="background-color: white;">
               <img src="https://i.pinimg.com/originals/64/5f/b6/645fb6bea40e1f430d8c73ecefcc99e1.jpg" width="800" height="500">
                    <a href='findBbsList.do' class="font">애완동물 찾기게시판 바로가기</a>
                  </div>
               </div>
               <div class='carousel-item'>
                  <div class='carouImg' style="background-color: white;"></div>
                  <div class='carousel-caption text-dark' style="background-color: white;">
                                    <img src="https://t1.daumcdn.net/cfile/blog/1927DD0B4B93B1AE11" width="800" height="500">
                     <a href='reportBbsList.do' class="font">제보게시판으로 바로 가기</a>
                  </div>
               </div>
            </div>
            <a href='#mainCarou' class='carousel-control-prev' data-slide='prev'>
               <span class='carousel-control-prev-icon'></span>
            </a> <a href='#mainCarou' class='carousel-control-next' data-slide='next'>
               <span class='carousel-control-next-icon'></span>
            </a>
         </div>
      </div>
      <div class='reviewBar'>
         <hr>
         <div class='reviewBarFont'>유기동물</div>
         <hr>
      </div>

     <div class='card-deck mt-3'>
         <div class='card'>
            <div class='reviewImg' style="background-color: white;">
  <img src="http://ojsfile.ohmynews.com/STD_IMG_FILE/2017/0331/IE002135087_STD.jpg" width="245" height="295"></div>
            <div class='card-body'>
               <h5 class='card-title'>이름:냥냥이</h5>
               <p class='card-text'>성별:암컷</p>
               <p class='card-text'>발견장소:이젠아카데미</p>
            </div>
            <div class='card-footer'>
               <small class='text-muter'>2020-11-20</small>
            </div>
         </div>
         <div class='card'>
            <div class='reviewImg' style="background-color: white;"><img src="https://youthpress.net/xe/files/attach/images/9766/285/168/4366a63f8ae1de561d28c4e352c3ed78.jpg" width="245" height="295"></div>
            <div class='card-body'>
               <h5 class='card-title'>이름:멍멍이</h5>
               <p class='card-text'>성별:수컷</p>
               <p class='card-text'>발견장소:서대문구 노란통닭</p>
            </div>
            <div class='card-footer'>
               <small class='text-muter'>2020-11-26</small>
            </div>
         </div>
         <div class='card'>
            <div class='reviewImg'  style="background-color: white;"><img src="https://cdn.imweb.me/upload/S201905275cebd06fa6a7e/99656042f4e7e.jpeg" width="245" height="295"></div>
            <div class='card-body'>
               <h5 class='card-title'>이름:몽실이</h5>
               <p class='card-text'>성별:수컷</p>
               <p class='card-text'>발견장소:부평문화의거리</p>
               <p class='card-text'></p>
            </div>
            <div class='card-footer'>
               <small class='text-muter'>2020-11-20</small>
            </div>
         </div>
         <div class='card'>
            <div class='reviewImg'  style="background-color: white;"><img src="http://img.segye.com/content/image/2020/01/17/20200117511981.jpg" width="245" height="295"></div>
            <div class='card-body'>
               <h5 class='card-title'>이름:순심이</h5>
               <p class='card-text'>성별:암컷</p>
               <p class='card-text'>발견장소:강남 논현동</p>
            </div>
            <div class='card-footer'>
               <small class='text-muter'>2020-11-20</small>
            </div>
         </div>
      </div>
      
       <div class='reviewBar'>
         <hr>
      </div>
   <!-- include : footer  -->
   <%@ include file="/WEB-INF/views/footer.jsp" %>
   </div>
</body>
</html>
