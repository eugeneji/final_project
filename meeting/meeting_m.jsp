<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src='https://code.jquery.com/jquery-3.5.1.min.js'></script>
<style type="text/css">

 #child_2{display: none;}
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
</style>
<script type="text/javascript" src="/morepet/js/httpRequest.js"></script>
<script type="text/javascript">
function show(meeting_m_idx,user_idx) {
	var params = 'meeting_m_idx='+meeting_m_idx+'&user_idx='+user_idx;
	sendRequest('meeting_m_content.do',params,showResult,'GET');
}
function show_my(meeting_m_idx,user_idx) {
	var params = 'meeting_m_idx='+meeting_m_idx+'&user_idx='+user_idx;
	sendRequest('meeting_m_content.do',params,showResult_my,'GET');
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
			
			if(data.dto_my.yes_or_no==1){
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
			div.setAttribute('class','card-footer');
			div.setAttribute('id','child');
			
			
			document.getElementById('j_list').innerHTML = "";
			//리스트 있,없 조건으로 댓글보여주기
			if(data.list_d.length != null){
			div.innerHTML = 
				'<div onclick="showDec()">댓글('+data.count_d+')</div>';
				
					for(var i = 0; i<data.list_d.length; i++){
						var div_2= document.createElement('div');
						div_2.setAttribute('class','card-footer');
						div_2.setAttribute('id','child_2');
						var span= document.createElement('span');
						
						div_2.innerHTML = 
							'<div id="dec">'+
								'<div>(사진)&nbsp;<small>'+data.list_d[i].meeting_d_writedate+'</small>&nbsp;<br>'+data.list_d[i].user_nickname+'&nbsp;<span id="list_d_u['+i+']">'+data.list_d[i].meeting_d_content+'</span></div>'+
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
			
			var div_1= document.createElement('div');
			div_1.setAttribute('class','card-footer');
			div_1.setAttribute('id','child_1');
			
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
function showResult_my() {
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
			
			if(data.list_j.length==0){
				
			document.getElementById('j_list').innerHTML =
				'<div class="card-footer"><small class="text-muter">참가인원이없습니다.</small></div>'
				document.getElementById('close').innerHTML =
					'<button type="button" id="signUpBtn" class="btn btn-primary offset-3 col-6 mt-2" onclick="closeNchat('+data.room_idx+');">채팅</button>'+
					'<button type="button" id="signUpBtn" class="btn btn-primary offset-3 col-6 mt-2" onclick="divClose()">닫기</button>'
			}else{
				var node = document.getElementById('j_list');
			
				/* 노드 참고
				option = document.createElement('option');
			      option.setAttribute('value',cateCodeVal);
			      option.innerHTML = '선택';
			      cateCodeNode.appendChild(option);
				*/
				for(var i= 0; i<data.list_j.length; i++){
					var div= document.createElement('div');
					div.setAttribute('class','card-footer');
					div.setAttribute('id','child');
					var span= document.createElement('span');
						div.innerHTML =
						'<small class="text-muter">'+
						'<span id="nickname_j">이름 : '+data.list_j[i].user_nickname+' 님</span>'+
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
				document.getElementById('close').innerHTML =
					'<button type="button" id="signUpBtn" class="btn btn-primary offset-3 col-6 mt-2" onclick="divClose()">닫기</button>'
			
			}
		
			
			var node = document.getElementById('j_list');
			var div= document.createElement('div');
			div.setAttribute('class','card-footer');
			div.setAttribute('id','child');
			
			//리스트 있,없 조건으로 댓글보여주기
			if(data.list_d.length != null){
			div.innerHTML = 
				'<div onclick="showDec()">댓글('+data.count_d+')</div>';
				
					for(var i = 0; i<data.list_d.length; i++){
						var div_2= document.createElement('div');
						div_2.setAttribute('class','card-footer');
						div_2.setAttribute('id','child_2');
						var span= document.createElement('span');
						
						div_2.innerHTML = 
							'<div id="dec">'+
								'<div>(사진)&nbsp;<small>'+data.list_d[i].meeting_d_writedate+'</small>&nbsp;<br>'+data.list_d[i].user_nickname+'&nbsp;<span id="list_d_u['+i+']">'+data.list_d[i].meeting_d_content+'</span></div>'+
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
			
			var div_1= document.createElement('div');
			div_1.setAttribute('class','card-footer');
			div_1.setAttribute('id','child_1');
			
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
</head>
<body>
<%@ include file="../header.jsp" %>
<div class='container' style="padding-top: 150px;">

<!-- include : nav  해더에 포함하는게 좋을듯 ?-->
      <nav class='nav justify-content-center'>
         <a class='nav-link p-2' href="meeting.do"><small  style="color: #495057;">커뮤니티</small></a> 
         <a class='nav-link p-2' href="meeting_m.do?user_idx=${sessionScope.s_user.user_idx}"><small  style="color: #495057;">모임</small></a> 
      </nav>

  	<div class='gnbBar'>
    	<hr class='line'>
    </div>
	
	<div class='reviewBar'>
         <hr>
         <div class='reviewBarFont'  style="color: #495057;">모임</div>
         <hr>
     </div>
	
	<br>


<c:set var="list_my" value="${list_my}" ></c:set>
<c:choose>
	<c:when test="${empty list_my}">
	<%-- --> 
	내모임 리스트
	<-- --%>
	
	
	 <div class="main">
         <h3>내모임 &nbsp;&nbsp;&nbsp;<span><a href="meeting_m_add.do?user_idx=${sessionScope.s_user.user_idx}">+</a></span></h3> 
      </div>
      
     <div class="row">
     <div class="col-md-4">
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
      </div>
	</c:when>

	<%-- --> 
	내모임 리스트
	<-- --%>
	<c:otherwise>
	
	 <div class="main">
         <h3>내모임 &nbsp;&nbsp;&nbsp;<span><a href="meeting_m_add.do?user_idx=${sessionScope.s_user.user_idx}">+</a></span></h3> 
      </div>
     
     <div class="row">
      <div class='card-deck mt-3'>
     <c:forEach var="arr_my" items="${list_my}">
         <div class='card' onclick="show_my(${arr_my.meeting_m_idx},${sessionScope.s_user.user_idx})">
             <div class='reviewImg' style="overflow: hidden;">
            <c:set var="arrImg" value="${fn:split(arr_my.meeting_m_file,',')}"></c:set>
            <c:forEach var="img" items="${arrImg}" varStatus="i">
	            <div>
	           	 <img id="img_img" alt="" src="${pageContext.request.contextPath}/img/meeting/${arr_my.meeting_m_idx}/${img}">
	           	 </div>
            </c:forEach>
            </div>
            <div class='card-body'>
               <p class='card-text'>이름 : ${arr_my.user_nickname}</p>
               <p class='card-text'>제목 : ${arr_my.meeting_m_subject}</p>
               <p class='card-text'>인원 : ${arr_my.meeting_m_total} </p>
               <p class='card-text'>장소 : ${arr_my.meeting_m_location} </p>
            </div>
            <div class='card-footer'>
              <c:choose>
               	<c:when test="${arr_my.day > 0}">
               		<small class='text-muter'>${arr_my.day}일 전</small>
               	</c:when>
               	<c:when test="${arr_my.hour > 0}">
               		<small class='text-muter'>${arr_my.hour}시간 전</small>
               	</c:when>
               	<c:when test="${arr_my.minute > 0}">
               		<small class='text-muter'>${arr_my.minute}분 전</small>
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
	ajax 보기
	<-- --%>
   
    <div id="contentLayer" style="position: absolute; top:2%; left: 38%; display: none; width: 500px; z-index: 1">
       <div class='card-deck mt-3'>
         <div class='card'>
            <div class='reviewImg' style="overflow: hidden;">
            	<div id="mod_img">
	           	 <img id="img_img" alt="" src="">
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

     <%-- --> 
	구분선
	<-- --%>
    	<div class='gnbBar'>
    	<hr class='line'>----------
    </div>
    
 
    <%-- --> 
	참여모임 리스트
	<-- --%>
<c:set var="list" value="${list}"></c:set>
<c:choose>
    <c:when test="${empty list}">
   
     <div class="main">
         <h3>참여모임 &nbsp;&nbsp;&nbsp;<span><a href="meeting.do">+</a></span></h3> 
      </div>
   
	
      <div class="row">
     <div class="col-md-4">
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
      </div>
	</c:when>

<c:otherwise>
    <div class="main">
         <h3>참여모임 &nbsp;&nbsp;&nbsp;<span><a href="meeting.do">+</a></span></h3> 
      </div>
     
     <div class="row">
     <div class='card-deck mt-3'>
     <c:forEach var="arr" items="${list}">
         <div class='card' onclick="show(${arr.meeting_m_idx},${sessionScope.s_user.user_idx})">
              <div class='reviewImg' style="overflow: hidden;">
            <c:set var="arrImg" value="${fn:split(arr.meeting_m_file,',')}"></c:set>
            <c:forEach var="img" items="${arrImg}" varStatus="i">
	            <div id="mod_img">
	           	 <img id="img_img" alt="" src="${pageContext.request.contextPath}/img/meeting/${arr.meeting_m_idx}/${img}">
	           	 </div>
            </c:forEach>
            </div>
            <div class='card-body'>
               <p class='card-text'>이름 : ${arr.user_nickname}</p>
               <p class='card-text'>제목 : ${arr.meeting_m_subject}</p>
               <p class='card-text'>인원 : ${arr.meeting_m_total} </p>
               <p class='card-text'>장소 : ${arr.meeting_m_location} </p>
            </div>
            <div class='card-footer'>
                <c:choose>
               	<c:when test="${arr.day > 0}">
               		<small class='text-muter'>${arr.day}일 전</small>
               	</c:when>
               	<c:when test="${arr.hour > 0}">
               		<small class='text-muter'>${arr.hour}시간 전</small>
               	</c:when>
               	<c:when test="${arr.minute > 0}">
               		<small class='text-muter'>${arr.minute}분 전</small>
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
	ajax 보기
	<-- --%>
    <c:set var="dto" value="${dto}"></c:set>
    <div id="contentLayer" style="position: absolute; top:95%; left: 27%; display: none; width: 600px; z-index: 1">
       <div class='card-deck mt-3'>
         <div class='card'>
            <div class='reviewImg' style="overflow: hidden;">
            	<div id="mod_img">
	           	 <img id="img_img" alt="" src="">
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
            <div id="j_list"></div>
            
            
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
</div>
<%@ include file="../footer.jsp" %>
</body>
</html>