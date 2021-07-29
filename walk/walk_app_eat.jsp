<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="//stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="//stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body{
	margin: 0px;
	width:100%;
}

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
#calendar {
width: 80vw;
margin: 0px auto;
}
#select_date_form{
width: 80vw;
margin-left: 10vw;
margin-top: 10vh;
display: none;
background-color: white;
position: fixed;
z-index: 2;
}

.calendar__day {
  display: inline-block;
  width: calc(78vw / 7);
  height: calc(78vw / 7);
  box-sizing: border-box;
  border-radius: 100%;
}
.calendar__day > span{
width: 100%;
display: inline-block;
text-align: center;
line-height: calc(78vw / 7);
font-weight: bold;
font-size: 12px;
}

.horizontalGutter {
  margin-right: calc(2vw / 7);
}

.verticalGutter {
  margin-top: calc(2% / 7);
}
.calendar_week{
color: #757575;
}

#remote_date{
height: 40px;
}
.calendar_check_date{
border-radius: 100%;
background-color: #94b8ff;
color: white;
}
#select_preview_date{
	height: 80px;
	margin-left: 5vw;
}
#select_preview_date > span{
font-weight: bold;
font-size: 30px;
color: white;
line-height: 80px;
text-align: center;
display: inline-block;
height: 80px;
}
</style>
<script src="//code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
const today = new Date();
var date_year = today.getFullYear();
var date_month = setFixDayCount(today.getMonth()+1);

var checked_year = today.getFullYear();
var checked_month = setFixDayCount(today.getMonth()+1);
var checked_date= setFixDayCount(today.getDate());

var pet_idx = '${pet_idx}';
var pet_name = '${pet_name}';
var user_idx = ${sessionScope.s_user.user_idx};

function checkBatchimEnding(word) {
	  if (typeof word !== 'string') return word;
	 
	  var lastLetter = word[word.length - 1];
	  var uni = lastLetter.charCodeAt(0);
	 
	  if (uni < 44032 || uni > 55203) return word;
	 
	  if((uni - 44032) % 28 != 0){
		  word = word+'이의';
	  }else {
		  word = word+'의';
	  }
	  return word;
}


window.onload = function(){
	document.getElementById('date_output_form').innerHTML = date_year+'년 '+date_month+'월';
	
	document.getElementById('eat_date_year').innerHTML = date_year;
	document.getElementById('eat_date_month').innerHTML = date_month;
	document.getElementById('eat_date_date').innerHTML = setFixDayCount(today.getDate());
	
	pet_name = checkBatchimEnding(pet_name);
	console.log(pet_name);
	
	document.getElementById('eat_title').innerHTML = pet_name+'<br>오늘 식사는 어땠나요?';
	
	setTimeForm(null, today.getHours(), today.getMinutes());
}

function setCheckDate(){
	var temp = checked_year+''+checked_month+''+checked_date;
	console.log('현재 temp:'+temp);
	if(document.getElementById(temp)){
		$('#'+temp).addClass('calendar_check_date');
	}
}

function setNewCheckDate(date){
	var temp = checked_year+''+checked_month+''+checked_date;
	if(document.getElementById(temp)){
		$('#'+temp).removeClass('calendar_check_date');
	}
	$('#'+date).addClass('calendar_check_date');
}

function setTimeForm(ampm, hour, min){
	
	if(ampm == null){
		if(hour<12){
			ampm='오전';
		}else{
			ampm='오후';
			if(hour>=13) hour=hour-12;
		}
	}
	document.getElementById('eat_time_ampm').innerHTML = ampm;
	document.getElementById('eat_time_hour').innerHTML = setFixDayCount(hour);
	document.getElementById('eat_time_min').innerHTML = setFixDayCount(min);
}

