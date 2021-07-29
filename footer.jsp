<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel='stylesheet' href='css/meeting/allContent.css'>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css" integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay" crossorigin="anonymous">

<style>
  .chat_body {
    overflow: auto;
  }
  .chat_body::-webkit-scrollbar {
    width: 10px;
  }
  .chat_body::-webkit-scrollbar-thumb {
    background-color: lightgray;
    border-radius: 10px;
    background-clip: padding-box;
    border: 2px solid transparent;
  }

  body::-webkit-scrollbar-thumb{
  	background-color: lightgray;
    border-radius: 10px;
    background-clip: padding-box;
    border: 2px solid transparent;
    
  }
  body::-webkit-scrollbar {
    width: 10px;
    height: 0px;
    
  }
  .chatMessageArea{
  	overflow: scroll;
  }

</style>
<script>

var chat_room_idx;
var chat_to_idx;
var chat_room_type;
var from_idx = '${sessionScope.s_user.user_idx}'?'${sessionScope.s_user.user_idx}':'${cookie.firstVisit.value}';
var socket=null;

document.addEventListener("DOMContentLoaded", function(){
	
	connect();
});

function connect(){
	
	var uri = "wss://" + location.href.substring(7,location.href.lastIndexOf('morepet'))+"morepet/websocket.do?idx="+from_idx;
	
	socket = new WebSocket(uri);
	
	socket.onopen = function(){
		
	}
	socket.onclose = function(){
		
	}
	socket.onerror = function(){
		
	}
	
	//소켓으로부터 메세지 받았을때 호출
	socket.onmessage = function(event){
		
		
		var data = event.data;
		var obj = JSON.parse(data)
		console.log(obj);
		console.log(data);
		if(obj.message_type == 'chatJoin'){
			
			show_chat_list(obj.room_idx);
			
		}else if(obj.message_type == 'chat' || obj.message_type == 'img'){
			
			if(obj.message_from == from_idx){
				
				appendMyMsg(obj);
				
			}else{
				appendMsg(obj);
				var idx = user_name = 'guest' ? 'guest' : 'message_from';
				$('div#socketMsg').css('display', '');
				$('div#socketMsg').html(
					"<div class='col-12 p-2'>"+
						"<div class='col-4 p-0' style='float: left;'>"+
							"<img class='img-fluid' src='${pageContext.request.contextPath}/user/"+idx+"/profile.png' style='width: 50px; height: 50px;'>"+
						"<div style='font-size: 9px; clear: both;'>"+obj.user_name+"</div>"+
						"</div>"+
						"<div class='col-10 font'style='float: left;' >"+
							"<div style='float:left; display: inline-block; background-color: white; padding:5px;  border-radius: 10px; font-size : 15px;'>"+obj.message_content+"</div>"+
						"</div>"+
					"</div>"
				);
				setTimeout( function() {
					$('div#socketMsg').css('display', 'none');
				}, 5000);
			}
			$("#chatMessageArea").scrollTop($("#chatMessageArea")[0].scrollHeight);
		
		}else{
			
			$('div#socketAlert').css('display', '');
			$('div#socketAlert').html(obj.message_content);
			
			setTimeout( function() {
				$('div#socketAlert').css('display', 'none');
			}, 5000);
		}
	}
}
	 //웹소켓 종료 
function disconnect(){
    socket.close();
}
	 
//메세지 전송 함수 : 입력된 글자를 불러와서 서버에 전송
function send(type,to_idx,msg) {
	
	if(to_idx === '-1'){ to_idx = chat_room_idx};
	
	message = {};
    
    if(type == 'chatJoin'){
    	
    	if(msg == 'user'){
    		
	    	message.message_type = type;
	    	message.message_to = to_idx;
	    	message.message_from = from_idx;
	    	message.message_sendTime = getTimeStamp();
	    	socket.send(JSON.stringify(message));
	    	
    	}else{
    		
    		message.message_type = type;
    		message.room_idx = to_idx;
    		message.message_from = from_idx;
    		message.message_sendTime = getTimeStamp();
	    	socket.send(JSON.stringify(message));
	    	
    	}
    	
    }else if(type == 'alarm'){
    	
    	alarm = {};
    	alarm.message_type = 'alarm';
    	alarm.message_content = msg;
    	alarm.message_to = to_idx;
    	alarm.message_sendTime = getTimeStamp();
    	socket.send(JSON.stringify(alarm));
    	
   	}else {
   		
		if(msg){
			
	   		if('${sessionScope.s_user}'){
	   			
	   			message.message_name = '${sessionScope.s_user.user_name}';
	   			message.message_img = '${sessionScope.s_user.user_img}';
	   			
	   		}else{
	   			
	   			message.message_name = 'guest';
	   			message.message_img = 'guest';
	   			
	   		}
	   		
	   		message.message_from = from_idx;
			message.message_type = type;
	   		message.room_idx = to_idx;
	   		message.message_content = msg;
			message.message_sendTime = getTimeStamp();
			
			if(message.message_from !=message.message_to){
				
	   			socket.send(JSON.stringify(message));
	   			$("#chat_message_inform").val("");//메세지 창 지우기
	   			
			}
		}
    }
}
			//[idx , user or room]
