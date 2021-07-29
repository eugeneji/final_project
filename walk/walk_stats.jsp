<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="//code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8a1016e61f601fdf40972b41563332bf"></script>
<script src="js/GaugeMeter.js"></script>
<link rel="stylesheet" href="//stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="//stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>

var cp=1;
var total_stats_data;

//오늘 날짜 정보 전역 변수
var today = new Date();
var today_year = today.getFullYear();
var today_month = setFixDayCount(today.getMonth()+1);
var today_date = setFixDayCount(today.getDate());
var today_day = today.getDay();

var stats_type; //산책통계, 식사통계
var stats_name;

var cal_type;

var pet_icon_path = '${pageContext.request.contextPath}/pet/walk_pet_icon.png';
var poop_icon_path = '${pageContext.request.contextPath}/images/poop_icon.png';
var cam_icon_path = '${pageContext.request.contextPath}/images/cam_icon.png';

//달력 상태 유지 위한 전역 변수
var monthCal_year;
var monthCal_month;

var selected_pet_idx;

var selected_date;
var scroll_status;

window.onload=function(){
	firstSetup('walk');
	/* window.onscroll = function(ev) {
	    if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight && scroll_status) {
	        cp++;
	        var date;
	        if(cal_type=='month'){
	        	date = monthCal_year+''+setFixDayCount(monthCal_month);
	        }else if(cal_type=='date'){
	        	date = selected_date;
	        }
	        get_total_stats(cal_type,date);
	    }
	}; */
}

function firstSetup(type){
	monthCal_year = today_year;
	monthCal_month = today_month;
	selected_pet_idx = $('input[name="pet_list"]:checked').val();
	console.log(selected_pet_idx);
	stats_type = type;
	cal_type = 'week';
	
	if(document.getElementById('week_calendar').style.display=='none'){
		extend_cal();
	}
	
	cp=1;
	if(type=='walk'){
		stats_name = '산책';
		setWeekCalendarData();
		setCalendarData(monthCal_year,monthCal_month);
		getWalkMonthHistory();
		document.getElementById('stats_name').innerHTML = '이번주 산책 통계';
		get_total_stats('week','');
		document.getElementById('total_stats_form').style.display = 'block';
		document.getElementById('eat_chart_form').style.display = 'none';
	}else if(type=='eat'){
		console.log('eat');
		document.getElementById('total_stats_form').style.display = 'none';
		document.getElementById('eat_chart_form').style.display = 'block';
		stats_name = '식사';
		setWeekCalendarData();
		getEatWeekChart();
		setCalendarData(monthCal_year,monthCal_month);
		getEatTotalStats(); //월별 식사 통계
		document.getElementById('stats_name').innerHTML = '이번주 식사 통계';
		get_total_stats('week',''); //선택 기간 별 상세 식사 내용
	}
	
}

function select_pet(idx){
	document.getElementById(idx+'_pet').checked = true;
	firstSetup(stats_type);
}

function getDate(date){
	date = date+'';
	selected_date = date;
	var checked_year = date.substring(0,4);
	var checked_month = date.substring(4,6);
	var checked_date = date.substring(6);
	console.log('getDate');
	var stats_name;
	if(document.getElementById(date+'_radio').checked){
		console.log('getDate1');
		var stats_string = stats_type=='walk'? '산책':'식사';
		cal_type = 'month';
		document.getElementById(date+'_radio').checked = false;
		get_total_stats('month', (monthCal_year+''+monthCal_month));
		stats_name = checked_month+'월 '+stats_string+' 통계';
	}else{
		console.log('getDate2');
		cal_type = 'date';
		var stats_string = stats_type=='walk'? '산책':'식사';
		document.getElementById(date+'_radio').checked = true;
		get_total_stats('date', date);
		stats_name = checked_month+'월'+checked_date+'일 '+stats_string+' 통계';
	}
	cp = 1;
	document.getElementById('stats_name').innerHTML = stats_name;
}


function getWalkMonthHistory(){
	var date = monthCal_year+''+monthCal_month;
	$.ajax({
		url: 'walk_get_month_history.do',
   		method: 'POST',
        data: {'date': date, 'pet_idx':selected_pet_idx},
        contentType : "application/x-www-form-urlencoded; charset=utf-8",
        dataType : "json",
        success: function (data) {
        	if(data.list!=null){
        		for(var i=0; i<data.list.length; i++){
        			var temp = data.list[i].WALK_STARTTIME;
        			
        			if(document.getElementById('week_calendar').style.display != 'none' && monthCal_year==today_year && monthCal_month == today_month){
        				if(document.getElementById(temp+'_week')){
        					$('#'+temp+'_week').addClass('history_date');
        				}
        			}
        			console.log(temp+'getWalkMOnthHistory');
        			$('#'+temp).addClass('history_date');
        			/* $('#'+temp).on('click',function(){
        				getDate($(this).attr('id'));
        			}); */
        			document.getElementById(temp).onclick = (function(){
        				var current =temp;
        				return function(){
        					getDate(current);
        				};
        			})();
        		}
        	}
        	
        },
        error: function () {
        console.log('error');
        },
	});
}

function date_move(type){ //달력에서 좌 우 화살표 클릭 시 월 이동
	cal_type = 'month';
	if(type=='prev'){
		monthCal_month--;
		if(monthCal_month==0){
			monthCal_month = 12;
			monthCal_year--;
		}
	} else {
		monthCal_month++;
		if(monthCal_month==13){
			monthCal_month = 1;
			monthCal_year++;
		}
	}
	monthCal_month = setFixDayCount(monthCal_month);
	
	setCalendarData(monthCal_year, monthCal_month);
	
	if(stats_type=='walk'){
		get_total_stats('month',(monthCal_year+''+setFixDayCount(monthCal_month)));
		getWalkMonthHistory();
		document.getElementById('stats_name').innerHTML = monthCal_month+'월 산책 통계';
	}else{
		get_total_stats('month',(monthCal_year+''+setFixDayCount(monthCal_month)));
		getEatTotalStats();
		document.getElementById('stats_name').innerHTML = monthCal_month+'월 식사 통계';
	}
	cp=1;
	
	
}