function setCalendarData(year, month) { //달력 설정 메서드
	console.log(month);
	let calHtml = '';
	const setDate = new Date(year, month-1, 1);
	const firstDayName = setDate.getDay();
	console.log(setDate.getMonth());
	console.log(firstDayName);
	const lastDay = new Date(
	  year,
	  month,
	  0
	).getDate();
	const prevLastDay = new Date(
	  year,
	  month-1,
	  0
	).getDate();
	console.log(lastDay);
	let startDayCount = 1;
	let lastDayCount = 1;
	
	for (let i = 0; i < 6; i++) {
	  for (let j = 0; j < 7; j++) {
	    if (i == 0 && j < firstDayName) {
	    	calHtml +=
		          '<div class=\'calendar__day horizontalGutter\'><span>　</span></div>';
		    continue;
	    }
	    else if (i == 0 && j == firstDayName) {
	      if (j == 0) {
	        calHtml +=
	          '<div class=\'calendar__day horizontalGutter\' id="'+year+''+month+''+setFixDayCount(startDayCount)+'" onclick="getDate('+year+''+month+''+setFixDayCount(startDayCount)+');"><span>'+startDayCount+'</span></div>';
	      } else if (j == 6) {
	        calHtml +=
	          '<div class=\'calendar__day\' id="'+year+''+month+''+setFixDayCount(startDayCount)+'" onclick="getDate('+year+''+month+''+setFixDayCount(startDayCount)+');"><span>'+startDayCount+'</span></div>';
	      } else {
	        calHtml +=
	          '<div class=\'calendar__day horizontalGutter\' id="'+year+''+month+''+setFixDayCount(startDayCount)+'" onclick="getDate('+year+''+month+''+setFixDayCount(startDayCount)+');"><span>'+startDayCount+'</span></div>';
	      }
	    }
	    else if (i == 0 && j > firstDayName) {
	      if (j == 0) {
	        calHtml +=
	          '<div class=\'calendar__day horizontalGutter\' id="'+year+''+month+''+setFixDayCount(startDayCount)+'" onclick="getDate('+year+''+month+''+setFixDayCount(startDayCount)+');"><span>'+startDayCount+'</span></div>';
	      } else if (j == 6) {
	        calHtml +=
	          '<div class=\'calendar__day\' id="'+year+''+month+''+setFixDayCount(startDayCount)+'" onclick="getDate('+year+''+month+''+setFixDayCount(startDayCount)+');"><span>'+startDayCount+'</span></div>';
	      } else {
	        calHtml +=
	          '<div class=\'calendar__day horizontalGutter\' id="'+year+''+month+''+setFixDayCount(startDayCount)+'" onclick="getDate('+year+''+month+''+setFixDayCount(startDayCount)+');"><span>'+startDayCount+'</span></div>';
	      }
	    }
	    else if (i > 0 && startDayCount <= lastDay) {
	      if (j == 0) {
	        calHtml +=
	          '<div class=\'calendar__day horizontalGutter verticalGutter\' id="'+year+''+month+''+setFixDayCount(startDayCount)+'" onclick="getDate('+year+''+month+''+setFixDayCount(startDayCount)+');"><span>'+startDayCount+'</span></div>';
	      } else if (j == 6) {
	        calHtml +=
	          '<div class=\'calendar__day verticalGutter\' id="'+year+''+month+''+setFixDayCount(startDayCount)+'" onclick="getDate('+year+''+month+''+setFixDayCount(startDayCount)+');"><span>'+startDayCount+'</span></div>';
	      } else {
	        calHtml +=
	          '<div class=\'calendar__day horizontalGutter verticalGutter\' id="'+year+''+month+''+setFixDayCount(startDayCount)+'" onclick="getDate('+year+''+month+''+setFixDayCount(startDayCount)+');"><span>'+startDayCount+'</span></span></div>';
	      }
	    }
	    else if (startDayCount > lastDay) {
	    	
	  	  break;
	    }
	    startDayCount++;
	  }
	}
	document.querySelector("#calendar").innerHTML = calHtml;
	setCheckDate();
};

function setFixDayCount(number) { //10 아래 월 일때 앞에 0 붙여주는 함수
  let fixNum = ""+number;
  console.log(fixNum+'/len'+fixNum.length);
  if(fixNum.length<2){
	  if (number < 10) {
		fixNum = "0" + fixNum;
	  }
  }
  return fixNum;
};

