<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel='stylesheet' href='css/meeting/allContent.css'>
<script src='https://code.jquery.com/jquery-3.5.1.min.js'></script>
<link rel='stylesheet' href='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css' />

<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi">	
<meta name="format-detection" content="telephone=no">
<script type="text/javascript" src="/morepet/js/httpRequest.js"></script>
<style>
    #child_2{display:none;}
     #img_img{width: 100%; height: 300px; object-fit: cover;}
    .modal_layer {
	  position:fixed;
	  top:0;
	  left:0;
	  width:100%;
	  height:100%;
	  background:rgba(0, 0, 0, 0.8);
	  z-index:-1;
	} 
	.card{
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.35);
		border-radius: 10px;
	}
}
</style>
</head>
<body>
<%@ include file="../header.jsp" %>

<div style="padding-top: 150px;">	
	  <!-- include : nav  해더에 포함하는게 좋을듯 ?-->
      <nav class='nav justify-content-center' >
         <a class='nav-link p-2' href="meeting.do"  style="color: #495057;"><small>커뮤니티</small></a> 
         <a class='nav-link p-2' href="meeting_m.do?user_idx=${sessionScope.s_user.user_idx}"  style="color: #495057;"><small>모임</small></a> 
      </nav>

  	<div class='gnbBar'>
    	<hr class='line'>
    </div>
	
	<div class='reviewBar'>
         <hr>
         <div class='reviewBarFont' style="color: #495057;">커뮤니티</div>
         <hr>
     </div>
	
	<br>
	<!-- 지도 -->
	<div id="map" style="width:100%; height:400px;"></div>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=95a21bd8ca340af5a9328e0f8c9e2b65"></script>
<script type="text/javascript">

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 5 // 지도의 확대 레벨 
    }; 

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다


var list = new Array();
	<c:forEach var="list" items="${list}">

	console.log('${list.meeting_m_x}','${list.meeting_m_y}');
		var marker = new kakao.maps.Marker({
		    map: map,
		    position: new kakao.maps.LatLng(${list.meeting_m_y}, ${list.meeting_m_x})
		});
	 
	</c:forEach>
	var marker = new kakao.maps.Marker({
	    map: map,
	    position: new kakao.maps.LatLng(127.062831022499, 37.514322572329)
	});
	
	
// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
if (navigator.geolocation) {
    
    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
    navigator.geolocation.getCurrentPosition(function(position) {
        
        var lat = position.coords.latitude, // 위도
            lon = position.coords.longitude; // 경도
        
        var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
            message = '<div style="padding:5px;">모임을 찾아보세요!</div>'; // 인포윈도우에 표시될 내용입니다
        
        // 마커와 인포윈도우를 표시합니다
        displayMarker(locPosition, message);
            
      });
    
} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
    
    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
        message = 'geolocation을 사용할수 없어요..'
        
    displayMarker(locPosition, message);
}

// 지도에 마커와 인포윈도우를 표시하는 함수입니다
function displayMarker(locPosition, message) {

    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({  
        map: map, 
        position: locPosition
    }); 
    
    var iwContent = message, // 인포윈도우에 표시할 내용
        iwRemoveable = true;

    // 인포윈도우를 생성합니다
    var infowindow = new kakao.maps.InfoWindow({
        content : iwContent,
        removable : iwRemoveable
    });
    
    // 인포윈도우를 마커위에 표시합니다 
    infowindow.open(map, marker);
    
    // 지도 중심좌표를 접속위치로 변경합니다
    map.setCenter(locPosition);      
}    
		