function getEatTotalStats(){ // 월 별 
	var date = monthCal_year+''+monthCal_month;
	$.ajax({
		url: 'walk_get_eat_cal_stat.do',
   		method: 'POST',
        data: {'date': date, 'pet_idx':selected_pet_idx},
        contentType : "application/x-www-form-urlencoded; charset=utf-8",
        dataType : "json",
        success: function (data) {
        	var list = data.list;
        	if(data.list!=null){
        		for(var i=0; i<data.list.length; i++){
        			var temp = data.list[i].EAT_TIME;
        			
        			console.log(data.list[i].EAT_KIND);
        			$('#'+temp).addClass('history_date');
        			
        			if(data.list[i].EAT_KIND=='사료'){
        				document.getElementById(temp+'_feed').innerHTML = data.list[i].COUNT;
        			}else{
        				document.getElementById(temp+'_snack').innerHTML = data.list[i].COUNT;
        			}
        			
        			/* $('#'+temp).on('click',function(){
        				getDate($(this).attr('id'));
        			}); */
        			document.getElementById(temp).onclick = (function(){
        				var current =temp;
        				return function(){
        					getDate(current);
        				};
        			})();
        		}
        	}
        	
        },
        error: function () {
        console.log('error');
        },
	});
}

function getEatWeekChart(){
	
	var week_year = today.getFullYear();
	var week_month = setFixDayCount((today.getMonth()+1));
	var week_date = today.getDate();
	var week_day = today.getDay();
	var week_start = setFixDayCount((week_date-week_day));
	
	if((week_date-week_day)<=0){
		var temp = new Date(week_year, week_month-1, 0);
		week_year = temp.getFullYear();
		week_month = setFixDayCount((temp.getMonth()+1));
		week_start = (temp.getDate()+week_date-week_day)
	}
	
	var date = week_year+''+week_month+''+week_start;
	console.log(date);
	
	$.ajax({
		url: 'walk_get_eat_week_chart.do',
   		method: 'POST',
        data: {'date': date, 'pet_idx':selected_pet_idx},
        contentType : "application/x-www-form-urlencoded; charset=utf-8",
        dataType : "json",
        success: function (data) {
        	chartItems = new Array();
        	var item = ['','사료','간식'];
        	chartItems.push(item);
        	if(data.list!=null){
        		for(var i=0; i<data.list.length; i++){
        			var dates = data.list[i].DATES.substring(4);
        			var feed = Number(data.list[i].FEED);
        			var snack = Number(data.list[i].SNACK);
        			item = [dates,feed,snack];
        			chartItems.push(item);
        		}
        	}
        	document.getElementById('week_chart').innerHTML = '';
        	
        	
        	google.charts.load('current', {'packages':['bar']});
            google.charts.setOnLoadCallback(drawChart);
			
        	
        },
        error: function () {
        console.log('error');
        },
	});
}
var chartItems;

function drawChart() {
    var data = google.visualization.arrayToDataTable(chartItems);
    var options = {
    	width: 750,
    	height: 250
    };
	
    
    
    var chart = new google.charts.Bar(document.getElementById('week_chart'));

    chart.draw(data, google.charts.Bar.convertOptions(options));
}