function select_date(){
	var now_year = document.getElementById('eat_date_year').innerHTML;
	var now_month = document.getElementById('eat_date_month').innerHTML;
	var now_date = document.getElementById('eat_date_date').innerHTML;
	checked_year = now_year;
	checked_month = setFixDayCount(now_month);
	checked_date= setFixDayCount(now_date);
	
	setPreview();
	
	date_year = now_year;
	date_month = now_month;
	document.getElementById('date_output_form').innerHTML = date_year+'년 '+date_month+'월';
	
	setCalendarData(now_year, setFixDayCount(now_month));
	document.getElementById('select_date_form').style.display = 'block';
	document.getElementById('bg_black').style.display = 'block';
}

function setPreview(){
	document.getElementById('preview_year').innerText = checked_year;
	document.getElementById('preview_month').innerText = checked_month;
	document.getElementById('preview_date').innerText = checked_date;
}
function date_move(type){ //달력에서 좌 우 화살표 클릭 시 월 이동
	if(type=='prev'){
		date_month--;
		if(date_month==0){
			date_month = 12;
			date_year--;
		}
	} else {
		date_month++;
		if(date_month==13){
			date_month = 1;
			date_year++;
		}
	}
	console.log(date_month);
	setCalendarData(date_year, setFixDayCount(date_month));
	document.getElementById('date_output_form').innerHTML = date_year+'년 '+date_month+'월';
}

function date_input_form(){ //달력 내 날짜 클릭 시 직접 입력 폼 출력
	document.getElementById('input_date_year').value = date_year;
	document.getElementById('input_date_month').value = setFixDayCount(date_month);
	document.getElementById('date_input_form').style.display = 'block';
}
function input_date_apply(){ //직접 입력 한 날짜 값 적용
	var date_year = document.getElementById('input_date_year').value;
	var date_month = document.getElementById('input_date_month').value;
	document.getElementById('date_output_form').innerHTML = date_year+'년 '+date_month+'월';
	setCalendarData(date_year, setFixDayCount(date_month));
}

function getDate(date){
	date = date+'';
	setNewCheckDate(date);
	checked_year = date.substring(0,4);
	checked_month = date.substring(4,6);
	checked_date = date.substring(6);
	
	setPreview();
}
function select_date_ok(){
	document.getElementById('eat_date_year').innerHTML = checked_year;
	document.getElementById('eat_date_month').innerHTML = checked_month;
	document.getElementById('eat_date_date').innerHTML = checked_date;
	
	document.getElementById('select_date_form').style.display = 'none';
	document.getElementById('bg_black').style.display = 'none';
}

var checked_ampm;
var checked_hour;
var checked_min;

