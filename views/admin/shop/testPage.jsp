<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9f3f24a06560fac474174445cd48dc94"></script>
<style type="text/css">
.item img{
display: block;
width: 100%;
height: 100%;
overflow: hidden;
object-fit: cover;
margin: 0px auto;
}
.carousel-inner{
width: 100%;
height: 600px;
margin: 0;
}
.table tbody tr td{
border: 0;
}
.my-calendar {
width: 100%;
margin: auto;
padding: 20px 20px 10px;
text-align: center;
font-weight: 800;
cursor: default;
}
.cal-year{
font-size: 30px;
}
.cal-month{
font-size: 30px;
}
.btn-cal {
position: relative;
float: left;
width: 25px;
height: 25px;
margin-top: 5px;
font-size: 16px;
cursor: pointer;
border: none;
background: none;
}
.btn-cal:after {
content: '<';
position: absolute;
top: 0;
left: 0;
width: 100%;
height: 100%;
line-height: 25px;
font-weight: bold;
font-size: 20px;
}
.ctr-box .btn-cal.next {
float: right;
}
.ctr-box .btn-cal.next:after {
content: '>';
}
.cal-table {
width: 100%;
border: 1px solid white;
}
.cal-table th {
width: 14.2857%;
padding-bottom: 15px;
padding-top: 15px;
font-size: 20px;
font-weight: 900;
}
.cal-table td {
border: 1px solid white;
padding: 3px 0;
height: 50px;
font-size: 15px;
vertical-align: middle;
}
.cal-table td.day {
position: relative;
}
.cal-table td.posible {
background: #71A2FF;
color: white;
}
.cal-table td.imposible {
background: #F2F3F7;
color: gray;
}
.cal-table td.has-event:after {
content: '';
display: block;
position: absolute;
left: 0;
bottom: 0;
width: 100%;
height: 4px;
background: #FFC107;
}
</style>
<script>
$(function() {
$('#carousel-example-generic').carousel({
interval : 3000,
pause : "hover",
wrap : true,
keyboard : true
});
});
</script>
</head>
<body>