function get_total_stats(type, date){
	var data;	
	cal_type = type;
	if(type=='week'){
		var week_year = today.getFullYear();
		var week_month = setFixDayCount((today.getMonth()+1));
		var week_date = today.getDate();
		var week_day = today.getDay();
		var week_start = setFixDayCount((week_date-week_day));
		
		if((week_date-week_day)<=0){
			var temp = new Date(week_year, week_month-1, 0);
			week_year = temp.getFullYear();
			week_month = setFixDayCount((temp.getMonth()+1));
			week_start = (temp.getDate()+week_date-week_day)
		}
		
		date = week_year+''+setFixDayCount(week_month)+''+week_start;
	}
	if(stats_type=='walk'){
		$.ajax({
			url: 'walk_get_total_stats.do',
	   		method: 'POST',
	        data: {
	        	'type': type, 
	        	'date': date, 
	        	'pet_idx':selected_pet_idx,
	        	'cp': cp	
	        },
	        	
	        contentType : "application/x-www-form-urlencoded; charset=utf-8",
	        dataType : "json",
	        success: function (data) {
	        	
	        	var total_walk_distance = data.dto.walk_distance;
	        	if(total_walk_distance>=1000){
	        		total_walk_distance = (parseInt(total_walk_distance/1000)+((Math.round((total_walk_distance%1000)/100))/10))+'km';
            	}else{
            		total_walk_distance = total_walk_distance+'m';
            	}
	        	document.getElementById('total_dis_data').innerHTML = total_walk_distance;
	        	document.getElementById('total_time_data').innerHTML = setFixDayCount(parseInt(data.dto.walk_time/60))+':'+setFixDayCount(data.dto.walk_time%60);
	        	
	        	
	        	var stats_form = document.getElementById('stats_form');
	        	if(cp==1) stats_form.innerHTML = '';
	        	
	        	if(data.stats_list.length!=0){
		        	for(var i=0; i<data.stats_list.length; i++){
		        		var walk_starttime = new Date(data.stats_list[i].walk_startTime);
		        		walk_starttime = walk_starttime.getFullYear()+'년'+setFixDayCount(walk_starttime.getMonth()+1)+'월'+setFixDayCount(walk_starttime.getDate())+'일'+setFixDayCount(walk_starttime.getHours())+':'+setFixDayCount(walk_starttime.getMinutes());
		            	var walk_idx = data.stats_list[i].walk_idx;
		            	var walk_time = data.stats_list[i].walk_time;
		            	var walk_distance = data.stats_list[i].walk_distance;
		            	var walk_user_name = data.stats_list[i].walk_user_name;
		            	
		            	if(walk_distance>=1000){
		            		walk_distance = (parseInt(walk_distance/1000)+((Math.round((walk_distance%1000)/100))/10))+'km';
		            	}else{
		            		walk_distance = walk_distance+'m';
		            	}
		            	
		            	stats_form.innerHTML += 
		            		'<div class="col-xs-12 stats_list_item" onclick="getWalkDetail('+walk_idx+');">'+
			    				'<div class="col-xs-12" style="margin-bottom: 10px;"><span style="font-size: 13px; margin-right: 15px;">'+walk_starttime+'</span><span style="color: #94b8ff; font-size: 13px;">'+walk_user_name+'</span></div>'+
			    				'<div class="col-xs-6">'+
			    					'<div style="width: 100px; text-align: center; font-size: 12px; margin: 0px auto;">산책 시간</div>'+
			    					'<div style="width: 100px; text-align:center; font-size: 17px; margin: 0px auto;">'+setFixDayCount(parseInt(walk_time/60))+':'+setFixDayCount(walk_time%60)+'</div>'+
			    				'</div>'+
			    				'<div class="col-xs-6">'+
			    					'<div style="width: 100px; text-align: center; font-size: 12px; margin: 0px auto;">산책 거리</div>'+
			    					'<div style="width: 100px; text-align:center; font-size: 17px; margin: 0px auto;">'+walk_distance+'</div>'+
			    				'</div>'+
		    				'</div>';
		            	
		            	/* var div = document.createElement('div');
		            	div.classList.add('col-xs-12');
		            	div.classList.add('stats_list_item');
		            	div.onclick = (function(){
		            		var current_idx = walk_idx;
		            		return function(){
		            			getWalkDetail(current_idx);
		            		};
		            	})();
		            	
		            	div.innerHTML = walk_starttime+' '+walk_user_name+'<br>'+walk_distance+' '+walk_time; 
		            	
		            	stats_form.appendChild(div);*/
		        	}
	        	}else{
	        		
	        		if(cp==1){
	        			stats_form.innerHTML = '<div class="col-xs-12 stats_list_item" style="line-height: 80px;"><div style="width: 200px; margin: 0px auto; text-align: center; font-size: 14px;">산책 내역이 존재하지 않습니다.</div></div>';
	        		} else {
	        			stats_form.innerHTML += '<div class="col-xs-12" style="line-height: 80px;"><div style="width: 200px; margin: 0px auto; text-align: center; font-size: 14px; background-color: #E0E0E0; color: white; border-radius: 15px;">마지막 식사 내역 입니다.</div></div>';
	        		}
	        	}
	        },
	        error: function () {

	        
	        },
		});
		
	} else{
		console.log(type,date,selected_pet_idx,cp);
		$.ajax({
			url: 'walk_get_eat_total_stats.do',
	   		method: 'POST',
	        data: {
	        	'type': type, 
	        	'date': date, 
	        	'pet_idx':selected_pet_idx,
	        	'cp': cp	
	        },
	        	
	        contentType : "application/x-www-form-urlencoded; charset=utf-8",
	        dataType : "json",
	        success: function (data) {
	        	
	        	var stats_form = document.getElementById('stats_form');
	        	if(cp==1) stats_form.innerHTML = '';
	        	
	        	var list = data.list;
	        	
	        	if(list.length!=0){
		        	for(var i=0; i<list.length; i++){
		        		var eat_time = new Date(list[i].eat_time);
		        		eat_time = eat_time.getFullYear()+'년'+setFixDayCount(eat_time.getMonth()+1)+'월'+setFixDayCount(eat_time.getDate())+'일'+setFixDayCount(eat_time.getHours())+':'+setFixDayCount(eat_time.getMinutes());
		        		var eat_user_name = list[i].eat_user_name;
		        		var eat_kind = list[i].eat_kind;
		        		var eat_name = list[i].eat_name;
		        		var eat_name_title = '사료 명';
		        		if(eat_name==null || eat_name==''){
		        			eat_name_title = '';
		        			eat_name = '';
		        		}
		        		var eat_amount = list[i].eat_amount;
		        		var eat_amount_title = '사료 양'
		        		if(eat_name==null || eat_name==''){
		        			eat_amount_title = '';
		        			eat_amount = '';
		        		}
		        		
		        		stats_form.innerHTML += 
		            		'<div class="col-xs-12 stats_list_item">'+
			    				'<div class="col-xs-12" style="margin-bottom: 10px;"><span style="font-size: 13px; margin-right: 15px;">'+eat_time+'</span><span style="color: #94b8ff; font-size: 13px;">'+eat_user_name+'</span></div>'+
			    				'<div class="col-xs-4">'+
			    					'<div style="width: 100px; text-align: center; font-size: 12px; margin: 0px auto;">식사 종류</div>'+
			    					'<div style="width: 100px; text-align:center; font-size: 17px; margin: 0px auto;">'+eat_kind+'</div>'+
			    				'</div>'+
			    				'<div class="col-xs-4">'+
			    					'<div style="width: 100px; text-align: center; font-size: 12px; margin: 0px auto;">'+eat_name_title+'</div>'+
			    					'<div style="width: 100px; text-align:center; font-size: 17px; margin: 0px auto;">'+eat_name+'</div>'+
			    				'</div>'+
			    				'<div class="col-xs-4">'+
			    					'<div style="width: 100px; text-align: center; font-size: 12px; margin: 0px auto;">'+eat_amount_title+'</div>'+
			    					'<div style="width: 100px; text-align:center; font-size: 17px; margin: 0px auto;">'+eat_amount+'</div>'+
		    					'</div>'+
		    				'</div>';
		        	}
	        	}else{
	        		if(cp==1){
	        			stats_form.innerHTML = '<div class="col-xs-12 stats_list_item" style="line-height: 80px;"><div style="width: 200px; margin: 0px auto; text-align: center; font-size: 14px;">식사 내역이 존재하지 않습니다.</div></div>';
	        		} else {
	        			stats_form.innerHTML += '<div class="col-xs-12" style="line-height: 80px;"><div style="width: 200px; margin: 0px auto; text-align: center; font-size: 14px; background-color: #E0E0E0; color: white; border-radius: 15px;">마지막 식사 내역 입니다.</div></div>';
	        		}
	        	}
	        },
	        error: function () {

	        
	        },
		});
	}
	
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

function setWeekCalendarData(){
	var week_date = today.getDate();
	var week_day = today.getDay();
	var weekCal = document.getElementById('week_calendar');
	
	var last_day = new Date(today.getFullYear(),today.getMonth()+1,0).getDate();
	var week_form = '';
	
	var next_date = 1;
	for(var i=0; i<7; i++){
		if(week_date-week_day+i<=0){
			var prev_date = new Date(today.getFullYear(), today.getMonth(),0);
			var prev_lastdate = prev_date.getDate();
			week_form += '<div class=\'calendar__day horizontalGutter\'><span style="color: #E0E0E0;">'+(prev_lastdate-week_day+1)+'</span></div>';
		}else if((week_date-week_day+i)>last_day){
			week_form += '<div class=\'calendar__day horizontalGutter\'><span style="color: #E0E0E0;">'+next_date+'</span></div>';
			next_date++;
		}else{
			week_form += '<div class=\'calendar__day horizontalGutter\' id="'+today_year+''+today_month+''+setFixDayCount((week_date-week_day+i))+'_week"><span>'+(week_date-week_day+i)+'</span></div>';
		}
	}
	
	weekCal.innerHTML = week_form;
	$('#'+today_year+today_month+today_date+'_week').addClass('week_today');		
}

function setCalendarData(year, month) { //달력 설정 메서드
	month = setFixDayCount(month);
	
	let calHtml = '';
	const setDate = new Date(year, month-1, 1);
	const firstDayName = setDate.getDay();
	const lastDay = new Date(year,month,0).getDate();
	const prevLastDay = new Date(year,month-1,0).getDate();
	
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
	          '<div class=\'calendar__day horizontalGutter\' id="'+year+''+month+''+setFixDayCount(startDayCount)+'" ><div style="position: absolute; height: 40px; margin-left: 35px;"><div id="'+year+''+month+''+setFixDayCount(startDayCount)+'_feed" style="height:20px; color: #46CCFF; font-size:13px;"></div><div id="'+year+''+month+''+setFixDayCount(startDayCount)+'_snack" style="height:20px; color:#FF7493; font-size:13px;"></div></div><input id="'+year+''+month+''+setFixDayCount(startDayCount)+'_radio" class="month_radio" type="radio" name="monthCal_date" value="'+setFixDayCount(startDayCount)+'"><span>'+startDayCount+'</span></div>';
	      } else if (j == 6) {
	        calHtml +=
	          '<div class=\'calendar__day\' id="'+year+''+month+''+setFixDayCount(startDayCount)+'"><div style="position: absolute; height: 40px; margin-left: 35px;"><div id="'+year+''+month+''+setFixDayCount(startDayCount)+'_feed" style="height:20px; color: #46CCFF; font-size:13px;"></div><div id="'+year+''+month+''+setFixDayCount(startDayCount)+'_snack" style="height:20px; color:#FF7493; font-size:13px;"></div></div><input id="'+year+''+month+''+setFixDayCount(startDayCount)+'_radio" class="month_radio" type="radio" name="monthCal_date" value="'+setFixDayCount(startDayCount)+'"><span>'+startDayCount+'</span></div>';
	      } else {
	        calHtml +=
	          '<div class=\'calendar__day horizontalGutter\' id="'+year+''+month+''+setFixDayCount(startDayCount)+'"><div style="position: absolute; height: 40px; margin-left: 35px;"><div id="'+year+''+month+''+setFixDayCount(startDayCount)+'_feed" style="height:20px; color: #46CCFF; font-size:13px;"></div><div id="'+year+''+month+''+setFixDayCount(startDayCount)+'_snack" style="height:20px; color:#FF7493; font-size:13px;"></div></div><input id="'+year+''+month+''+setFixDayCount(startDayCount)+'_radio" class="month_radio" type="radio" name="monthCal_date" value="'+setFixDayCount(startDayCount)+'"><span>'+startDayCount+'</span></div>';
	      }
	    }
	    else if (i == 0 && j > firstDayName) {
	      if (j == 0) {
	        calHtml +=
	          '<div class=\'calendar__day horizontalGutter\' id="'+year+''+month+''+setFixDayCount(startDayCount)+'"><div style="position: absolute; height: 40px; margin-left: 35px;"><div id="'+year+''+month+''+setFixDayCount(startDayCount)+'_feed" style="height:20px; color: #46CCFF; font-size:13px;"></div><div id="'+year+''+month+''+setFixDayCount(startDayCount)+'_snack" style="height:20px; color:#FF7493; font-size:13px;"></div></div><input id="'+year+''+month+''+setFixDayCount(startDayCount)+'_radio" class="month_radio" type="radio" name="monthCal_date" value="'+setFixDayCount(startDayCount)+'"><span>'+startDayCount+'</span></div>';
	      } else if (j == 6) {
	        calHtml +=
	          '<div class=\'calendar__day\' id="'+year+''+month+''+setFixDayCount(startDayCount)+'" ><div style="position: absolute; height: 40px; margin-left: 35px;"><div id="'+year+''+month+''+setFixDayCount(startDayCount)+'_feed" style="height:20px; color: #46CCFF; font-size:13px;"></div><div id="'+year+''+month+''+setFixDayCount(startDayCount)+'_snack" style="height:20px; color:#FF7493; font-size:13px;"></div></div><input id="'+year+''+month+''+setFixDayCount(startDayCount)+'_radio" class="month_radio" type="radio" name="monthCal_date" value="'+setFixDayCount(startDayCount)+'"><span>'+startDayCount+'</span></div>';
	      } else {
	        calHtml +=
	          '<div class=\'calendar__day horizontalGutter\' id="'+year+''+month+''+setFixDayCount(startDayCount)+'"><div style="position: absolute; height: 40px; margin-left: 35px;"><div id="'+year+''+month+''+setFixDayCount(startDayCount)+'_feed" style="height:20px; color: #46CCFF; font-size:13px;"></div><div id="'+year+''+month+''+setFixDayCount(startDayCount)+'_snack" style="height:20px; color:#FF7493; font-size:13px;"></div></div><input id="'+year+''+month+''+setFixDayCount(startDayCount)+'_radio" class="month_radio" type="radio" name="monthCal_date" value="'+setFixDayCount(startDayCount)+'"><span>'+startDayCount+'</span></div>';
	      }
	    }
	    else if (i > 0 && startDayCount <= lastDay) {
	      if (j == 0) {
	        calHtml +=
	          '<div class=\'calendar__day horizontalGutter verticalGutter\' id="'+year+''+month+''+setFixDayCount(startDayCount)+'"><div style="position: absolute; height: 40px; margin-left: 35px;"><div id="'+year+''+month+''+setFixDayCount(startDayCount)+'_feed" style="height:20px; color: #46CCFF; font-size:13px;"></div><div id="'+year+''+month+''+setFixDayCount(startDayCount)+'_snack" style="height:20px; color:#FF7493; font-size:13px;"></div></div><input id="'+year+''+month+''+setFixDayCount(startDayCount)+'_radio" class="month_radio" type="radio" name="monthCal_date" value="'+setFixDayCount(startDayCount)+'"><span>'+startDayCount+'</span></div>';
	      } else if (j == 6) {
	        calHtml +=
	          '<div class=\'calendar__day verticalGutter\' id="'+year+''+month+''+setFixDayCount(startDayCount)+'"><div style="position: absolute; height: 40px; margin-left: 35px;"><div id="'+year+''+month+''+setFixDayCount(startDayCount)+'_feed" style="height:20px; color: #46CCFF; font-size:13px;"></div><div id="'+year+''+month+''+setFixDayCount(startDayCount)+'_snack" style="height:20px; color:#FF7493; font-size:13px;"></div></div><input id="'+year+''+month+''+setFixDayCount(startDayCount)+'_radio" class="month_radio" type="radio" name="monthCal_date" value="'+setFixDayCount(startDayCount)+'"><span>'+startDayCount+'</span></div>';
	      } else {
	        calHtml +=
	          '<div class=\'calendar__day horizontalGutter verticalGutter\' id="'+year+''+month+''+setFixDayCount(startDayCount)+'"><div style="position: absolute; height: 40px; margin-left: 35px;"><div id="'+year+''+month+''+setFixDayCount(startDayCount)+'_feed" style="height:20px; color: #46CCFF; font-size:13px;"></div><div id="'+year+''+month+''+setFixDayCount(startDayCount)+'_snack" style="height:20px; color:#FF7493; font-size:13px;"></div></div><input id="'+year+''+month+''+setFixDayCount(startDayCount)+'_radio" class="month_radio" type="radio" name="monthCal_date" value="'+setFixDayCount(startDayCount)+'"><span>'+startDayCount+'</span></span></div>';
	      }
	    }
	    else if (startDayCount > lastDay) {
	    	
	  	  break;
	    }
	    startDayCount++;
	  }
	}
	document.querySelector("#calendar").innerHTML = calHtml;
	document.getElementById('date_output_form').innerHTML = year+'년 '+month+'월';
};