function select_time(){
	document.getElementById('eat_time_ampm').innerHTML;
	checked_ampm = document.getElementById('eat_time_ampm').innerHTML;
	checked_hour = document.getElementById('eat_time_hour').innerHTML;
	checked_min = document.getElementById('eat_time_min').innerHTML;
	var arr_ampm = document.getElementsByName('radio_ampm');
	for(var i=0; i<arr_ampm.length; i++){
		if(arr_ampm[i].value == checked_ampm){
			arr_ampm[i].checked = true;
		}
	}
	document.getElementById('hour').placeholder = checked_hour;
	document.getElementById('min').placeholder = checked_min;
	
	document.getElementById('select_time_form').style.display = 'block';
	document.getElementById('bg_black').style.display = 'block';
}
function changeAmpm(data){
	checked_ampm = data;
}
function changeTime(type){
	var c_hour = document.getElementById('hour').value;
	var c_min = document.getElementById('min').value;
	
	if(type=='hour'){
		if(c_hour.length>3 || c_hour >12 || c_hour < 0){
			document.getElementById('hour').value = '';
			Android.showToast("올바른 시간을 입력해주세요.");
		} else{
			checked_hour = setFixDayCount(c_hour);
		}
	}else{
		if(c_min.length>3 || c_min >60 || c_min < 0){
			document.getElementById('hour').value = '';
			Android.showToast("올바른 시간을 입력해주세요.");
		} else{
			checked_min = setFixDayCount(c_min);
		}
	}
	console.log('change');
}
function saveData(){
	var eat_date = checked_year+''+checked_month+''+checked_date;
	checked_hour = Number(document.getElementById('eat_time_hour').innerHTML);
	checked_min = document.getElementById('eat_time_min').innerHTML;
	if(document.getElementById('eat_time_ampm').innerHTML == '오전'){
		if(checked_hour==12) checked_hour = 0;
	} else {
		if(checked_hour < 12) checked_hour += 12;
	}
	eat_date += ' '+checked_hour+':'+checked_min;
	console.log(eat_date);
	var eat_kind = document.getElementsByName('eat_kind');
	for(var i=0; i<eat_kind.length; i++){
		if(eat_kind[i].checked == true){
			eat_kind = eat_kind[i].value;
			break;
		}
	}
	var eat_name = document.getElementById('eat_name').value;
	var eat_amount = document.getElementById('eat_amount').value;
	
	var formData = new FormData();
	formData.append('eat_pet_idx',pet_idx);
	formData.append('eat_user_idx',user_idx);
	formData.append('eat_time',eat_date);
	formData.append('eat_kind',eat_kind);
	formData.append('eat_name',eat_name);
	formData.append('eat_amount',eat_amount);
	
	$.ajax({
		url: 'walk_app_eat_com.do',
   		method: 'POST',
        data: {
        	'eat_pet_idx' : pet_idx,
        	'eat_user_idx' : user_idx,
        	'eat_date' : eat_date,
        	'eat_kind' : eat_kind,
        	'eat_name' : eat_name,
        	'eat_amount' : eat_amount
        	
        },
        contentType : "application/x-www-form-urlencoded; charset=utf-8",
        dataType : "json",
        success: function () {
        	Android.save_eat();
        },
        error: function () {
        	Android.showToast("문제가 발생하였습니다");
        },
	});
	
}
function select_time_ok(){
	
	if(checked_hour)
	
	document.getElementById('eat_time_ampm').innerHTML = checked_ampm;
	document.getElementById('eat_time_hour').innerHTML = checked_hour;
	document.getElementById('eat_time_min').innerHTML = checked_min;
	
	document.getElementById('hour').value = '';
	document.getElementById('min').value = '';
	
	document.getElementById('select_time_form').style.display = 'none';
	document.getElementById('bg_black').style.display = 'none';
}
</script>
<style>
#eat_form{
overflow-y: scroll;
-ms-overflow-style: none;
}
#eat_form::-webkit-scrollbar{ 
display:none;
}
#eat_feed{
border-color: #E0E0E0;
}
#kind_feed:checked + #eat_feed{
border-color: #94b8ff;
}
#eat_snack{
border-color: #E0E0E0;
}
#kind_snack:checked + #eat_snack{
border-color: #94b8ff;
}


#select_time_form{
width: 80vw;
margin-left: 10vw;
margin-top: 35vh;
height: 150px;
display: none;
background-color: white;
position: fixed;
z-index: 2;
}

#select_am + label{
font-size: 20px;
color: #E0E0E0;
line-height: 30px;
margin: 0px auto;
width: 100%;
height: 100%;
text-align: center;
}
#select_am:checked + label{
color: white;
background-color: #94b8ff;
}