function show(meeting_m_idx,user_idx) {
	var params = 'meeting_m_idx='+meeting_m_idx+'&user_idx='+user_idx;
	sendRequest('meeting_m_content.do',params,showResult,'GET');
}
function showResult() {
	if(XHR.readyState==4){
		if(XHR.status==200){
			var data = XHR.responseText;
			data = eval('('+data+')');
			
			var contentDiv = document.getElementById('contentLayer');
			contentDiv.style.display='';
			document.getElementById('location').innerHTML = '장소 :'+data.dto.meeting_m_location;
			document.getElementById('total').innerHTML ='인원 :'+data.count+'/'+data.dto.meeting_m_total;
			document.getElementById('nickname').innerHTML ='이름 :'+data.dto.user_nickname;
			document.getElementById('subject').innerHTML ='제목 :'+data.dto.meeting_m_subject;
			document.getElementById('detail').innerHTML ='세부장소 :'+data.dto.meeting_m_detail;
			
			var img_m = data.dto.meeting_m_file;
			var img_arr = img_m.split(',');
			document.getElementById('mod_img').innerHTML = "";
			var mod = document.getElementById('mod_img');
			for(var i=0; i<img_arr.length; i++){
				var div= document.createElement('div');
				div.innerHTML = 
					'<img id="img_img" alt="" src="${pageContext.request.contextPath}/img/meeting/'+data.dto.meeting_m_idx+'/'+img_arr[i]+'">'
					mod.appendChild(div);
			}
			
			if(data.dto.user_idx== ${sessionScope.s_user.user_idx}){
				document.getElementById('close').innerHTML =
					'<button type="button" id="signUpBtn" class="btn btn-primary offset-3 col-6 mt-2" onclick="closeNchat('+data.room_idx+');">채팅</button>'+
					'<button type="button" id="signUpBtn" class="btn btn-primary offset-3 col-6 mt-2" onclick="divClose()">닫기</button>'
					
					if(data.list_j.length==0){
						
						document.getElementById('j_list').innerHTML =
							'<div class="card-footer"><small class="text-muter">참가인원이없습니다.</small></div>'
					}else{
						var node = document.getElementById('j_list');
						for(var i= 0; i<data.list_j.length; i++){
							var div= document.createElement('div');
							div.setAttribute('class','card-footer');
							div.setAttribute('id','child');
							var span= document.createElement('span');
								div.innerHTML =
								'<small class="text-muter">'+
								'<span id="nickname_j">이름 : <small>'+data.list_j[i].user_nickname+' 님</small></span>'+
								'</small>&nbsp;<span id="j_list_1"></span>'
							
			               		if(data.list_j[i].yes_or_no==1){
			               			span.innerHTML ='<small class="text-muter"><input type="button" value="수락" onclick="yes('+data.list_j[i].user_idx+','+data.list_j[i].meeting_m_idx+')">'+
			               		'<input type="button" value="거절" onclick="no('+data.list_j[i].user_idx+','+data.list_j[i].meeting_m_idx+')"></small>'
			               		}else{
			               			span.innerHTML = '<small class="text-muter"><input type="button" value="수락됨"></small>'
			               		}
			               		
			               		node.appendChild(div);
			               		div.appendChild(span);
						}
						
					}
				var node = document.getElementById('j_list');
				var div= document.createElement('div');
				var div_1= document.createElement('div');
				
				div.setAttribute('class','card-footer');
				div_1.setAttribute('class','card-footer');
				
				div.setAttribute('id','child');
				div_1.setAttribute('id','child_1');
				
				
				//리스트 있,없 조건으로 댓글보여주기
				if(data.list_d.length != null){
				div.innerHTML = 
					'<div onclick="showDec()">댓글('+data.count_d+')</div>'
					
						for(var i = 0; i<data.list_d.length; i++){
							var div_2= document.createElement('div');
							div_2.setAttribute('class','card-footer');
							div_2.setAttribute('id','child_2');
							var span= document.createElement('span');

							
							div_2.innerHTML = 
								'<div id="dec">'+
									'<div><img style="width: 30px; height: 30px; border-radius:20px;" id="u_img" alt="유저사진" src="${pageContext.request.contextPath}/user/'+data.dto.user_idx+'/profile.png">&nbsp;<small>'+data.list_d[i].meeting_d_writedate+'</small>&nbsp;<br><small>'+data.list_d[i].user_nickname+'</small>&nbsp;<span id="list_d_u['+i+']">'+data.list_d[i].meeting_d_content+'</span></div>'+
								'</div>'
								
								if(data.list_d[i].user_idx==${sessionScope.s_user.user_idx}){
									
									span.innerHTML ='<small id="up_b['+i+']" class="text-muter"><input type="button" value="수정" onclick="list_d_update('+i+','+data.list_d[i].meeting_d_idx+','+data.list_d[i].user_idx+','+data.list_d[i].meeting_d_ref+','+data.list_d[i].meeting_d_lev+')">'+
				               		'<input type="button" value="삭제" onclick="list_d_del('+${sessionScope.s_user.user_idx}+','+data.list_d[i].meeting_d_ref+','+data.list_d[i].meeting_d_lev+')"></small>'
								}
							div.appendChild(div_2);
							div_2.appendChild(span);
							
						}	
					
						
					
					node.appendChild(div);
				}
				
				div_1.innerHTML = 
					'<form name="dec" action="meeting_d_add.do">'+
					'<div class="row">'+
	           			 '<input type="text" class="form-control w-50 offset-3 col-5" id="content" name="meeting_d_content" placeholder="댓글 작성하기."/>'+
	           			 '<button type="submit" class="btn btn-sm btn-outline-primary col-1 p-0" data-toggle="modal" data-target="#sendNumModal"><small>등록</small></button>'+  
	        		 '</div>'+
	        		 '<input type="hidden" name="meeting_d_idx" value="'+data.dto.meeting_m_idx+'">'+
	        		 '<input type="hidden" name="user_idx" value="'+${sessionScope.s_user.user_idx}+'">'+
	        		 '</form>'
	        		 
				
				node.appendChild(div_1);
					
					
			}else{
				var node = document.getElementById('close');
				var div= document.createElement('div');
				
				if(data.dto_my == null){
					document.getElementById('close').innerHTML =
						'<button type="button" id="signUpBtn" class="btn btn-primary offset-3 col-6 mt-2" onclick="show_push('+data.dto.meeting_m_idx+','+${sessionScope.s_user.user_idx}+')">요청</button>'+
						'<button type="button" id="signUpBtn" class="btn btn-primary offset-3 col-6 mt-2" onclick="divClose()">닫기</button>'
				}else if(data.dto_my.yes_or_no==1){
					document.getElementById('close').innerHTML =
						'<button type="button" id="signUpBtn" class="btn btn-primary offset-3 col-6 mt-2" >요청중</button>'+
						'<button type="button" id="signUpBtn" class="btn btn-primary offset-3 col-6 mt-2" onclick="divClose()">닫기</button>'
				}else if(data.dto_my.yes_or_no==2){
					document.getElementById('close').innerHTML =
						'<button type="button" id="signUpBtn" class="btn btn-primary offset-3 col-6 mt-2" onclick="closeNchat('+data.room_idx+');">채팅</button>'+
						'<button type="button" id="signUpBtn" class="btn btn-primary offset-3 col-6 mt-2" onclick="divClose()">닫기</button>'
				}
				
				var node = document.getElementById('j_list');
				var div= document.createElement('div');
				var div_1= document.createElement('div');
				
				div.setAttribute('class','card-footer');
				div_1.setAttribute('class','card-footer');
				
				div.setAttribute('id','child');
				div_1.setAttribute('id','child_1');
				
				
				//리스트 있,없 조건으로 댓글보여주기
				if(data.list_d.length != null){
				div.innerHTML = 
					'<div onclick="showDec()">댓글('+data.count_d+')</div>'
					
						for(var i = 0; i<data.list_d.length; i++){
							var div_2= document.createElement('div');
							div_2.setAttribute('class','card-footer');
							div_2.setAttribute('id','child_2');
							var span= document.createElement('span');
							
							div_2.innerHTML = 
								'<div id="dec">'+
									'<div><img style="width: 30px; height: 30px; border-radius:20px;" id="u_img" alt="유저사진" src="${pageContext.request.contextPath}/user/'+data.dto.user_idx+'/profile.png">&nbsp;<small>'+data.list_d[i].meeting_d_writedate+'</small>&nbsp;<br><small>'+data.list_d[i].user_nickname+'</small>&nbsp;<span id="list_d_u['+i+']">'+data.list_d[i].meeting_d_content+'</span></div>'+
								'</div>'
								
								if(data.list_d[i].user_idx==${sessionScope.s_user.user_idx}){
									
									span.innerHTML ='<small id="up_b['+i+']" class="text-muter"><input type="button" value="수정" onclick="list_d_update('+i+','+data.list_d[i].meeting_d_idx+','+data.list_d[i].user_idx+','+data.list_d[i].meeting_d_ref+','+data.list_d[i].meeting_d_lev+')">'+
				               		'<input type="button" value="삭제" onclick="list_d_del('+${sessionScope.s_user.user_idx}+','+data.list_d[i].meeting_d_ref+','+data.list_d[i].meeting_d_lev+')"></small>'
								}
							div.appendChild(div_2);
							div_2.appendChild(span);
							
						}	
					
						
					
					node.appendChild(div);
				}
				
				div_1.innerHTML = 
					'<form name="dec" action="meeting_d_add.do">'+
					'<div class="row">'+
	           			 '<input type="text" class="form-control w-50 offset-3 col-5" id="content" name="meeting_d_content" placeholder="댓글 작성하기."/>'+
	           			 '<button type="submit" class="btn btn-sm btn-outline-primary col-1 p-0" data-toggle="modal" data-target="#sendNumModal"><small>등록</small></button>'+  
	        		 '</div>'+
	        		 '<input type="hidden" name="meeting_d_idx" value="'+data.dto.meeting_m_idx+'">'+
	        		 '<input type="hidden" name="user_idx" value="'+${sessionScope.s_user.user_idx}+'">'+
	        		 '</form>'
	        		 
				
				node.appendChild(div_1);
				
			}
			
		
			
			
		}	
	}
}
function closeNchat(room_idx){
	alert(room_idx);
	joinRoom(room_idx, 'room');
	divClose();
	
}
function divClose() {
	var contentDiv = document.getElementById('contentLayer');
	contentDiv.style.display='none';
	
	var node = document.getElementById('j_list');
	/* node.parentNode.remove(node);*/
	
	 while ( node.hasChildNodes() ) {
		node.removeChild( node.firstChild ); 
		} 
}
function show_push(meeting_m_idx,user_idx) {
	location.href= 'meeting_m_push.do?meeting_m_idx='+meeting_m_idx+'&user_idx='+user_idx;
	
}
function list_d_del(user_idx,ref,lev) {
	var params ='user_idx='+user_idx+'&meeting_d_ref='+ref+'&meeting_d_lev='+lev;
	sendRequest('meeting_d_del.do',params,showResult_d_del,'GET');
}
function showResult_d_del() {
		if(XHR.readyState==4){
			if(XHR.status==200){
				var data = XHR.responseText;
				data = eval('('+data+')');
				window.alert(data.msg_d);
				location.reload();
			}
		}
}
function yes(user_idx,meeting_m_idx) {
	var params = 'user_idx='+user_idx+'&meeting_m_idx='+meeting_m_idx;
	sendRequest('yes.do',params,showResult_yes,'GET');
}
function showResult_yes() {
	if(XHR.readyState==4){
		if(XHR.status==200){
			var data = XHR.responseText;
			data = eval('('+data+')');
			window.alert(data.msg);
			location.reload();
	
		}
	}
}