<script src="js/default.js"></script>
<link rel="stylesheet" href="css/default.css">
<link rel="stylesheet" href="css/index.css">
<link rel="stylesheet" href="css/header_bar.css">
<link rel="stylesheet" media="( min-width:701px ) and ( max-width:1000px )" href="css/tablet.css">
<link rel="stylesheet" media="( min-width:0px ) and ( max-width:700px )" href="css/mobile.css">
<link rel="stylesheet" href="css/starability-all.min.css">
<header>
<div id="socketAlert" class="alert alert-info" role="alert" style="display: none;"></div>
<div class="left">
<h1><a href="index.do">morepet</a></h1>
<a href="#a" class="all">all Menu</a>
<div class="nav">
<h2>Menu</h2>
<nav>
<ul>
<li><a href="#a">산책</a>
<!-- <div class="cbp-hrsub">
<div class="cbp-hrsub-inner">
<div>
<h4>Learning &amp; Games</h4>
<ul>
<li><a href="#">Catch the Bullet</a></li>
<li><a href="#">Snoopydoo</a></li>
<li><a href="#">Fallen Angel</a></li>
<li><a href="#">Sui Maker</a></li>
<li><a href="#">Wave Master</a></li>
<li><a href="#">Golf Pro</a></li>
</ul>
</div>
</div>/cbp-hrsub-inner
</div>/cbp-hrsub -->
</li>
<li><a href="bookMain.do">시터</a>
<!-- <div class="cbp-hrsub">
<div class="cbp-hrsub-inner">
<div>
<h4>Entertainment</h4>
<ul>
<li><a href="#">Gadget Finder</a></li>
<li><a href="#">Green Tree Express</a></li>
<li><a href="#">Green Tree Pro</a></li>
<li><a href="#">Holy Cannoli</a></li>
<li><a href="#">Wobbler 3.0</a></li>
<li><a href="#">Coolkid</a></li>
</ul>
</div>
<div>
<h4>Games</h4>
<ul>
<li><a href="#">Catch the Bullet</a></li>
<li><a href="#">Snoopydoo</a></li>
<li><a href="#">Fallen Angel</a></li>
<li><a href="#">Sui Maker</a></li>
<li><a href="#">Wave Master</a></li>
<li><a href="#">Golf Pro</a></li>
</ul>
</div>
</div>/cbp-hrsub-inner
</div>/cbp-hrsub -->
</li>
<li><a href="meeting.do">모임</a>
<!-- <div class="cbp-hrsub">
<div class="cbp-hrsub-inner">
<div>
<h4>Education</h4>
<ul>
<li><a href="#">Learn Thai</a></li>
<li><a href="#">Math Genius</a></li>
<li><a href="#">Chemokid</a></li>
</ul>
<h4>Professionals</h4>
<ul>
<li><a href="#">Success 1.0</a></li>
<li><a href="#">Moneymaker</a></li>
</ul>
</div>
</div>/cbp-hrsub-inner
</div>/cbp-hrsub -->
</li>
<li><a href="shopMain.do">쇼핑몰</a>
<!-- <div class="cbp-hrsub">
<div class="cbp-hrsub-inner">
<div>
<h4>Entertainment</h4>
<ul>
<li><a href="#">Gadget Finder</a></li>
<li><a href="#">Green Tree Express</a></li>
<li><a href="#">Green Tree Pro</a></li>
<li><a href="#">Holy Cannoli</a></li>
<li><a href="#">Wobbler 3.0</a></li>
<li><a href="#">Coolkid</a></li>
</ul>
</div>
</div>/cbp-hrsub-inner
</div>/cbp-hrsub -->
</li>
<li><a href="lostPet.do">유기동물</a>
<!-- <div class="cbp-hrsub">
<div class="cbp-hrsub-inner">
<div>
<h4>Utilities</h4>
<ul>
<li><a href="#">Green Tree Pro</a></li>
<li><a href="#">Wobbler 3.0</a></li>
<li><a href="#">Coolkid</a></li>
</ul>
<h4>Education</h4>
<ul>
<li><a href="#">Learn Thai</a></li>
<li><a href="#">Math Genius</a></li>
<li><a href="#">Chemokid</a></li>
</ul>
</div>
<div>
<h4>Professionals</h4>
<ul>
<li><a href="#">Success 1.0</a></li>
<li><a href="#">Moneymaker</a></li>
</ul>
</div>
</div>/cbp-hrsub-inner
</div>/cbp-hrsub -->
</li>
<li>
<a href="#a">메인페이지</a>
</li>
</ul>
</nav>
<div>
<a href="logout.do">로그아웃</a>
<a href="sitterMypage.do">시터페이지</a>
</div>
<a href="#a" class="close">Close</a>
</div>
</div>
<ul>
<li>
<div><a href="logout.do">로그아웃</a></div>

