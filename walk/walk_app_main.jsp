<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="//code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="//stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="//stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script>
var selected_pet;
var selected_pet_name;
var pet_num = ${list.size()};

window.onload=function(){
	if(pet_num==0){
		document.getElementById('content_body').innerHTML = '';
		document.getElementById('bg_black').style.display = 'block';
		document.getElementById('no_pet').style.display = 'block';
	}
	check_selected_pet();
	setPetInfo();
	getTodayWalk();
}

function select_walk(){
	if(pet_num==1){
		console.log(selected_pet);
		Android.more_walking(selected_pet);
	}else{
		$('.container').addClass('modal-open');
		$('#bg_black').css('display','block');
		
		document.getElementById(selected_pet+'_check').checked = true;
	}
}

function closeModal_forAN(){
	if(document.getElementById('bg_black').style.display == 'block'){
		document.getElementById('bg_black').style.display = 'none';	
		$('.container').removeClass('modal-open');
	}else{
		Android.downModal();
	}
	
	
}

function check_selected_pet(){
	var pet_radio = document.getElementsByName('selected_pet');
	for(var i=0; i<pet_radio.length; i++){
		if(pet_radio[i].checked==true){
			selected_pet = pet_radio[i].value;
			selected_pet_name = document.getElementById(selected_pet+'_hidden').value;
		}
	}
}

function select_pet(pet_idx){
	$('#'+selected_pet).removeClass('selected_pet');
	$('#'+selected_pet).addClass('unselected_pet');
	
	selected_pet = pet_idx;
	document.getElementById(selected_pet+'_radio').checked = true;
	selected_pet_name = document.getElementById(selected_pet+'_hidden').value;
	$('#'+pet_idx).removeClass('unselected_pet');
	$('#'+pet_idx).addClass('selected_pet');
	setPetInfo();
	getTodayWalk();
}

function setPetInfo(){
	document.getElementById('pet_name').innerHTML = selected_pet_name;
}
function move_eat(){
	var url = 'walk_app_eat.do?pet_idx='+selected_pet+'&pet_name='+selected_pet_name;
	Android.more_eat(url);
}

function getTodayWalk(){
	var today = new Date();
	var date = today.getFullYear()+''+setFixDayCount(today.getMonth()+1)+''+setFixDayCount(today.getDate());
		
		$.ajax({
			url: 'walk_app_todayWalk.do',
	   		method: 'POST',
	        data: {
	        	'date':date,
				'pet_idx':selected_pet
	        },
	        	
	        contentType : "application/x-www-form-urlencoded; charset=utf-8",
	        dataType : "json",
	        success: function (data) {
	        	var time = parseInt(data.todayWalk/60);
	        	if(time==0){
	        		document.getElementById('today_walk').innerHTML='<i class="foot_icon"></i> 오늘은 산책을 하지 않았어요.';
	        	}else{
	        		document.getElementById('today_walk').innerHTML='<i class="foot_icon"></i> 오늘은 '+time+'분 산책했어요.';
	        	}
	        },
	        error: function () {

	        
	        },
		});
	
	
}

function setFixDayCount(number) { //10 아래 월 일때 앞에 0 붙여주는 함수
	let fixNum = ""+number;
	if(fixNum.length<2){
		if (number < 10) {
		fixNum = "0" + fixNum;
	}
  }
  return fixNum;
};