function extend_cal(){
	cp=1;
	if(document.getElementById('month_calendar').style.display == 'none'){
		cal_type = 'month';
		//document.getElementById('week_calendar').style.display = 'none';
		//document.getElementById('month_calendar').style.display = 'block';
		$('#week_calendar').fadeOut('fast');
		$('#month_calendar').fadeIn('slow');
		$('#calendar_form').addClass('extend_calendar_form');
		
		if($('input[name=monthCal_date]').is(':checked')) {
			$('input[name=monthCal_date]:checked').prop('checked',false);
		}
		if(stats_type=="eat") document.getElementById('eat_chart_form').style.display = 'none';
		document.getElementById('stats_name').innerHTML = monthCal_month+'월 '+stats_name+' 통계';
		get_total_stats('month',(monthCal_year+''+setFixDayCount(monthCal_month)));
		document.getElementById('extend_icon').checked = true;
		
	} else{
		cal_type = 'week';
		//document.getElementById('week_calendar').style.display = 'block';
		//document.getElementById('month_calendar').style.display = 'none';
		$('#week_calendar').fadeIn('slow');
		$('#month_calendar').fadeOut('fast');
		$('#calendar_form').removeClass('extend_calendar_form');
		if(stats_type=="eat") document.getElementById('eat_chart_form').style.display = 'block';
		document.getElementById('stats_name').innerHTML ='이번주 '+stats_name+' 통계';
		get_total_stats('week','');
		document.getElementById('extend_icon').checked = false;
	}
}

