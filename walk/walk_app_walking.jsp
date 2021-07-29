<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8a1016e61f601fdf40972b41563332bf"></script>
<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>

<script>
var polyline;
var polyline_path = new Array();

var marker;
var marker_poop;
var marker_cam;

var latitude;
var longitude;

var map;

var locCheck;

var walkArray = new Array();

var distance=0;
var distance_now;
var time=0;
var timer;

var watchId;

var walkObj;
var jsonObj;

var user_idx = ${sessionScope.s_user.user_idx};
var pet_idxs = '${pet_idxs}';

var sur_user = '${sur_user}';

var startTime;
var endTime;

var cam_number=0

var pet_icon_path = '${pageContext.request.contextPath}/pet/walk_pet_icon.png';
var poop_icon_path = '${pageContext.request.contextPath}/images/poop_icon.png';
var cam_icon_path = '${pageContext.request.contextPath}/images/cam_icon.png';


function exist_url(url){
	var http = new XMLHttpRequest();
    http.open('HEAD', url, false);
    http.send();
    console.log(http.status);
    return http.status;
}
window.onload=function() {
	
	if(sur_user=='true'){
		
	}
	
	$("#uploadCam").on("change", addFiles);
	
	navigator.geolocation.getCurrentPosition(function(pos) {
		startTime = Date.now();
		
	    latitude = pos.coords.latitude;
	    longitude = pos.coords.longitude;
	    
	    putJson('walk',latitude, longitude);
	    
	    var container = document.getElementById('map');
	    var options = {
	    	center: new kakao.maps.LatLng(latitude, longitude),
	    	level: 3
	    };
	    map = new kakao.maps.Map(container, options);
	    var icon = new kakao.maps.MarkerImage(
	    		pet_icon_path,
	    	    new kakao.maps.Size(25, 25),
	    	    {
	    	        offset: new kakao.maps.Point(12, 12),
	    	    }
	    );
	    
	    marker = new kakao.maps.Marker({
	        map: map,
	        position: new kakao.maps.LatLng(latitude, longitude),
	    	image: icon
	    });
	    
	    //kakao.maps.event.addListener(marker, 'click', function() {
	    //    alert('marker click!');
	    //});
	    
	    polyline_path.push(new kakao.maps.LatLng(latitude, longitude));
		polyline = new kakao.maps.Polyline({
		    map: map,
		    path: polyline_path,
		    strokeWeight: 10,
		    strokeOpacity: 0.6,
		    strokeColor: '#94b8ff'
		});
		
		timer = setInterval(setTimer,1000);
		//locCheck = setInterval(getLoc, 3000);
	});
	
	watchId = navigator.geolocation.watchPosition(watPoSuc, watPoErr, watPoOption);
	
};


function watPoSuc(position){
	latitude = position.coords.latitude;
    longitude = position.coords.longitude;
    polyline_path.push(new kakao.maps.LatLng(latitude, longitude));
	polyline.setPath(polyline_path);
	polyline.setMap(map);
	
	map.setCenter(new kakao.maps.LatLng(latitude, longitude));
	
	putJson('walk',latitude, longitude);
	
	marker.setPosition(new kakao.maps.LatLng(latitude, longitude));
	marker.setMap(map);
	
	var now = new Date();
	
	
	distance_now = parseInt(polyline.getLength());
	
	var walkData = distance+distance_now;
	var calData = walkData;
	
	document.getElementById('walk_distance').innerText=(distance+distance_now)+'m';
	document.getElementById('walk_cal').innerText=Math.round((distance+distance_now)*0.7)+'cal';
	
	var alldata = {"lat":latitude, "lon":longitude, "pet_idxs":pet_idxs, "user_idx":user_idx};
	
	//주변 산책인 관련 통신 session 방식인데 안 할듯
	/* $.ajax({
	    type : 'GET',
	    dataType : 'json',
	    url : 'walk_walking.do',
	    data : alldata,
	    success : function(data) {
	           // data는 서버로부터 전송받은 결과(JSON)이므로 바로 사용한다
	           console.log('성공');
	           //location.href='walk_app_main.do';
	    },
	    error : function(e) {
	    	console.log('실패');
	    }

	}); */
	
}
function watPoErr(error){
	alert(error);
}
var watPoOption = {enableHighAccuracy: true};