function no(user_idx,meeting_m_idx) {
	var params = 'user_idx='+user_idx+'&meeting_m_idx='+meeting_m_idx;
	sendRequest('no.do',params,showResult_no,'GET');
}
function showResult_no() {
	if(XHR.readyState==4){
		if(XHR.status==200){
			var data = XHR.responseText;
			data = eval('('+data+')');
			window.alert(data.msg);
			location.reload();
		}
	}
}
function list_d_update(i,d_idx,u_idx,ref,lev) {
	var up = document.getElementById('list_d_u['+i+']');
	var content = up.innerText;
	
	up.innerHTML = 
		'<form action="meeting_d_update.do" method="POST">'+
		'<span id="up_in">'+
		'<input type="text" name="meeting_d_content" value="'+content+'">'+
		'<input type="hidden" name="meeting_d_idx" value="'+d_idx+'">'+
		'<input type="hidden" name="user_idx" value="'+u_idx+'">'+
		'<input type="hidden" name="meeting_d_ref" value="'+ref+'">'+
		'<input type="hidden" name="meeting_d_lev" value="'+lev+'">'+
		'</span>'+
		'</form>'
		
	var up_b = document.getElementById('up_b['+i+']');
	up_b.innerHTML = 
		'<small class="text-muter"><input type="submit" value="등록"></small>'
	
	var up_in = document.getElementById('up_in');
	
	up_in.appendChild(up_b);
	
}