function joinRoom(idx,to_type){
	document.getElementById('chat_form').style.display ='';
	document.getElementById('chat_message').style.display='';
	document.getElementById('chat_input').style.display='';
	send('chatJoin',idx,to_type);
	
}

function getTimeStamp() {
	var d = new Date();
	var s = leadingZeros(d.getFullYear(), 4) + '-'
			+ leadingZeros(d.getMonth() + 1, 2) + '-'
			+ leadingZeros(d.getDate(), 2) + ' ' 
			+ leadingZeros(d.getHours(), 2) + ':'
			+ leadingZeros(d.getMinutes(), 2) + ':'
			+ leadingZeros(d.getSeconds(), 2);
	return s;
}

function leadingZeros(n, digits) {
	var zero = '';
	n = n.toString();

	if (n.length < digits) {
		for (i = 0; i < digits - n.length; i++)
			zero += '0';
	}
	return zero + n;
}
</script>  
<script>
function get_alarm_list(){
	$.ajax({
		url: 'getAlarmList.do?user_idx='+from_idx,
        success: function(result){
        	$("#chat_allAlarm").empty();
        	for(i = 0; i < result.alarmList.length; i++){
        		$("#chat_allAlarm").append(
					'<div style="margin:5px 10px 5px 10px; border-radius: 10px; background-color:white; width: 330px; height: 50px">'+
						'<div style="text-align:right; font-size: 12px; padding-right:5px">'+result.alarmList[i].message_sendTime+'</div>'+
						'<div style="padding-left:5px">'+result.alarmList[i].message_content+'</div>'+
					'</div>'
				);        	
        	}
        }
    });
}

function get_room_list(user_idx){
	$.ajax({
		url: 'getRoomList.do?user_idx='+user_idx,
        success: function(result){
        	
        	$("#chat_allRoom").empty();
        	var chat_room ='';
        	for(i = 0; i < result.roomList.length; i++){
        		
        		var name ='';
        		var idx = '';
        		if(result.roomList[i].room_type == 1 ){
        		
        			name = result.roomList[i].room_name;
        			idx = result.roomList[i].user_idx.split(',');
        		}else{
        		
	        		name = result.roomList[i].user_name;
	        		idx = result.roomList[i].user_idx
        		}
        		
        		var u_img =result.roomList[i].room_type == 1 ? 'room' : result.roomList[i].user_name == 'guest' ? 'guest' : idx;
        		var content = result.roomList[i].message_type == 'img' ? '사진' : result.roomList[i].message_content;
        		chat_room += '<div style="margin:5px 10px 5px 10px; padding : 1px;border-radius: 10px; background-color:white; width: 330px; height: 70px;" onclick="show_chat_list('+result.roomList[i].room_idx+');">'+
			 					'<div style="border-radius:10px; background-color:yellow; float: left; width: 20%;height: 68px; margin-right:10px;"><img alt="프로필" src="${pageContext.request.contextPath}/'+
			 					'user/'+u_img+'/profile.png" style="width: 68px; height: 68px; border-radius: 10px; "></div>'+
			 					'<div style="float:right;">'+result.roomList[i].message_sendTime+'</div><div> '+name+'</div>'+
			 					'<div class"text-center">'+content+'</div>'+
		 	 				'</div>';
        		
        	}
        	$("#chat_allRoom").append(chat_room);
        	
        }
    });
}