</li>
<li>
<a href="sitterMypage.do?user_idx=4">시터페이지</a>
</li>
<li class="join"><a href="userJoin.do">Join us</a></li>
</ul>
</header>
<div class="dim"></div>
<div style="width: 100%; margin: 0; padding-top: 125px;">
<div id="carousel-example-generic" class="carousel slide">
<ol class="carousel-indicators">
<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
<li data-target="#carousel-example-generic" data-slide-to="1" class="active"></li>
</ol>
<div class="carousel-inner" role="listbox">
<div class="item active">
<img src="/morepet/sitter/4/background0.png" style=" object-fit: fill ;width: 100%;">
<div class="carousel-caption" style="color: white;">시터 집안 이미지</div>
</div>
<div class="item">
<img src="/morepet/sitter/4/background1.png" style=" object-fit: fill ;width: 100%;">
<div class="carousel-caption" style="color: white;">시터 집안 이미지</div>
</div>
</div>
<a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
</a>
<a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
</a>
</div>
</div>
<div class='container' style="padding-top: 80px;">
<div><h3 class="titleFont " style="color: white;">시터 프로필</h3></div>
<div id="left" class="col-sm-7">
<div class="col-sm-12">
<div class="card">
<div class="card-body font">
<div class="table-responsive">
<table class="table">
<tbody>
<tr style="line-height:32px;">
<td rowspan="2" style="width: 100px;">
<img src="/morepet/sitter/4/background0.png" style="width: 70px; height: 70px; border-radius: 12px;">
</td>
<td>
test
</td>
</tr>
<tr>
<td>서울 서대문구 신촌동펫시터zz님</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
<div class="pt-5"></div>
<div class="card">
<div class="card-header font">zz님을 소개합니다</div>
<div class="card-body font">
<table class="table">
<tbody>
<tr style="line-height:32px;">
<td style="font-size: 15px;">
test
</td>
</tr>
</tbody>
</table>
</div>
</div>
<div class="pt-5"></div>
<div class="card">
<div class="card-header font">자격증 및 수료증</div>
<div class="card-body font">
<table class="table">
<tbody>
<tr style="line-height:32px;">
<td rowspan="2" style="text-align: center;">
<img src="/morepet/sitter/4/background0.png" style="width: 200px; height: 130px; margin: auto;">
</td>
<td style="font-size: 18px;">펫시터 전문가 교육</td>
</tr>
<tr style="font-size: 18px;">
<td>이젠 아카데미</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
<div class="center" class="col-sm-5">
<div class="col-sm-5">
<div class="card">
<div class="card-header font">이용요금</div>
<div class="card-body font">
<table class="table">
<tbody>
<tr style="line-height:32px;">
<td colspan="3" style="font-size: 15px; text-align: right;">1박 케어 &nbsp&nbsp|&nbsp&nbsp 데이케어 </td>
</tr>
<tr style="line-height:32px;">
<td style="font-size: 15px;">소형견&nbsp(7키로 미만) </td>
<td colspan="2" style="font-size: 15px; text-align: right;">
예약불가&nbsp &nbsp&nbsp&nbsp예약불가
</td>
</tr>
<tr style="line-height:32px;">
<td style="font-size: 15px;">중형견&nbsp(7~15키로) </td>
<td style="font-size: 15px; text-align: right;">
예약불가&nbsp &nbsp&nbsp&nbsp예약불가
</td>
</tr>
<tr style="line-height:32px;">
<td style="font-size: 15px;">대형견&nbsp(15키로 이상) </td>
<td style="font-size: 15px; text-align: right;">
예약불가&nbsp &nbsp&nbsp&nbsp예약불가
</td>
</tr>
</tbody>
</table>
</div>
</div>
<div class="pt-5"></div>
<div class="card">
<div class="card-header font">예약 가능 날짜</div>
<div class="card-body font">
<div class="my-calendar clearfix">
<div class="calendar-box">
<div class="ctr-box clearfix">
<button type="button" title="prev" class="btn-cal prev">
</button>
<span class="cal-year"></span> &nbsp&nbsp<span class="cal-month"></span>
<button type="button" title="next" class="btn-cal next">
</button>
</div>
<table class="cal-table">
<thead>
<tr>
<th>일</th>
<th>월</th>
<th>화</th>
<th>수</th>
<th>목</th>
<th>금</th>
<th>토</th>
</tr>
</thead>
<tbody class="cal-body"></tbody>
<tfoot>
<tr>
<td colspan="7" style="text-align: center;">
<div style="display: flex; flex-direction: row; justify-content: space-between; margin-left: 15%; margin-right: 15%;">
<div style="display: flex; flex-direction: row; align-items: center;">
<div style="background-color: #71A2FF; width: 15px; height: 15px; margin-right: 8px;"></div>
이용 가능 날짜
</div>
<div style="display: flex; flex-direction: row; align-items: center;">
<div style="background-color: #F2F3F7; width: 15px; height: 15px; margin-right: 8px;"></div>
예약 불가 날짜
</div>
</div>
</td>
</tr>
</tfoot>
</table>
</div>
</div>
</div>
</div>
<div class="pt-5"></div>
<div class="card">
<div class="card-header font">펫시터님 위치<span style="margin-left: 30%;">서울 서대문구 신촌동</span></div>
<div class="card-body font" style="padding: 0;">
<table class="table" style="margin: 0">
<tbody>
<tr style="line-height:32px;">
<td style="padding: 0 ; width: 100%; height: 300px;">
<div id="map" style="width: 100%px;height:100%;"></div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
<div class="text-center mt-5 mb-5">
<span style="border-radius:12px; background-color: white; display:inline-block; height: 50px;">
<button type="button" class="btn btn-outline-primary font" style="border-radius:12px; width: 150px; height: 50px; font-size: 20px" onclick="location.href = 'updateProfile.do?user_idx=4'">수정하기</button>
</span>
</div>