function checkPet(id){
	if(document.getElementById(id).checked){
		document.getElementById(id).checked = false;
	}else{
		document.getElementById(id).checked = true;
	}
}
function startWalk(){
	var pets = document.getElementsByName('checked_pets');
	var pet_idxs = '';
	var first = false;
	for(var i=0; i<pets.length; i++){
		if(pets[i].checked){
			if(first==false){
				pet_idxs += pets[i].value;
				first = true;
			}else{
				pet_idxs += ','+pets[i].value;
			}
			
		}
	}
	console.log(pet_idxs)
	Android.more_walking(pet_idxs);
	
}
function enableStart(){
	var pets = document.getElementsByName('checked_pets');
	var enable = false;
	for(var i=0; i<pets.length; i++){
		if(pets[i].checked){
			enable = true;
			break;
		}
	}
	if(enable==false){
		if(!$('#startWalk').hasClass('unableStart')){
			$('#startWalk').removeClass('enableStart');
			$('#startWalk').addClass('unableStart');
		}
		document.getElementById('startWalk').onclick = function(){};
	}else{
		if(!$('#startWalk').hasClass('enableStart')){
			$('#startWalk').addClass('enableStart');
			$('#startWalk').removeClass('unableStart');
		}
		document.getElementById('startWalk').onclick = startWalk;
	}
}
function move_petRegister(){
	var url = 'm_walk_app_petRegister.do';
	Android.more_eat(url);
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
z-index: 1;
display:none;
}
#pet_list_form{
width: 94vw;
margin: 0px auto;
padding-top: 2vh;
height: 73vh;
overflow-y: scroll;
-ms-overflow-style: none;
}
#pet_list_form::-webkit-scrollbar{ 
display:none;
}
.pet_list_item{
width: calc(87vw/2);
height: calc(87vw/2);
margin: calc(1vw/3);
border-radius: 100%;
overflow: hidden;
}

#walk_pet_select_list{
overflow-y: scroll;
-ms-overflow-style: none;
}
#walk_pet_select_list::-webkit-scrollbar{ 
display:none;
}

.selected_pet{
border-style: solid;
border-width: 3px;
border-color: #94b8ff;
}

.unselected_pet{
border-style: solid;
border-width: 3px;
border-color: #E0E0E0;
}

#main_button_form{
width: 100vw;
height: 27vh;
padding-top: 4vh;
background-color: #E0E0E0;
border-radius: 8% 8% 0px 0px;
}
.foot_icon{
background: url('${pageContext.request.contextPath}/images/foot_icon.png');
background-size: cover;
width: 15px;
height: 15px;
display: inline-block;
background-repeat: no-repeat;
vertical-align: middle;
}
.modal_walk{
  background: #fff;
  width: 80%;
  height: 60%;
  margin: 0 auto;
  padding: 5%;
  transition: all 600ms cubic-bezier(0.86, 0, 0.07, 1);
  top: 100%;
  position: fixed;
  left: 10%;
  text-align: left;
  z-index: 2;
  border-radius: 5% 5% 0px 0px;
}
.container.modal-open .modal_walk {
  top: 40%;
}
.select_pet_item{
width: 100%;
height: 40px;
vertical-align: middle;
margin-bottom: 10px;
}
.pet_item_check{
display: none;
}
.pet_item_check + label{
	display: inline-block;
	width: 20px;
	height: 20px;
	border: 2px solid #bcbcbc;
	border-radius: 100%;
	cursor: pointer;
	vertical-align: middle;
}
.pet_item_check:checked + label{
	background-color: #94b8ff;
}

.walkStart{
width:100%; 
height: 60px; 
background-color: #94b8ff; 
bottom: 0px; 
text-align: center;
}
.enableStart{
background-color: #94b8ff; 
}
.unableStart{
background-color: #E0E0E0; 
}
</style>
</head>
<body id="body_" class="container" style="margin: 0px; padding: 0px;">
<div id="bg_black" onclick="document.getElementById('bg_black').style.display = 'none';	$('.container').removeClass('modal-open');"></div>
<div id="no_pet" style="z-index: 3; height: 100%; width: 100%; display: none; position: fixed;">
	<div style="margin: 0px auto; width: 250px; text-align: center; background-color: white; margin-top: 270px; border-radius: 15px; padding: 10px;">
		<div style="height: 50px; line-height: 50px; font-size: 18px;">등록된 반려동물이 없습니다.</div>
		<div style="background-color: #94b8ff; height: 35px; border-radius: 12px; line-height: 35px; width: 180px; margin: 0px auto; color: white;" onclick="move_petRegister();">반려동물 등록하기</div>
	</div>