function getWalkDetail(idx){
	//document.getElementById('walk_detail_modal').style.display = 'block';
	//document.getElementById('bg_black').style.display = 'block';
	$('#walk_detail_modal').fadeIn('slow');
	$('#bg_black').fadeIn('slow');
	
	if(stats_type=='walk'){
		$.ajax({
			url: 'walk_get_detail.do',
	   		method: 'POST',
	        data: {
	        	'walk_idx':idx,
	        	'pet_idx':selected_pet_idx
	        },
	        contentType : "application/x-www-form-urlencoded; charset=utf-8",
	        dataType : "json",
	        success: function (data) {
	        	var dto = data.dto;
	        	var walk_idx = dto.walk_idx;
	        	var img_path = '${pageContext.request.contextPath}/pet/walk_imgs/'+walk_idx+'/';
	        	var gauge_percent = Math.round(Number(dto.walk_time)/18);
	        	var detail_dis = dto.walk_distance;
	        	var detail_cal = Math.round(detail_dis*0.7);
	        	if(detail_cal>=1000){
	        		detail_cal = (parseInt(detail_cal/1000)+((Math.round((detail_cal%1000)/100))/10))+'kcal';
            	}else{
            		detail_cal = detail_cal+'cal';
            	}
	        	
	        	if(detail_dis>=1000){
	        		detail_dis = (parseInt(detail_dis/1000)+((Math.round((detail_dis%1000)/100))/10))+'km';
            	}else{
            		detail_dis = detail_dis+'m';
            	}
	        	var detail_time = dto.walk_time;
	        	var detail_min = parseInt(detail_time/60);
	        	var detail_sec = detail_time%60;
	        	
	        	
	        	console.log('percent'+gauge_percent);
	        	
	        	document.getElementById('gauge_form').innerHTML =
	        		'<div class="GaugeMeter" data-percent="'+gauge_percent+'" data-size="250" data-width="7" data-color="#94b8ff" data-animationstep="1" style="margin: 0px auto;">'+
	        			'<div style="position: absolute; width:100px; margin: 75px;">'+
	        				'<div><i style="display: inline-block; width: 50px; height: 50px; border-radius: 100%; background-size: cover; background-image: url(\'${pageContext.request.contextPath}/pet/'+dto.walk_pet_idx+'/profile.png\');"></i></div>'+
	        				'<div style="text-align: center; font-size: 30px; font-weight: bold;">'+setFixDayCount(detail_min)+':'+setFixDayCount(detail_sec)+'</div>'+
	        				'<div style="text-align: center; font-size: 13px; color: #757575;">산책량 '+gauge_percent+'%</div>'+
	        			'</div>'+
	        		'</div>';
	        	
	        	document.getElementById('detail_dis').innerHTML = detail_dis;
	        	document.getElementById('detail_cal').innerHTML = detail_cal;
	        		
	        	$('.GaugeMeter').gaugeMeter();
	        	
	        	
	        	
	        	var walk_detail = data.walk_detail;
	        	var polyline_path = new Array();
	        	var marker_poop;
	        	var marker_cam;
	        	//===================map
	    	    var map;
	        	
	        	for(var i=0; i<walk_detail.length; i++){
	        		
	        		if(walk_detail[i].type=='walk'){
	        			console.log('walk');
	        			if(i==0){
	        				console.log('i=0');
	        				var container = document.getElementById('map');
	        	    	    var options = {
	        	    	    	level: 3,
	        	    	    	center: new kakao.maps.LatLng(walk_detail[i].lat, walk_detail[i].lng)
	        	    	    };
	        	    	    map = new kakao.maps.Map(container, options);
	        			}
	        			polyline_path.push(new kakao.maps.LatLng(walk_detail[i].lat, walk_detail[i].lng));
	        			polyline = new kakao.maps.Polyline({
	        			    map: map,
	        			    path: polyline_path,
	        			    strokeWeight: 10,
	        			    strokeColor: '#94b8ff',
	        			    strokeOpacity: 0.8
	        			});
	        		}else if(walk_detail[i].type=='poop'){
	        			var poop_icon = new kakao.maps.MarkerImage(
	        		    		poop_icon_path,
	        		    	    new kakao.maps.Size(15, 15),
	        		    	    {
	        		    	        offset: new kakao.maps.Point(12, 12),
	        		    	    }
	        		    );
	        			
	        			 marker_poop = new kakao.maps.Marker({
	       			        map: map,
	       			        position: new kakao.maps.LatLng(walk_detail[i].lat, walk_detail[i].lng),
	       			    	opacity: 0.8,
	       			    	image:poop_icon,
	       			    	zIndex:1
	       			    });
	        		}else if(walk_detail[i].type=='cam'){
	        			var img = walk_detail[i].img;
	        			var img_src = img_path+img;
	        			console.log(img_src);
	        			
	        			var cam_icon = new kakao.maps.MarkerImage(
	        					cam_icon_path,
	        		    	    new kakao.maps.Size(40, 40),
	        		    	    {
	        		    	        offset: new kakao.maps.Point(12, 12),
	        		    	    }
	        		    );
	        			marker_cam = new kakao.maps.Marker({
	       			        map: map,
	       			        position: new kakao.maps.LatLng(walk_detail[i].lat, walk_detail[i].lng),
	       			    	opacity: 1,
	       			    	zIndex:2,
	       			    	image:cam_icon
	       			    });
	        			
	        			kakao.maps.event.addListener(marker_cam, 'click', (function() {
	        				var c_walk_idx = walk_idx;
	        				var c_img = img;
	        				return function(){
	        					get_marker_image(c_walk_idx, c_img);
	        				};
	        			})());
	        			//온클릭 이벤트로 해당 이미지 가져오는 역할 해야함
	        		}
	        	}
	        	//=======================
	        	
	        		
	        },
	        error: function () {
	        
	        },
		});
	}
	
}