function putJson(type, lat, lng){
	walkObj = new Object;
	walkObj.type = type;
	walkObj.lat = lat;
	walkObj.lng = lng;
	
	walkArray.push(walkObj);
}



/* function getLoc(){
	navigator.geolocation.getCurrentPosition(function(pos){
		latitude = pos.coords.latitude;
	    longitude = pos.coords.longitude;
	    polyline_path.push(new kakao.maps.LatLng(latitude, longitude));
		polyline.setPath(polyline_path);
		polyline.setMap(map);
		
		putJson('walk',latitude, longitude);
		
		marker.setPosition(new kakao.maps.LatLng(latitude, longitude));
		marker.setMap(map);
		
		var now = new Date();
		
		console.log(now.toLocaleTimeString()+'\n위도:'+latitude+'/경도:'+longitude+'\n');
		console.log(pos.coords.accuracy);
	});
	
	distance = parseInt(polyline.getLength());
	console.log(distance);
	document.getElementById('walk_distance').innerText=distance+'m';
} */


function setTimer(){
	var min = parseInt(time/60);
	var sec = time%60;
	
	if(min<10) min='0'+min;
	if(sec<10) sec='0'+sec;
	
	
	var timer_form = document.getElementById('timer');
	timer_form.innerText = min+':'+sec;
	
	time++;
	
}

function pauseTimer(){
	
	walkArray.push("pause");
	
	clearInterval(timer);
	distance += distance_now;
	//clearInterval(locCheck);
	
	navigator.geolocation.clearWatch(watchId);
}

function restartTimer(){
	polyline_path = new Array();
	polyline = new kakao.maps.Polyline({
	    map: map,
	    path: polyline_path,
	    strokeWeight: 10,
	    strokeOpacity: 0.6,
	    strokeColor: '#94b8ff'
	});
	timer = setInterval(setTimer,1000);
	//locCheck = setInterval(getLoc, 3000);
	watchId = navigator.geolocation.watchPosition(watPoSuc, watPoErr, watPoOption);
}

function stopTimer(){
	jsonObj = new Object();
	jsonObj.pet_idxs = pet_idxs.split(',');
	jsonObj.walkInfo = walkArray;
	jsonObj.distance = distance;
	jsonObj.time = time;
	jsonObj.startTime = startTime;
	jsonObj.endTime = Date.now();
	jsonObj.userIdx = user_idx;
	jsonInfo = JSON.stringify(jsonObj);
    
    $.ajax({
	    type : 'POST',
	    dataType : 'json',
	    contentType: 'application/json; charset=utf-8',
	    url : 'walk_app_stopWalking.do',
	    traditional: true,
	    data : jsonInfo,
	    success : function(data) {
	    	
	    	var walk_idxs = data.walk_idxs;
	    	console.log(walk_idxs);
	    	if(cam_number>0){
	    		upload_images(walk_idxs);
	    	}
	    	
	    	Android.more_app_walkingStop();
	        
	    },
	    error : function(e) {
	    	Android.showToast("저장에 문제가 발생하였습니다.");
	    	Android.more_app_walkingStop();
	    }

	});
}

function upload_images(walk_idxs){
	formData.append('cam_number', cam_number);
	formData.append('walk_idxs',walk_idxs);
	$.ajax({
		url: 'walk_app_uploadImg.do',
   		method: 'POST',
        data: formData,
        processData: false,
   		contentType: false,
        success: function () {
        	
        },
        error: function () {
        	alert('업로드 실패');
        },
	});
}