<link rel='stylesheet' href='css/meeting/allContent.css'>
<script type="text/javascript" src="js/httpRequest.js"></script>
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
</style>
<script>
var from_idx = '4'?'4':'210202183952';

var socket=null;
document.addEventListener("DOMContentLoaded", function(){
connect();
});

function connect(){
var uri = "ws://" + location.href.substring(7,location.href.lastIndexOf('morepet'))+"morepet/websocket.do?idx="+from_idx;
socket = new WebSocket(uri);
socket.onopen = function(){
alert('소켓서버와 연결됨');
}
socket.onclose = function(){
alert('소켓서버와 연결 종료됨');
}
socket.onerror = function(){
alert('소켓서버 연결중 오류발생');
}
socket.onmessage = function(event){
var data = event.data;
var obj = JSON.parse(data)
if(obj.message_type == 'chat'){
appendMessage(obj.message_content);
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
function appendMessage(msg) {

if(msg){
return;
}else{

var t = getTimeStamp();
$("#chatMessageArea").append("<div class='col-12 row' style = 'height : auto; margin-top : 5px;'><div class='col-2' style = 'float:left; padding-right:0px; padding-left : 0px;'><img id='profileImg' class='img-fluid' src='/displayFile?fileName=&directory=profile' style = 'width:50px; height:50px; '><div style='font-size:9px; clear:both;'></div></div><div class = 'col-10' style = 'overflow : y ; margin-top : 7px; float:right;'><div class = 'col-12' style = ' background-color:#ACF3FF; padding : 10px 5px; float:left; border-radius:10px;'><span style = 'font-size : 12px;'>"+msg+"</span></div><div col-12 style = 'font-size:9px; text-align:right; float:right;'><span style ='float:right; font-size:9px; text-align:right;' >"+t+"</span></div></div></div>")

var chatAreaHeight = $("#chatArea").height();
var maxScroll = $("#chatMessageArea").height() - chatAreaHeight;
$("#chatArea").scrollTop(maxScroll);
}
}
//메세지 전송 함수 : 입력된 글자를 불러와서 서버에 전송
function send(type,to_idx,msg){
if(type == 'chat'){
if(msg){
message = {};
if('more.user.model.UserDTO@5da3433c'){
message.message_from = '4';
message.message_name = 'zz';
message.message_img = '1234';
}else{
message.message_from = '210202183952';
message.message_name = 'guest';
message.message_img = 'guest';
}
message.message_type = type;
message.message_to = to_idx;
message.message_content = msg;
message.message_sendTime = getTimeStamp();
if(message.message_from !=message.message_to){
socket.send(JSON.stringify(message));
$("#chat_message_inform").val("");//메세지 창 지우기
$("#chatMessageArea").append(
"<div style = 'height : auto; margin-top : 5px; text-align: right;'>"+
"<div style = 'float:left; padding-right:0px; padding-left : 0px;'></div>"+
"<div style = 'overflow : y ; margin-top : 7px; float:right;'>"+
"<div style = ' background-color:#ACF3FF; padding : 10px 5px; float:left; border-radius:10px;'>"+
"<span style = 'font-size : 12px;'>"+msg+"</span>"+
"</div>"+
"<div col-12 style = 'font-size:9px; text-align:right; float:right;'>"+
"<span style ='float:right; font-size:9px; text-align:right;' >"+message.message_sendTime+"</span>"+
"</div>"+
"</div>"+
"</div>");
}
}
}else if(type == 'alarm'){
alarm = {};
alarm.message_type = 'alarm';
alarm.message_content = msg;
alarm.message_to = to_idx;
alarm.message_sendTime = getTimeStamp();
socket.send(JSON.stringify(alarm));
}
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
url: 'getAlarmList.do?user_idx=4',
success: function(result){
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

function chat_close(){
document.getElementById('chat_form').style.display = 'none';
}

function chat_start(){
document.getElementById('chat_form').style.display ='';
get_alarm_list();
show_alarm_list();
}

function show_alarm_list(){
document.getElementById('chat_message').style.display='none';
document.getElementById('chat_input').style.display='none';
document.getElementById('chat_allAlarm').style.display='';
document.getElementById('chat_allRoom').style.display='none';
$('#alarmBtn').css('border','1px solid black');
$('#msgBtn').css('border','none');
}

function show_room_list(){
document.getElementById('chat_message').style.display='none';
document.getElementById('chat_input').style.display='none';
document.getElementById('chat_allRoom').style.display='';
document.getElementById('chat_allAlarm').style.display='none';
$('#alarmBtn').css('border','none');
$('#msgBtn').css('border','1px solid black');
var user_idx = 'more.user.model.UserDTO@5da3433c'?'4':'210202183952'
sendRequest('showRoomList.do','user_idx=user_idx',show_room_list_result,'GET');
}

function show_room_list_result(){
if(XHR.readyState==4){
if(XHR.status==200){
data = XHR.responseText;
data = eval('('+data+')');
list = data.roomList;
var msg="";
for(i=0;i<list.length;i++){
dto = list[i];
msg+='사번:'+dto.message_content+'이름:'+dto.message_sendTime;
}
}
}
}

function show_chat_list(to_idx){
document.getElementById('chat_input').style.display='';
document.getElementById('chat_message').style.display='';
document.getElementById('chat_allRoom').style.display='none';
document.getElementById('chat_allAlarm').style.display='none';
sendRequest('showChatList.do','to_idx='+to_idx,show_chat_list_result,'GET');
}

function show_chat_list_result(){
if(XHR.readyState==4){
if(XHR.status==200){
data = XHR.responseText;
data = eval('('+data+')');
list = data.roomList;
var msg="";
for(i=0;i<list.length;i++){
dto = list[i];
msg+='사번:'+dto.message_content+'이름:'+dto.message_sendTime;
}
}
}
}


</script>

<link rel='stylesheet' href='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css' />
<style>

</style>
<div class='mt-3 footerLine'>
<div class='footer'>
INFO.<br> COMPANY : ㈜현명수 OWNER : 현명수 TEL : 010-0000-0000 /
02-0000-0000 ADD : 00000 서울특별시 중구 명동 88 에이콘아카데미 15F 1 class <br>
COPYRIGHT © HYUN ALL RIGHTS RESERVED. DESINES BY SOMETHING HOSTING BY
HONG㈜
</div>
</div>

<span style= "position:fixed;right: 2% ;bottom: 3%;"><img alt="채팅이미지" src="images/msg.jpeg" style="border-radius: 70%;overflow: hidden;width: 70px; height: 70px;" onclick="chat_start();"><span id="totalCount">0</span></span>
<div id="chat_form" style="border-radius: 30px;overflow:hidden; background: linear-gradient( to top, white, skyblue ); position:fixed;right: 2% ;bottom: 3%; border: 1px solid balck; width: 350px; height: 700px; display: none;">
<div style="width: 350px; height: 700px; position: relative;">
<div id="chat_header">
<div style="width: 100%;height: 50px;"><span style="padding-left:20px; height: 50px; vertical-align:middle; text-align: center; font-size: 30px; color: white"><b>MORE PET</b></span><span style="margin-left: 140px; font-size: 20px; color: white;" onclick="chat_close();">X</span></div>
<div style="width: 50%; float: left;"><button id="alarmBtn" style="background-color:white; color: black; width: 100%;height: 50px; " onclick="show_alarm_list();">알림</button></div>
<div style="width: 50%; display: inline-block;"><button id="msgBtn" style="background-color:white; color:black;width: 100%;height: 50px;" onclick="show_room_list();">메세지</button></div>
</div>
<div class='chat_body'>
<div id="chat_allAlarm" style="height: 550px;"></div>
<div id="chat_allRoom" style="display: none;">
<div style="margin:5px 10px 5px 10px; border-radius: 10px; background-color:white; width: 330px; height: 70px" onclick="show_chat_list(9);">
<div style="border-radius:70%; float: left; width: 20%;height: 70px;"><img alt="프로필" src="관리자 프로필 경로" style="width: 70px; height: 70px;"></div>
<div style="margin-left: 100px;">MORE PET</div>
<div>방문해 주셔서 감사합니다 클릭하면 상담이 시작됩니다:)</div>
</div>
</div>
<div id = "chat_message" style="margin: auto; height: 550px; border-radius: 10px; overflow:scroll; display: none; background-color: white;">
<div id="chatMessageArea" style = "margin-top : 10px; margin-left:10px;"></div>
</div>
</div>
<div id="chat_input" style="position:absolute; right: 100 ;bottom: 0; width: 100%; height: 50px; line-height: 25px; text-align: center; display: none">
<hr>
<button onclick="onclick=document.all.upload.click()">사진</button>
<input type="file" name="upload" style="display:none">
<input id="chat_message_inform" style="border: none; outline: none; width: 200px;" type="text" placeholder="메세지를 입력해 주세요" >
<input type="button" value="전송" onclick="send('chat',2,$("#chat_message_inform").val()">
</div>
</div>
</div>
<!-- /include : footer -->
</body>
<script>
const init = {
monList: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
today: new Date(),
monForChange: new Date().getMonth(),
activeDate: new Date(),
getFirstDay: (yy, mm) => new Date(yy, mm, 1),
getLastDay: (yy, mm) => new Date(yy, mm + 1, 0),
nextMonth: function () {
if(this.monForChange === this.today.getMonth()+2){
return;
}
let d = new Date();
d.setDate(1);
d.setMonth(++this.monForChange);
this.activeDate = d;
return d;
},
prevMonth: function () {
if(this.monForChange === this.today.getMonth()){
return;
}
let d = new Date();
d.setDate(1);
d.setMonth(--this.monForChange);
this.activeDate = d;
return d;
},
addZero: (num) => (num < 10) ? '0' + num : num,
getIndex: function (node) {
let index = 0;
while (node = node.previousElementSibling) {
index++;
}
return index;
}
};
const $calBody = document.querySelector('.cal-body');
const $btnNext = document.querySelector('.btn-cal.next');
const $btnPrev = document.querySelector('.btn-cal.prev');
/* const $posible = document.quertSelector('.posible');
const $imposible = document.quertSelector('.imposible'); */
function loadYYMM (fullDate) {
let yy = fullDate.getFullYear();
let mm = fullDate.getMonth();
let firstDay = init.getFirstDay(yy, mm);
let lastDay = init.getLastDay(yy, mm);
let nowY = init.today.getFullYear();
let nowM = init.today.getMonth();
let nowD = init.today.getDate();
document.querySelector('.cal-year').textContent = yy+'년';
document.querySelector('.cal-month').textContent = init.monList[mm];
let trtd = '';
let startCount;
let countDay = 0;
for (let i = 0; i < 6; i++) {
trtd += '<tr>';
for (let j = 0; j < 7; j++) {
if (i === 0 && !startCount && j === firstDay.getDay()) {
startCount = 1;
}
if (!startCount) {
trtd += '<td>'
} else {
let fullDate = yy + '.' + init.addZero(mm + 1) + '.' + init.addZero(countDay + 1);
trtd += '<td class="day';
trtd += (yy > nowY) ? ' posible"' : (mm > nowM) ? ' posible"' : (countDay + 1 >= nowD) ? ' posible"' : ' imposible"';
trtd += ` data-date="1" data-fdate="">`;
}
trtd += (startCount) ? ++countDay : '';
if (countDay === lastDay.getDate()) {
startCount = 0;
}
trtd += '</td>';
}
trtd += '</tr>';
}
$calBody.innerHTML = trtd;
}
/**
* @param {string} val
*/
function createNewList (val) {
let id = new Date().getTime() + '';
let yy = init.activeDate.getFullYear();
let mm = init.activeDate.getMonth() + 1;
let dd = init.activeDate.getDate();
let date = yy + '.' + init.addZero(mm) + '.' + init.addZero(dd);
let eventData = {};
eventData['date'] = date;
eventData['memo'] = val;
eventData['complete'] = false;
eventData['id'] = id;
init.event.push(eventData);
$todoList.appendChild(createLi(id, val, date));
}
loadYYMM(init.today);
$btnNext.addEventListener('click', () => loadYYMM(init.nextMonth()));
$btnPrev.addEventListener('click', () => loadYYMM(init.prevMonth()));
</script>
<script>
var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
var options = { //지도를 생성할 때 필요한 기본 옵션
center: new kakao.maps.LatLng(37.5651616940519, 126.93927687604), //지도의 중심좌표.
level: 3 //지도의 레벨(확대, 축소 정도)
};
var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
</script>
</html>