function showDec() {
	
	if(document.getElementById('child_2').style.display=='none'){
		$(child_2).css('display','block');
	}else{
		$(child_2).css('display','none');
	}
}
</script>
<div class='container' style="padding-top: 150px;">
<c:set var="list" value="${list}" ></c:set>
<c:choose>
	<c:when test="${empty list}">
	<%-- --> 
	모임 리스트
	<-- --%>
	<div class="row">
	<div class='reviewBar'>
         <hr>
         <div class='reviewBarFont'><a href="#">List</a>
         &nbsp;&nbsp;&nbsp;<span><a href="meeting_m_add.do?user_idx="${sessionScope.s_user.user_idx}>+</a></span></div>
         <hr>
     </div>
     <div class='card-deck mt-3'>
         <div class='card'>
            <div class='card-body'>
               <p class='card-text'>게시물이 없습니다. </p>
            </div>
            <div class='card-footer'>
               <small class='text-muter'>--</small>
            </div>
         </div>  
      </div>
      </div>
	</c:when>

	<c:otherwise>
	<div class='reviewBar'>
         <hr>
         <div class='reviewBarFont' ><a href="#" style="color: #495057;">List</a>
         &nbsp;&nbsp;&nbsp;<span><a href="meeting_m_add.do?user_idx="${sessionScope.s_user.user_idx}>+</a></span></div>
         <hr>
     </div>
     <%-- --> 
	모임 리스트 / object-fit: 이미지 구겨
	<-- --%>
	<div class="row">
       <div class='card-deck mt-3'>
     <c:forEach var="list" items="${list}" end="5">
         <div class='card' onclick="show(${list.meeting_m_idx},${sessionScope.s_user.user_idx})">
            <div class='reviewImg' style="overflow: hidden;">
            <c:set var="arrImg" value="${fn:split(list.meeting_m_file,',')}"></c:set>
            <c:forEach var="img" items="${arrImg}" varStatus="i">
	            <div>
	           	 <img id="img_img" alt="" src="${pageContext.request.contextPath}/img/meeting/${list.meeting_m_idx}/${img}">
	           	 </div>
            </c:forEach>
            </div>
            <div class='card-body'>
               <p class='card-text'>이름 : ${list.user_nickname}</p>
               <p class='card-text'>제목 : ${list.meeting_m_subject}</p>
               <p class='card-text'>인원 : ${list.meeting_m_total} </p>
               <p class='card-text'>장소 : ${list.meeting_m_location} </p>
            </div>
            <div class='card-footer'>
               <c:choose>
               			<c:when test="${list.day > 0}">
               				<small class='text-muter'>${list.day}일 전</small>
               			</c:when>
               			<c:when test="${list.hour > 0}">
               				<small class='text-muter'>${list.hour}시간 전</small>
               			</c:when>
               			<c:when test="${list.minute > 0}">
               				<small class='text-muter'>${list.minute}분 전</small>
               			</c:when>
               			<c:otherwise>
               				<small class='text-muter'>방금 전</small>
               			</c:otherwise>
               		</c:choose>
            </div>
         </div>  
          </c:forEach>
      </div>
       <%-- --> 
	ajax 보기 / vw , vh 확인해서 반응형
	<-- --%>
    <div id="contentLayer" style="position: absolute; top:95%; left: 35%; display: none; width: 500px; z-index: 1">
       <div class='card-deck mt-3'>
         <div class='card'>
            <div class='reviewImg' style="overflow: hidden;">
            	<div id="mod_img">
	           	 <img alt="" src="">
	           	 </div>
            </div>
            <div class='card-body'>
               <p class='card-text' id="nickname">이름 : --</p>
               <p class='card-text' id="subject">제목 : --</p>
               <p class='card-text' id="total">인원 : --</p>
               <p class='card-text' id="location">장소 : --</p>
               <p class='card-text' id="detail">세부장소 : --</p>
               <div class='row' id="close">
		             
		         </div>
            </div>
            
            
            <%-- --> 
			j_list 부분
			<-- --%>
            <div id="j_list">
            	
            </div>
            
            
            <%-- --> 
			잔여시간
			<-- --%>
            
      </div>
      </div>
      <div class="modal_layer"></div>
      </div>
      </div>
     </c:otherwise>
</c:choose> 

<div class='d-flex justify-content-center mt-3'>
		<ul class='pagination'>
			<li class='page-item'>${pageStr}</li>
		</ul>
	</div>
 </div>
  <%@ include file="../footer.jsp" %>
</body>
</html>