function get_marker_image(walk_idx, img){
	console.log(walk_idx, img);
	
	var path = '${pageContext.request.contextPath}/pet/walk_imgs/'+walk_idx+'/'+img+'.jpg';
	
	document.getElementById('detail_img').src = path;
	document.getElementById('detail_img_modal').style.display = 'block';
	
}
function modal_close(type){
	if(type=='detail'){
		document.getElementById('walk_detail_modal').style.display = 'none';
		document.getElementById('bg_black').style.display = 'none';
	}else if('img'){
		document.getElementById('detail_img_modal').style.display = 'none';
	}
	
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

.pet_list_item{
overflow: hidden;
border-radius: 100%;
border-style: solid;
border-color: #E0E0E0;
border-width: 4px;
}
.pet_radio:checked + div{
border-color: #94b8ff;
}
.type_item{
border-radius: 10px;
background-color: #E0E0E0;
width: 100px; 
height: 40px; 
margin: 0px auto; 
text-align: center;
line-height: 40px;
font-size: 14px;
}
.type_radio:checked + div{
background-color: #94b8ff;
}



.calendar__day {
  float: left;
  width: calc(98% / 7);
  height: 40px;
}
.calendar__day > span{
display: block;
margin: auto;
width: 40px;
text-align: center;
font-weight: bold;
font-size: 14px;
line-height: 40px;
}

.horizontalGutter {
  margin-right: calc(2% / 7);
}

.verticalGutter {
  margin-top: calc(2% / 7);
}
.calendar_week{
color: #757575;
}

.month_radio{
display:none;
}
.month_radio:checked + span{
border-radius: 100%;
overflow: hidden;
background-color: #94b8ff;
color: white;
}
.week_today > span{
border-radius: 100%;
overflow: hidden;
background-color: #94b8ff;
color: white;
}

.history_date{
color: #94b8ff;
}

.calendar_form{
height: 70px;
transition: 0.5s;
overflow: hidden;
}

.extend_calendar_form{
height: 355px;
}

#stats_name{
font-size: 30px;
font-weight: bold;
background: white;
width: 95%;
margin: 0px auto;
}
.stats_list_item{
border-radius: 15px;
border-style: solid;
border-color: #E0E0E0;
border-width: 2px;
padding: 10px;
margin-bottom: 20px;
height: 100px;
}