</div>
<div id="content_body">
<div id="walk_pet_select_form" class="modal_walk">
	<div style="width: 100%; height: 40px; font-size: 20px; font-weight: bold;">반려견을 선택해 주세요.</div>
	<div id="walk_pet_select_list" style="width: 100%; height: 65%;">
		<c:forEach var="list" items="${list}" varStatus="1">
			<div class="select_pet_item" onclick="checkPet('${list.PET_IDX}_check'); enableStart();">
				<div style="display: inline-block; vertical-align: middle; background: url('${pageContext.request.contextPath}/pet/${list.PET_IDX}/profile.png'); border-radius: 100%; background-size: cover; width: 40px; height: 40px;"></div>
				<div style="display: inline-block; vertical-align: middle; line-height: 40px; width: 70%; font-size: 18px;">${list.PET_NAME}</div>
				<div style="display: inline-block; line-height: 40px; right: 5px; vertical-align: middle;"><input class="pet_item_check" type="checkbox" name="checked_pets" id="${list.PET_IDX}_check" value="${list.PET_IDX}" onchange="enableStart();"><label for="${list.PET_IDX}_check"></label></div>
			</div>
		</c:forEach>
	</div>
	<div id="startWalk" class="walkStart enableStart" onclick="startWalk();">
		<span style="display: inline-block; line-height: 60px; font-size: 25px; color: white; font-weight: bold;">산책시작</span>
	</div>
</div>
<div class="row" id="pet_list_form">
	<c:forEach var="list" items="${list}" varStatus="i">
	<div style="display: inline-block;">
		<div id="${list.PET_IDX}" class="pet_list_item ${i.first? "selected_pet":"unselected_pet"}" onclick="select_pet(${list.PET_IDX},'${list.PET_NAME}')">
			<input id="${list.PET_IDX}_radio" type="radio" name="selected_pet" value="${list.PET_IDX}" style="display:none;" ${i.first? "checked":""}>
			<input id="${list.PET_IDX}_hidden" type="hidden" name="selected_pet_hidden" value="${list.PET_NAME}">
			<img src="${pageContext.request.contextPath}/pet/${list.PET_IDX}/profile.png" style="width: 100%; height: 100%;">
		</div>
		<div style="width: 100%; font-size: 12px; text-align: center;">${list.PET_NAME}</div>
	</div>
</c:forEach>
</div>
<div class="row" id="main_button_form" style="margin: 0px;">
	<div class="col-xs-4" id="pet_info_form">
			<div id="pet_name" style="font-size: 25px; font-weight: bold; margin-bottom: 1vh;"></div>
			<div id="recom_walk" style="font-size: 12px; margin-left: 1vw;">권장 산책량 30분</div>
	</div>
	<div class="col-xs-8">
		<div class="col-xs-6" id="bt_eat_form" style="display: inline-block;;">
			<div id="bt_eat" style="width: 25vw; height: 25vw; background-color: white; margin: 0px auto; text-align: center; border-radius: 100%; line-height: 25vw;" onclick="move_eat();">식사</div>
		</div>
		<div class="col-xs-6" id="bt_walk_form" style="display: inline-block;">
			<div id="bt_walk" style="width: 25vw; height: 25vw; background-color: #94b8ff; color: white; margin: 0px auto; text-align: center; border-radius: 100%; line-height: 25vw;" onclick="select_walk();">산책</div>
		</div>
	</div>
	<!-- <div id="" style="margin-top: 4vh;">
		<div id="bt_eat_form" style="display: inline-block; width: 49vw;">
			<div id="bt_eat" style="width: 30vw; height: 30vw; background-color: white; margin: 0px auto; text-align: center; border-radius: 100%; line-height: 30vw;" onclick="move_eat();">식사</div>
		</div>
		<div id="bt_walk_form" style="display: inline-block; width: 49vw;">
			<div id="bt_walk" style="width: 30vw; height: 30vw; background-color: #00D7AD; color: white; margin: 0px auto; text-align: center; border-radius: 100%; line-height: 30vw;" onclick="move_walk();">산책</div>
		</div>
	</div> -->
	<div class="row" id="today_walk_form" style="width: 100vw; margin: 0px auto;">
		<div class="col-xs-12" style="margin-top: 20px;">
			<div class="col-xs-2"></div>
			<div class="col-xs-8" id="today_walk" style="margin: 0px auto; height: 20px; line-height: 20px; width: 60vw; vertical-align: middle; background-color: white; border-radius: 15px; font-size: 14px; text-align: center;">오늘은 몇분을 산책했어요.</div>
			<div class="col-xs-2"></div>
		</div>
	</div>
</div>
</div>
</body>
</html>