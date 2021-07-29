<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>전국 동물보호소</title>
</head>
<script src='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js'></script>
<link rel='stylesheet' href='http://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css'>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>
	<div class="container" style="padding-top:150px;">
			<h1>
  유기동물
  <small class="text-muted">보호소 목록</small>
</h1>
	<div class='row'><div class="col-lg-12"><div id="map" style="width: 1100px; height: 350px;"></div></div></div>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=13e68cd504b2e3e8e1a913d636ed1128&libraries=services"></script>
	<script>
		// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
		var infowindow = new kakao.maps.InfoWindow({
			zIndex : 1
		});

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption);

		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places();

		// 키워드로 장소를 검색합니다
		ps.keywordSearch('동물보호소', placesSearchCB);

		// 키워드 검색 완료 시 호출되는 콜백함수 입니다
		function placesSearchCB(data, status, pagination) {
			if (status === kakao.maps.services.Status.OK) {

				// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
				// LatLngBounds 객체에 좌표를 추가합니다
				var bounds = new kakao.maps.LatLngBounds();

				for (var i = 0; i < data.length; i++) {
					displayMarker(data[i]);
					bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
				}

				// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
				map.setBounds(bounds);
			}
		}

		// 지도에 마커를 표시하는 함수입니다
		function displayMarker(place) {

			// 마커를 생성하고 지도에 표시합니다
			var marker = new kakao.maps.Marker({
				map : map,
				position : new kakao.maps.LatLng(place.y, place.x)
			});

			// 마커에 클릭이벤트를 등록합니다
			kakao.maps.event.addListener(marker, 'click', function() {
				// 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
				infowindow
						.setContent('<div style="padding:5px;font-size:12px;">'
								+ place.place_name + '</div>');
				infowindow.open(map, marker);
			});
		}
	</script>
         <hr>
      <h1>
  <small class="text-muted">유기동물</small>