#select_pm + label{
font-size: 20px;
color: #E0E0E0;
line-height: 30px;
margin: 0px auto;
width: 100%;
height: 100%;
text-align: center;
}
#select_pm:checked + label{
color: white;
background-color: #94b8ff;
}
</style>
</head>
<body>
<div id="bg_black"></div>
<div id="select_date_form"">
	<div id="select_preview" style="width:100%; height:80px; background-color:  #94b8ff;">
		<div id="select_preview_date">
			<span id="preview_year"></span>
			<span>년</span>
			<span id="preview_month"></span>
			<span>월</span>
			<span id="preview_date"></span>
			<span>일</span>
		</div>
	</div>
	<div id="remote_date" style="margin: 0px auto; line-height: 40px;">
		<div id="move_prev" style="position: absolute; margin-left: 5vw;" onclick="date_move('prev');">
			<i style="width: 15px; height: 15px; background-image: url('${pageContext.request.contextPath}/images/left.png'); background-size: cover; display: inline-block;"></i>
		</div>
		<div id="move_next" style="position: absolute; margin-left: 75vw;" onclick="date_move('next');">
			<i style="width: 15px; height: 15px; background-image: url('${pageContext.request.contextPath}/images/right.png'); background-size: cover; display: inline-block;"></i>
		</div>
		<div id="date_output_form" style="text-align: center; font-size: 20px;"></div>
	</div>
	<div id="calendar_form">
		<div class="calendar__day horizontalGutter calendar_week"><span>일</span></div><div class="calendar__day horizontalGutter calendar_week"><span>월</span></div><div class="calendar__day horizontalGutter calendar_week"><span>화</span></div><div class="calendar__day horizontalGutter calendar_week"><span>수</span></div><div class="calendar__day horizontalGutter calendar_week"><span>목</span></div><div class="calendar__day horizontalGutter calendar_week"><span>금</span></div><div class="calendar__day calendar_week"><span>토</span></div>
		<div id="calendar"></div>
		<div style="width: 100%; text-align: right;">
			<input type="button" class="btn btn-outline-primary" style="width: 70px; height: 44px; margin: 10px;" value="확인" onclick="select_date_ok()">
			<input type="button" class="btn btn-outline-primary" style="width: 70px; height: 44px; margin: 10px;" value="취소" onclick="document.getElementById('select_date_form').style.display = 'none'; document.getElementById('bg_black').style.display = 'none';">
		</div>
		</div>
</div>

<div id="select_time_form" style="padding: 10px;">
	<div style="width: 100%; height: 60%;  margin-bottom: 10px;">
		<div id="select_ampm_form" style="float:left; width: 20%; height: 100%;">
			<div id="am_div" style=" width: 100%; height: 50%;">
				<input type="radio" style="display: none;" id="select_am" name="radio_ampm" value="오전" onclick="changeAmpm('오전');">
				<label for="select_am">오전</label>
			</div>
			<div id="pm_div" style=" width: 100%; height: 50%;">
				<input type="radio" style="display: none;" id="select_pm" name="radio_ampm" value="오후" onclick="changeAmpm('오후');">
				<label for="select_pm">오후</label>
			</div>
		</div>
		<div id="select_hour_form" style="float:left; height: 100%; width: 38%; margin-left: 2%;">
			<span id="select_hour"><input style="text-align: center; height: 80%; width: 80%; font-size: 35px;" type="number" id="hour" min="1" max="12"  onchange="changeTime('hour');"></span>
			<span>시</span>
		</div>
		<div id="select_min_form" style="float: left; width: 38%; height: 100%; margin-left: 2%;">
			<span id="select_min"><input style="text-align: center; height: 80%; width: 80%; font-size: 35px;" type="number" id="min" min="1" max="59" onchange="changeTime('min');"></span>
			<span>분</span>
		</div>
	</div>
	<div style="text-align: center;">
		<input type="button" class="btn btn-outline-primary" value="확인" style="" onclick="select_time_ok();">
		<input type="button" class="btn btn-outline-primary" value="취소" style="" onclick="document.getElementById('select_time_form').style.display = 'none'; document.getElementById('bg_black').style.display = 'none';">
	</div>