function get_message_list(room_idx){
	
	$.ajax({
		url: 'getMessageList.do?room_idx='+room_idx,
        success: function(result){
        	
        	$("#chatMessageArea").empty();
      
        	for(i = 0; i < result.messageList.length; i++){
        		
        		if(result.messageList[i].message_from == from_idx){
        			
        			appendMyMsg(result.messageList[i]);
        			
        		}else{
        			appendMsg(result.messageList[i]);
        		}
        	}
    		$("#chatMessageArea").scrollTop($("#chatMessageArea")[0].scrollHeight);
        }
    });
}

function appendMsg(msg){
	
	var msgContent = msg.message_type == "img" ? "<a href='filedown2.do?room_idx="+chat_room_idx+"&filename="+msg.message_content+".png'><img style = 'width:200px; 'src='${pageContext.request.contextPath}/chat/"+chat_room_idx+"/"+msg.message_content+".png'></a>" : msg.message_content;
	var u_img = msg.user_name == 'guest' ? 'guest' : msg.message_from;
	
	$("#chatMessageArea").append(
		"<div class='col-10 p-2'>"+
			"<div class='col-2 p-0' style='float: left;'>"+
				"<img src='${pageContext.request.contextPath}/user/"+u_img+"/profile.png' style='width: 50px; height: 50px;border-radius: 10px;'>"+
				"<div style='font-size: 15px; clear: both; text-align: center;'>"+msg.user_name+"</div>"+
			"</div>"+
			"<div class='col-10 font' style='float: left;'>"+
				"<div style='float:left; display: inline-block; background-color: white; padding:5px;  border-radius: 10px; font-size : 15px;'>"+msgContent+"</div>"+
				"<div style='clear:both; font-size: 10px; text-align: left;'>"+msg.message_sendTime+"</div>"+
			"</div>"+
		"</div>"
	);
	
}

function appendMyMsg(msg){

	var msgContent = msg.message_type == "img" ? "<a href='filedown2.do?room_idx="+chat_room_idx+"&filename="+msg.message_content+".png'><img style = 'width:200px; 'src='${pageContext.request.contextPath}/chat/"+chat_room_idx+"/"+msg.message_content+".png'></a>" : msg.message_content;
	$("#chatMessageArea").append(
		"<div class='col-12 m-0 p-0' style='float:right'>"+
			"<div class='col-10 font mt-2 p-1' style='float:right;'>"+
				"<div style = 'float:right; display: inline-block; border-radius: 10px; background-color:yellow; font-size : 15px; padding : 5px;'>"+msgContent+"</div>"+
				"<div style = 'clear:both; font-size:9px; text-align:right; '>"+msg.message_sendTime+"</div>"+
			"</div>"+
		"</div>"
	);	
}

function chat_close(){
	document.getElementById('chat_form').style.display = 'none';
}

function chat_start(){
	
	document.getElementById('chat_form').style.display ='';
	get_alarm_list();
	show_alarm_list();
}

function show_alarm_list(){
	$('.adminChat').css('display','');
	document.getElementById('chat_message').style.display='none';
	document.getElementById('chat_input').style.display='none';
	document.getElementById('chat_allAlarm').style.display='';
	document.getElementById('chat_allRoom').style.display='none';
	$('#alarmBtn').css('border','1px solid black');
	$('#msgBtn').css('border','none');
}

function show_room_list(){
	$('.adminChat').css('display','');
	document.getElementById('chat_message').style.display='none';
	document.getElementById('chat_input').style.display='none';
	document.getElementById('chat_allRoom').style.display='';
	document.getElementById('chat_allAlarm').style.display='none';
	$('#alarmBtn').css('border','none');
	$('#msgBtn').css('border','1px solid black');
	
	get_room_list(from_idx);
}

function show_chat_list(room_idx){
	
	chat_room_idx = room_idx;
	$('.adminChat').css('display','none');
	document.getElementById('chat_input').style.display='';
	document.getElementById('chat_message').style.display='';
	document.getElementById('chat_allRoom').style.display='none';
	document.getElementById('chat_allAlarm').style.display='none';
	get_message_list(room_idx);
	
}

function enterkey() { 
	if (window.event.keyCode == 13){
		$("#chat_send").click();
	}
		
}

</script>

<link rel='stylesheet' href='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css' />
<style>

</style>    
    