.GaugeMeter {
  position: Relative;
  text-align: Center;
  overflow: Hidden;
  cursor: Default;
}

.GaugeMeter SPAN, .GaugeMeter B {
  width: 54%;
  position: Absolute;
  text-align: Center;
  display: Inline-Block;
  color: RGBa(0,0,0,.8);
  font-weight: 100;
  font-family: "Open Sans", Arial;
  overflow: Hidden;
  white-space: NoWrap;
  text-overflow: Ellipsis;
  margin: 0 23%;
  display:none;
}

.GaugeMeter[data-style="Semi"] B {
  width: 80%;
  margin: 0 10%;
}

.GaugeMeter S, .GaugeMeter U {
  text-decoration: None;
  font-size: .60em;
  font-weight: 200;
  opacity: .6;
}

.GaugeMeter B {
  color: #000;
  font-weight: 200;
  opacity: .8;
}
.extendBt_down{
background-image: url('${pageContext.request.contextPath}/images/down_icon.png');
}
#extend_icon:checked + i{
background-image: url('${pageContext.request.contextPath}/images/up_icon.png');
}


</style>
</head>
<body style="">
<%@ include file="../header.jsp" %>
<div id="bg_black"></div>
<div id="detail_img_modal" style="width: 70vw; height: 80vh; display: none; padding: 3vw;z-index: 3; position: fixed; background-color: black; margin-left: 15vw; margin-top: 10vh;">
	<div class="modal_close" style="width:50px; height: 50px; position: absolute; right: -60px; top:-1vw; ;background-image:url('${pageContext.request.contextPath}/images/close.png'); background-size: cover;cursor: pointer;" onclick="modal_close('img')"></div>
	<img id="detail_img" style="height: 100%; margin: 0px auto; display: block;">
</div>
<div id="walk_detail_modal" style="width: 40vw; height: 80vh; display: none; z-index: 2; position: fixed; background-color: white; margin-left: 30vw; margin-top: 10vh;">
	<div class="modal_close" style="width:50px; height: 50px; position: absolute; right: -60px; background-image:url('${pageContext.request.contextPath}/images/close.png'); background-size: cover;cursor: pointer;" onclick="modal_close('detail')"></div>
	<div id="map" style="width: 90%; height: 60%; margin-left: 5%; margin-top: 2%;"></div>
	<div id="walk_detail_form">
		<div id="gauge_form"></div>
		<div class="row" id="detail_other_form" style=" margin-top:-100px;">
			<div class="col-xs-6" style="text-align: center; font-size:12px; color: #757575;">이동거리</div>
			<div class="col-xs-6" style="text-align: center;  font-size:12px; color: #757575;">소모 칼로리</div>
			<div id="detail_dis" class="col-xs-6" style="text-align: center; font-size:30px;">
			</div>
			<div id="detail_cal" class="col-xs-6" style="text-align: center;  font-size:30px;">
			</div>
		</div>
	</div>