function timerCheck(){
	if(document.getElementById('timerCheck').checked==true){
		restartTimer();
		document.getElementById('timerCheck').checked=false;
		
		document.getElementById('stop_end_icon').style.backgroundImage = 'url(\'${pageContext.request.contextPath}/images/pause_icon.png\')'; //일시정지로 바꿔
		document.getElementById('poop_icon').style.backgroundImage = 'url(\'${pageContext.request.contextPath}/images/poop_icon.png\')'; // 똥으로 바꿔
		document.getElementById('poopBt').onclick = markerPoop;
	}else {
		pauseTimer();
		document.getElementById('timerCheck').checked=true;
		
		document.getElementById('stop_end_icon').style.backgroundImage = 'url(\'${pageContext.request.contextPath}/images/start_icon.png\')'; // 중지로 바꿔
		document.getElementById('poop_icon').style.backgroundImage = 'url(\'${pageContext.request.contextPath}/images/stop_icon.png\')'; // 재시작으로 바꿔
		document.getElementById('poopBt').onclick = function(){
			$('.container').addClass('modal-open');
			document.getElementById('bg_black').style.display = 'block';
			
		};
		
	}
}

function markerPoop(){
	/* navigator.geolocation.getCurrentPosition(function(pos){
		latitude = pos.coords.latitude;
	    longitude = pos.coords.longitude; */
	    
	    var poop_icon = new kakao.maps.MarkerImage(
	    		poop_icon_path,
	    	    new kakao.maps.Size(15, 15),
	    	    {
	    	        offset: new kakao.maps.Point(12, 12),
	    	    }
	    );
	    
	    putJson('poop',latitude, longitude);
	    
	    marker_poop = new kakao.maps.Marker({
	        map: map,
	        position: new kakao.maps.LatLng(latitude, longitude),
	    	opacity: 0.8,
	    	image: poop_icon
	    	//image:
	    });
	//});
}

function clickCam(){
	$('#uploadCam').click();
}
var formData = new FormData();
function addFiles(e){
	markerCam(cam_number);
	console.log('addFile');
	
	var file = e.target.files[0];
	formData.append('file['+cam_number+']',file);
	
	$('#uploadCam').val('');
	
	cam_number++;
	document.getElementById('cam_num').innerHTML = cam_number+'/5';
	if(cam_number>=5){
		document.getElementById('camBt').onclick = '';
	}
}
function markerCam(img){
		navigator.geolocation.getCurrentPosition(function(pos){
		latitude = pos.coords.latitude;
	    longitude = pos.coords.longitude; // 촬영은 산책 일시 정지 상태에서도 가능함
	    
	    walkObj = new Object;
		walkObj.type = 'cam';
		walkObj.lat = latitude;
		walkObj.lng = longitude;
		walkObj.img = img;
		
		walkArray.push(walkObj);
		
		 var cam_icon = new kakao.maps.MarkerImage(
	    		cam_icon_path,
	    	    new kakao.maps.Size(30, 30),
	    	    {
	    	        offset: new kakao.maps.Point(12, 12),
	    	    }
	    );
		 
	    marker_cam = new kakao.maps.Marker({
	        map: map,
	        position: new kakao.maps.LatLng(latitude, longitude),
	    	opacity: 0.8,
	    	image: cam_icon
	    });
	});
}
function resumeWalk(){
	document.getElementById('bg_black').style.display = 'none';
	$('.container').removeClass('modal-open');

}

</script>
<style>

#bg_black{
position: fixed;
width: 100%;
height: 100%;
background-color:rgba(0, 0,0, 0.5);
top:0;
left: 0;
bottom: 0;
z-index: 4;
display:none;
}
#walk_user_tab{
margin-top: 45vh;
width: 100vw;
height: 55vh;
background: linear-gradient(
to bottom,
rgba(255, 255, 255, 0) 7%,
rgba(255, 255, 255, 0.25) 14%,
rgba(255, 255, 255, 0.5) 21%,
rgba(255, 255, 255, 0.75) 28%,
rgba(255, 255, 255, 1) 35%
);
z-index: 2;
position: absolute;
}

#walk_timer{
margin:0px auto; 
height:10vh; 
}