</h1>

      <div class='card-deck mt-3'>
         <div class='card'>
            <div class='reviewImg' style="background-color: white">
  <img src="http://ojsfile.ohmynews.com/STD_IMG_FILE/2017/0331/IE002135087_STD.jpg" width="245" height="300"></div>
            <div class='card-body' style="background-color: white">
               <h5 class='card-title'>이름:냥냥이</h5>
               <p class='card-text'>성별:암컷</p>
               <p class='card-text'>발견장소:이젠아카데미</p>
            </div>
            <div class='card-footer'>
               <small class='text-muter'>2020-11-20</small>
            </div>
         </div>
         <div class='card'>
            <div class='reviewImg' style="background-color: white"><img src="https://youthpress.net/xe/files/attach/images/9766/285/168/4366a63f8ae1de561d28c4e352c3ed78.jpg" width="245" height="300"></div>
            <div class='card-body' style="background-color: white">
               <h5 class='card-title'>이름:멍멍이</h5>
               <p class='card-text'>성별:수컷</p>
               <p class='card-text'>발견장소:서대문구 노란통닭</p>
            </div>
            <div class='card-footer'>
               <small class='text-muter'>2020-11-26</small>
            </div>
         </div>
         <div class='card'>
            <div class='reviewImg' style="background-color: white"><img src="https://cdn.imweb.me/upload/S201905275cebd06fa6a7e/99656042f4e7e.jpeg" width="245" height="300"></div>
            <div class='card-body' style="background-color: white">
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
            <div class='reviewImg' style="background-color: white"><img src="http://img.segye.com/content/image/2020/01/17/20200117511981.jpg" width="245" height="300"></div>
            <div class='card-body' style="background-color: white">
               <h5 class='card-title'>이름:순심이</h5>
               <p class='card-text'>성별:암컷</p>
               <p class='card-text'>발견장소:강남 논현동</p>
            </div>
            <div class='card-footer'>
               <small class='text-muter'>2020-11-20</small>
            </div>
         </div>
      </div>
            <div class='card-deck mt-3'>
         <div class='card'>
            <div class='reviewImg' style="background-color: white">
  <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRz41RGU7w-VPh5QpImdnMxGn5ySNBasbrQiw&usqp=CAU" width="245" height="300"></div>
            <div class='card-body' style="background-color: white">
               <h5 class='card-title'>이름:망치</h5>
               <p class='card-text'>성별:암컷</p>
               <p class='card-text'>발견장소:인천계산동</p>
            </div>
            <div class='card-footer'>
               <small class='text-muter'>2020-11-20</small>
            </div>
         </div>
         <div class='card'>
            <div class='reviewImg' style="background-color: white"><img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgfZp1XlciiRtGDCRz43DYGr5jtBqoPEbJQw&usqp=CAU" width="245" height="300"></div>
            <div class='card-body' style="background-color: white">
               <h5 class='card-title'>이름:야옹이</h5>
               <p class='card-text'>성별:수컷</p>
               <p class='card-text'>발견장소:서대문구 노란통닭</p>
            </div>
            <div class='card-footer'>
               <small class='text-muter'>2020-11-26</small>
            </div>
         </div>
         <div class='card'>
            <div class='reviewImg' style="background-color: white"><img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2yVeQW7H0AJaoC9vY3p719jgxZcpEVWaCrQ&usqp=CAU" width="245" height="300"></div>
            <div class='card-body' style="background-color: white">
               <h5 class='card-title'>이름:흰둥이</h5>
               <p class='card-text'>성별:수컷</p>
               <p class='card-text'>발견장소:짱구네집</p>
               <p class='card-text'></p>
            </div>
            <div class='card-footer'>
               <small class='text-muter'>2020-11-20</small>
            </div>
         </div>
         <div class='card'>
            <div class='reviewImg' style="background-color: white"><img src="https://singlesumer.com/files/attach/images/138/875/107/aded59a61e84ae21258bcc111400f29d.jpg" width="245" height="300"></div>
            <div class='card-body' style="background-color: white">
               <h5 class='card-title'>이름:몽몽이</h5>
               <p class='card-text'>성별:암컷</p>
               <p class='card-text'>발견장소:강남 논현동</p>
            </div>
            <div class='card-footer'>
               <small class='text-muter'>2020-11-20</small>
            </div>
         </div>
      </div>
            <div class='card-deck mt-3'>
         <div class='card'>
            <div class='reviewImg' style="background-color: white">
  <img src="https://species.nibr.go.kr/UPLOAD/digital/species/120000095819/BIMGMM0000005562.jpg" width="245" height="300"></div>
            <div class='card-body' style="background-color: white">
               <h5 class='card-title'>이름:삽살이</h5>
               <p class='card-text'>성별:암컷</p>
               <p class='card-text'>발견장소:이젠아카데미</p>
            </div>
            <div class='card-footer'>
               <small class='text-muter'>2020-11-20</small>
            </div>
         </div>
         <div class='card'>
            <div class='reviewImg' style="background-color: white"><img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSf8MN663yr0SqSg9W6n7YFBhcdP5LKk5xvSg&usqp=CAU" width="245" height="300"></div>
            <div class='card-body' style="background-color: white">
               <h5 class='card-title'>이름:깜이</h5>
               <p class='card-text'>성별:수컷</p>
               <p class='card-text'>발견장소:왕십리 6번출구</p>
            </div>
            <div class='card-footer'>
               <small class='text-muter'>2020-11-26</small>
            </div>
         </div>
         <div class='card'>
            <div class='reviewImg' style="background-color: white"><img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkPIyqyD5lzDbT-q3npQLNvsNBgvFF_uBNqQ&usqp=CAU" width="245" height="300"></div>
            <div class='card-body' style="background-color: white">
               <h5 class='card-title'>이름:냥이</h5>
               <p class='card-text'>성별:수컷</p>
               <p class='card-text'>발견장소:인천 구월동 </p>
               <p class='card-text'></p>
            </div>
            <div class='card-footer'>
               <small class='text-muter'>2020-11-20</small>
            </div>
         </div>
         <div class='card'>
            <div class='reviewImg' style="background-color: white"><img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGnxTDpVhV3FIt-NsT2pPnrmYgNedefBdmjA&usqp=CAU" width="245" height="300"></div>
            <div class='card-body' style="background-color: white">
               <h5 class='card-title'>이름:비글이</h5>
               <p class='card-text'>성별:암컷</p>
               <p class='card-text'>발견장소:서울 강동구 파출소</p>
            </div>
            <div class='card-footer'>
               <small class='text-muter'>2020-11-20</small>
            </div>
         </div>
      </div>
      </div>
      <%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>