<div class='mt-3 footerLine'>
      <div class='footer'  style="display: none;">

      
         INFO.<br> COMPANY : ㈜현명수 OWNER : 현명수 TEL : 010-0000-0000 /
         02-0000-0000 ADD : 00000 서울특별시 중구 명동 88 에이콘아카데미 15F 1 class <br>
         COPYRIGHT © HYUN ALL RIGHTS RESERVED. DESINES BY SOMETHING HOSTING BY
         HONG㈜
      </div>
</div>

<span style= "position:fixed;right: 10px; ;bottom: 10px;; z-index: 3; ">
	<img alt="채팅이미지" src="images/msg.jpeg" style="border-radius: 70%;overflow: hidden;width: 60px; height: 60px;" onclick="chat_start();">
</span>
<div id = "socketMsg" style = 'position:fixed;right: 15px; ;bottom: 5px;; z-index: 5; display: inline-block; border-radius: 10px; background-color:white; font-size : 15px; padding : 5px; display: none;'></div>

<div id="chat_form" class="font" style="border: 1px solid black;font-size:15px; border-radius: 30px;overflow:hidden;  background: linear-gradient( to top, white, skyblue ); position:fixed;right: 2% ;bottom: 3%; border: 1px solid balck; width: 350px; height: 700px; display: none; box-shadow: rgba(0, 0, 0, 0.05) 0px -3px 7px;z-index: 4">
	<div style="width: 350px; height: 650px; position: relative;">
		
		<div id="chat_header">	
			<div style="width: 100%;height: 50px;">
				<span style="padding-left:20px; height: 50px; vertical-align:middle; text-align: center; font-size: 30px; color: white">
					<b>MORE PET</b>
				</span>
				<span style="margin-left: 140px; font-size: 20px; color: white;" onclick="chat_close();">X</span>
			</div>
			
			<div style="width: 50%; float: left;">
				<button id="alarmBtn" style="background-color:white; color: black; width: 100%;height: 50px; " onclick="show_alarm_list();">알림</button>
			</div>
			
			<div style="width: 50%; display: inline-block;">
				<button id="msgBtn" style="background-color:white; color:black;width: 100%;height: 50px;" onclick="show_room_list();">메세지</button>
			</div>
		</div>
		
		<div class='chat_body'>
		
			<div id="chat_allAlarm" style="height: 550px;"></div>
			
			<div id="chat_allRoom" style="display: none;"></div>	
			
			<div id = "chat_message" style="margin: auto; height: 550px;  display: none;">
				<div class="row col-12 m-0 p-0" id="chatMessageArea" style="margin-top: 10px;"></div>
			</div>
		</div>
		
	</div>
	<c:if test="${s_user.user_grade != 'admin'}">
		<div class="adminChat col-12" style="position: absolute; text-align: center; bottom: 20px">
			<span style="border-radius:12px; background-color: white; display:inline-block; height: 50px; margin:auto;">
       			<button type="button" class="btn btn-outline-warning font" style="border-radius:12px; width: 150px; height: 50px; font-size: 20px" onclick="joinRoom('2','user')">관리자문의</button>
       		</span>
       	</div>
    </c:if>
	
		<div class="input-group" id = "chat_input"  style=" width: 100%; height: 50px; text-align: center; display: none;">
			<form id="chat_img_send" style="margin: 5px;">
				<span class="input-group-addon" style="width: 40px; font-size: 23px;" onclick="document.all.upload.click()">
					<i class="fas fa-camera"></i>
					<input type="file" id = "img_upload" name="upload" style="display:none;" onchange="sendImg(event);">
				</span>
			</form>
			<input class="form-control" id="chat_message_inform" onkeyup="enterkey();" style="height: 35px; font-size: 15px;" type="text" placeholder="메세지를 입력해 주세요" >
			<span class="input-group-addon" id ="chat_send" style="width: 40px; font-size: 23px;" onclick="send('chat', '-1' ,$('#chat_message_inform').val())">
				<i class="far fa-paper-plane"></i>
			</span>
			
		</div>
	
</div>
<script>
function sendImg(event) {
	
	var form = $('#chat_img_send')[0];
	var formData = new FormData(form);
	formData.append("img_name", new Date().getTime());
	formData.append("room_idx", chat_room_idx);

	$.ajax({
		url : 'chatImage.do',
		processData : false,
		contentType : false,
		data : formData,
		type : 'POST',
		success : function(result) {
			
			send(result.type, chat_room_idx, result.message);	
		}
	});
}
</script>