</div>
<div style="width: 100vw; padding-bottom: 60px;">
<div id="eat_form" style="width: 100%; height: 100%;">
	<div id="eat_title" style="width: 80%; margin: 0px auto; font-size: 25px; font-weight: bold; margin-top: 40px; margin-bottom: 40px;"></div>
	
	<div id="eat_time_form" style="width: 80%; margin: 0px auto;">
		<div style="margin-bottom: 15px;">식사 시간</div>
		<div id="eat_date_form" style="border-radius: 15px; font-size: 18px; margin-bottom: 20px; width: 100%; height: 60px; line-height: 56px; border-style: solid; border-width: 2px; border-color: #E0E0E0;" onclick="select_date();">
			<div style="display: inline-block; vertical-align: middle; width: 30%; text-align: center;">
				<span id="eat_date_year"></span>
				<span>년</span>
			</div>
			<div style="display: inline-block; vertical-align: middle; width: 30%; text-align: center;">
				<span id="eat_date_month"></span>
				<span>월</span>
			</div>
			<div style="display: inline-block; vertical-align: middle; width: 30%; text-align: center;">
				<span id="eat_date_date"></span>
				<span>일</span>
			</div>
		</div>
		<div id="eat_time_form" style="border-radius: 15px; font-size: 18px; margin-bottom: 50px; width: 100%; height: 60px; line-height: 56px; border-style: solid; border-width: 2px; border-color: #E0E0E0;" onclick="select_time();">
			<div id="eat_time_ampm" style="display: inline-block; vertical-align: middle; width: 30%; text-align: center;"></div>
			<div style="display: inline-block; vertical-align: middle; width: 30%; text-align: center;">
				<span id="eat_time_hour"></span>
				<span>시</span>
			</div>
			<div style="display: inline-block; vertical-align: middle; width: 30%; text-align: center;">
				<span id="eat_time_min"></span>
				<span>분</span>
			</div>
			
		</div>
	</div>
	
	<div id="eat_kind_form" style="width: 80%; margin: 0px auto; margin-bottom: 50px;">
		<div style="margin-bottom: 15px;">식사 종류</div>
		<input id="kind_feed" type="radio" name="eat_kind" value="사료" style="display: none;" checked>
		<div id="eat_feed" style="width: 44%; height: 70px; margin: 2%; display: inline-block; border-radius: 15px; border-style: solid; border-width: 2px;" onclick="$('#kind_feed').prop('checked', true);">
			<div style=" width: 100%; height: 100%;">
				<div style="width: 40px; height: 40px; margin: 0px auto; background-image: url('${pageContext.request.contextPath}/images/feed_icon.png'); background-size: cover;"></div>
				<div style="width: 100%; height: 20px; margin: 0px auto; text-align: center; font-size: 15px;">사료</div>
			</div>
		</div>
		<input id="kind_snack" type="radio" name="eat_kind" value="간식" style="display: none;">
		<div id="eat_snack" style="width: 44%; height: 70px; margin: 3%; display: inline-block; border-radius: 15px; border-style: solid; border-width: 2px;" onclick="$('#kind_snack').prop('checked', true);">
			<div style=" width: 100%; height: 100%;">
				<div style="width: 40px; height: 40px; margin: 0px auto; background-image: url('${pageContext.request.contextPath}/images/snack_icon.png'); background-size: cover;"></div>
				<div style="width: 100%; height: 20px; margin: 0px auto; text-align: center; font-size: 15px;">간식</div>
			</div>
		</div>
	</div>
	
	<div id="eat_name_form" style="width: 80%; margin: 0px auto; margin-bottom: 50px;">
		<div style="margin-bottom: 15px;">사료 명</div>
		<div style="border-bottom: solid; border-width: 2px; border-color: #94b8ff; height: 40px; ">
			<input type="text" id="eat_name" placeholder="사료명을 입력해 주세요." style="font-size: 20px; border-style: none;">
		</div>
	</div>
	<div id="eat_amount_form" style="width: 80%; margin: 0px auto; margin-bottom: 80px;">
		<div style="margin-bottom: 15px;">사료 양</div>
		<div style="border-bottom: solid; border-width: 2px; border-color: #94b8ff; height: 40px; ">
			<input type="text" id="eat_amount" placeholder="급여량을 입력해 주세요." style="font-size: 20px; border-style: none;">
		</div>
	</div>
</div>
</div>
<div id="saveBt" style="width:100vw; height: 60px; position: fixed; background-color: #94b8ff; bottom: 0px; text-align: center;" onclick="saveData();">
<span style="display: inline-block; line-height: 60px; font-size: 25px; color: white; font-weight: bold;">저장</span>
</div>
</body>
</html>