.walk_info{
margin: 0px;
}
#map{
z-index: 1;
}
.modal {
  background: #fff;
  width: 70%;
  height: 25%;
  margin: 0 auto;
  padding: 5%;
  transition: all 600ms cubic-bezier(0.86, 0, 0.07, 1);
  top: 100%;
  position: fixed;
  left: 10%;
  text-align: left;
  z-index: 5;
  border-radius: 5%;
}
.container.modal-open .modal {
  top: 37%;
}
</style>
</head>
<body style="margin: 0px;" class="container">
<input id="uploadCam" type="file" accept="image/*;capture=camera" style="display:none;">
<div id="bg_black"></div>
<div id="stop_modal_form" class="modal">
	<div id="modal_content" style="height: 70%; width: 80%; line-height:100px; margin: 0px auto;"><span style="vertical-align: middle; font-size: 18px;">산책을 중지하시겠습니까?</span></div>
	<div id="modal_bt_form" style="height: 30%; width: 80%; margin: 0px auto;">
		<div id="modal_yesBt" style="display: inline-block; border-radius: 15px; width: 47%; height: 40px; line-height:40px; padding: 1%; text-align: center; background-color: #94b8ff;" onclick="stopTimer();"><span style="vertical-align: middle;">확인</span></div>
		<div id="modal_noBt" style="display: inline-block; border-radius: 15px; width: 47%; height:40px; line-height:40px; padding: 1%; text-align: center; background-color: #94b8ff;" onclick="resumeWalk();"><span style="vertical-align: middle;">취소</span></div>
	</div>
</div>
<div id="walk_user_tab">
	<div id="walk_timer" style="margin: 25px;">
	<h1 id="timer" style="text-align: center; font-size: 55px; margin: 0px;">00:00</h1>
	<div style="text-align: center; font-size: 11px; margin: 0px;">산책시간</div>
	</div>
	
	<div id="walk_info_div">
		<h1 id="walk_distance" class="walk_info" style="width:49vw; display:inline-block;  text-align: center;">0m</h1>
		<h1 id="walk_cal" class="walk_info" style="width:49vw; display:inline-block; text-align: center;" >0cal</h1>
	</div>
	<div id="walk_info_name">
		<span style="width:49vw; display:inline-block;  text-align: center; font-size: 11px;">거리</span>
		<span style="width:49vw; display:inline-block;  text-align: center; font-size: 11px;">칼로리</span>
	</div>
	
	<div id="walk_userBt" style="width: 100vw; margin-top:20px;">
		<div id="poop" style="width: 24vw; height: 24vw; margin: 3vw; left: 0px; position: absolute;">
			<div id="poopBt" onclick="markerPoop();" style="width:23vw; height:23vw; border-radius: 100%; border-color: lightgrey; border-width: 1vw; border-style: solid;" >
				<i id="poop_icon" style="background: url('${pageContext.request.contextPath}/images/poop_icon.png'); display: inline-block; vertical-align: middle; background-size: 100%; width: 9vw; height: 9vw; margin-left: 7vw; margin-top: 7vw;"></i>
			</div>
		</div>
		<div id="stop_end" style="width: 30vw; height: 30vw; left: 50%; margin-left: -15vw; position: absolute;">
			<div id="stopEndBt" onclick="timerCheck();" style="width:29vw; height:29vw; border-radius: 100%; border-color: #94b8ff; border-width: 1vw; border-style: solid;" >
				<input type="checkbox" id="timerCheck" style="display: none;">
				<i id="stop_end_icon" style="background: url('${pageContext.request.contextPath}/images/pause_icon.png'); display: inline-block; vertical-align: middle; background-size: 100%; width: 15vw; height: 15vw; margin-left: 7vw; margin-top: 7vw;"></i>
			</div>
		</div>
		<div id="camera" style="width: 24vw; height: 24vw; margin: 3vw; right: 0px; position: absolute;">
			<div id="camBt" onclick="clickCam();" style="width:23vw; height:23vw; border-radius: 100%; border-color: lightgrey; border-width: 1vw; border-style: solid;" >
				<i style="background: url('${pageContext.request.contextPath}/images/camera_icon.png'); display: inline-block; vertical-align: middle; background-size: 100%; width: 9vw; height: 9vw; margin-left: 7vw; margin-top: 7vw;"></i>
				<div id="cam_num" style="width: 30px; text-align: center; margin: 0px auto; font-size: 11px;"></div>
			</div>
		</div>
	</div>
</div>
<div id="map" style="height:70vh; width:100vw;"></div>

</body>
</html>