</div>
<div class='container' style="padding-top: 150px; padding-bottom: 50px; color: #4b5f5a; font-family: 'Lato', Arial, sans-serif;">
	<div id="background_content" style="width:100%; height: 100%; background-color: white; border-radius: 15px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.35); padding: 20px 20px;">
		<div class="row" style="width: 50%; margin: 0px auto; margin-bottom: 70px; margin-top: 20px;">
			<div class="col-xs-6">
				<input id="type_walk" class="type_radio" type="radio" name="type_list" value="walk" checked style="display: none;" onchange="firstSetup('walk');">
				<div class="type_item"><label style="width: 100%; height: 100%;" for="type_walk">산책 통계</label></div>
			</div>
			<div class="col-xs-6">
				<input id="type_eat" class="type_radio" type="radio" name="type_list" value="eat" style="display: none;" onchange="firstSetup('eat');">
				<div class="type_item"><label style="width: 100%; height: 100%;" for="type_eat">식사 통계</label></div>
			</div>
		</div>
		
		<div class="row" style="width:80%; margin: 20px auto;">
			<c:forEach var="list" items="${pet_list}" varStatus="i">
				<div class="col-xs-3" style="padding: 0px 10px;" onclick="select_pet(${list.PET_IDX});">
					<input id="${list.PET_IDX}_pet" class="pet_radio" type="radio" name="pet_list" value="${list.PET_IDX}" style="display:none;" onclick="select_pet(${list.PET_IDX});" ${i.first? "checked":""}>
					<div class="pet_list_item" style="width:100%; padding-bottom: 100%; background-size: cover; background-image: url('${pageContext.request.contextPath}/pet/${list.PET_IDX}/profile.png');"></div>
					<div style="width:100%; text-align: center; font-size: 14px;">${list.PET_NAME}</div>
				</div>
			</c:forEach>
		</div>
		<div class="row" style="width: 80%; margin: 50px auto;">
			<div id="calendar_form" class="col-xs-12 calendar_form">
				<div class="row">
					<div id="month_calendar" style="display: none">
						<div id="remote_date" style="height: 60px; margin: 0px auto; text-align: center;">
							<div id="move_prev" style=" display: inline-block; margin-right: 10%;" onclick="date_move('prev');">
								<i style="width: 20px; height: 20px; display: inline-block; background: url('${pageContext.request.contextPath}/images/left.png'); background-size: cover;"></i>
							</div>
							<div id="date_output_form" style="text-align: center; font-size: 20px; display: inline-block;"></div>
							<div id="move_next" style="display: inline-block; margin-left: 10%;" onclick="date_move('next');">
								<i style="width: 20px; height: 20px; display: inline-block; background: url('${pageContext.request.contextPath}/images/right.png'); background-size: cover;" ></i>
							</div>
						</div>
						<div class="calendar__day horizontalGutter calendar_week"><span>일</span></div>
						<div class="calendar__day horizontalGutter calendar_week"><span>월</span></div>
						<div class="calendar__day horizontalGutter calendar_week"><span>화</span></div>
						<div class="calendar__day horizontalGutter calendar_week"><span>수</span></div>
						<div class="calendar__day horizontalGutter calendar_week"><span>목</span></div>
						<div class="calendar__day horizontalGutter calendar_week"><span>금</span></div>
						<div class="calendar__day calendar_week"><span>토</span></div>
						<div id="calendar"></div>
					</div>
				</div>
				<div class="row">
					<div id="week_calendar" style="width: 100%;" onclick="extend_cal();"></div>
				</div>
			</div>
			<div id="extend_calendar" class="col-xs-12 extend_cal" style="margin: 0px auto; width: 95%; height: 30px; background-color: #E0E0E0; text-align: center;" onclick="extend_cal();"><input type="checkbox" id="extend_icon" style="display:none;"><i class="extendBt_down"style="display: inline-block; width:30px; height:30px; background-size: cover;">　</i></div>
		</div>
		
		<div class="row" style="width: 80%; margin: 0px auto; margin-bottom: 30px;">
			<div class="col-xs-12">
				<div id="stats_name"></div>
			</div>
		</div>
		
		<div id="eat_chart_form" class="row">
			<div id="week_chart" style="margin:0px auto; width: 750px;"></div>
		</div>
		
		<div id="total_stats_form" class="row" style="width: 80%; height: 90px; padding-top: 15px; font-weight: bold; color: white; margin: 0px auto; margin-bottom: 30px; background-color: #94b8ff; border-radius: 15px; border-style: solid; border-width: 3px; border-color: #E0E0E0;">
			<div id="total_dis_form" class="col-xs-6">
				<div style="width: 100px; margin: 0px auto;">
					<div id="totaL_dis_name" style="font-size: 18px; text-align: center;">총 거리</div>
					<div id="total_dis_data" style="font-size: 18px; text-align: center;"></div>
				</div>
			</div>
			<div id="total_time_form" class="col-xs-6">
				<div style="width: 100px; margin: 0px auto;">
					<div id="totaL_time_name" style="font-size: 18px; text-align: center;">총 시간</div>
					<div id="total_time_data" style="font-size: 18px; text-align: center;"></div>
				</div>
			</div>
		</div>
		
		<div id="stats_form" class="row" style="width: 70%; margin: 50px auto;">
		</div>
	</div>
</div>
<%@ include file="../footer.jsp" %>
</body>
</html>
