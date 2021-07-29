<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 구글 차트 호출을 위한 js 파일 -->
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script src='https://code.jquery.com/jquery-3.5.1.min.js'></script>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	google.charts.load('current', {
		'packages' : [ 'corechart','geochart','line','controls' ]
	});

	google.charts.setOnLoadCallback(defaultChartList);
	google.charts.setOnLoadCallback(areaChartList);
	function defaultChartList() {

		var jsonData = $.ajax({
			url : "defaultChartList.do",
			dataType : "json",
			type : "post",
			async : false
		}).responseText;
		 var data = new google.visualization.DataTable(jsonData);
	//	var chart = new google.visualization.PieChart(
	//	document.getElementByld('chart_div')); //원형 그래프
//
		//var data = new google.visualization.DataTable(jsonData);
		//var chart  = new google.visualization.LineChart(
		  //    document.getElementById('chart_div')); //선 그래프
		 
// var chart  = new google.visualization.LineChart(
//    document.getElementById('chart_div')); //선 그래프
	var chart = new google.visualization.ColumnChart(document
				.getElementById('chart_div'));
		//차트 객체.draw(데이터 테이블, 옵션) //막대그래프
		chart.draw(data, {
			title : "입출고 통계",
			curveType : "function", //curveType는 차트의 모양이 곡선으로 바뀐다는 뜻
			width : 600,
			height : 400
		});

	}
	
	function peridoChartList() {
		
		var period = document.getElementById("period").value;
		var jsonData = $.ajax({
			url : "periodChart.do",
			data : {'period':period},
			dataType : "json",
			type : "post",
			async : false
		}).responseText;
		console.log(jsonData);
		//var chart = new google.visualization.PieChart(
		//document.getElementByld('chart_div')); //원형 그래프

		var data = new google.visualization.DataTable(jsonData);
		var chart  = new google.visualization.LineChart(document.getElementById('chart_div2')); //선 그래프
		//차트 객체.draw(데이터 테이블, 옵션) //막대그래프
		chart.draw(data, {
			title : "기간별 통계",
			curveType : "function", //curveType는 차트의 모양이 곡선으로 바뀐다는 뜻
			width : 600,
			height : 400
		});
		
	    
	}
	
function areaChartList() {
		
		var jsonData = $.ajax({
			url : "areaChart.do",
			dataType : "json",
			type : "post",
			async : false
		}).responseText;

console.log(jsonData);
		var data = new google.visualization.DataTable(JSON.stringify(jsonData));
		var chart  = new google.visualization.GeoChart(document.getElementById('chart_div3')); 

		chart.draw(data, {
			title : "지역별",
			legend: 'none',	
			
			region:'KR', //country code
			keepAspectRatio: true,
			width:600,
			height:400,
		});

	}	
	
	
	
	function changePeriod(v){
		document.getElementById("period").value = v.value;
		peridoChartList();
	}
	
	/*=================================================================================================================*/
	
	  var chartDrowFun = {
			    chartDrow : function(){
			      

			        function drawDashboard() {
			        	var period = document.getElementById("period").value;
			        	var jsonData = $.ajax({
			    			url : "newChart.do",
			    			dataType : "json",
			    			type : "post",
			    			async : false
			    		}).responseText;
					        	 var chartData = '';
									
							        //날짜형식 변경하고 싶으시면 이 부분 수정하세요.
							        var chartDateformat 	= 'yyyy-MM-dd';
							        //라인차트의 라인 수
							        var chartLineCount    = 10;
							        //컨트롤러 바 차트의 라인 수
							        var controlLineCount	= 10;
					        	    var data = new google.visualization.DataTable(jsonData);
							      
									console.log('=============================================');
									console.log(jsonData);

							            var chart = new google.visualization.ChartWrapper({
							              chartType   : 'LineChart',
							              containerId : 'lineChartArea', //라인 차트 생성할 영역
							              options     : {
							                              isStacked   : 'percent',
							                              focusTarget : 'category',
							                              height		  : 500,
							                              width			  : '100%',
							                              legend		  : { position: "top", textStyle: {fontSize: 13}},
							                              pointSize		: 5,
							                              tooltip		  : {textStyle : {fontSize:12}, showColorCode : true,trigger: 'both'},
							                              hAxis			  : {format: chartDateformat, gridlines:{count:chartLineCount,units: {
							                                                                  years : {format: ['yyyy년']},
							                                                                  months: {format: ['MM월']}}
							                                                                },textStyle: {fontSize:12}},
							                vAxis			  : {minValue: 100,viewWindow:{min:0},gridlines:{count:-1},textStyle:{fontSize:12}},
							                animation		: {startup: true,duration: 1000,easing: 'in' },
							                annotations	: {pattern: chartDateformat,
							                                textStyle: {
							                                fontSize: 15,
							                                bold: true,
							                                italic: true,
							                                color: '#871b47',
							                                auraColor: '#d799ae',
							                                opacity: 0.8,
							                                pattern: chartDateformat
							                              }
							                            }
							              }
							            });

							            var control = new google.visualization.ControlWrapper({
							              controlType: 'ChartRangeFilter',
							              containerId: 'controlsArea',  //control bar를 생성할 영역
							              options: {
							                  ui:{
							                        chartType: 'LineChart',
							                        chartOptions: {
							                        chartArea: {'width': '60%','height' : 80},
							                          hAxis: {'baselineColor': 'none', format: chartDateformat, textStyle: {fontSize:12},
							                            gridlines:{count:controlLineCount,units: {
							                                  years : {format: ['yyyy년']},
							                                  months: {format: ['MM월']}}
							                            }}
							                        }
							                  },
							                    filterColumnIndex: 0
							                }
							            });

					        	 
							            var date_formatter = new google.visualization.DateFormat({ pattern: chartDateformat});
							            date_formatter.format(data, 0);

							            var dashboard = new google.visualization.Dashboard(document.getElementById('Line_Controls_Chart'));
							            window.addEventListener('resize', function() { dashboard.draw(data); }, false); //화면 크기에 따라 그래프 크기 변경
							            dashboard.bind([control], [chart]);
							            dashboard.draw(data);

							            
					         }
					     
			      
			        google.charts.setOnLoadCallback(drawDashboard);
			        }
			          

			      }

	  $(document).ready(function(){
		  google.charts.load('current', {'packages':['line','controls']});
		  chartDrowFun.chartDrow(); //chartDrow() 실행
		});
</script>
<style type="text/css">
.tdspans {
	font-size: 15px;
	font-weight: bold;
}
</style>
</head>
<body>
	<div class="container">
		<!--Div that will hold the pie chart-->
		<div class="row">
		<div class="col-lg-12" id="Line_Controls_Chart">
					<!-- 라인 차트 생성할 영역 -->
					<div id="lineChartArea" style="padding: 0px 20px 0px 0px;"></div>
					<!-- 컨트롤바를 생성할 영역 -->
					<div id="controlsArea" style="padding: 0px 20px 0px 0px;"></div>
				</div>
		</div>
		<div class="row">
			<div class="col-lg-6" id="chart_div"></div>
			<div class="col-lg-6">
				<div id="chart_div2"></div>
				<div id="period_Chart" style="padding: 0px 20px 0px 0px;"></div>
			</div>

		</div>
		<div class="row">
			<div class="col-lg-6" id="chart_div3"></div>
			<div class="col-lg-6" id="chart_div4">
			</div>
		</div>

		<div class="row">
			<div class="col-lg-12">
				<table class="table">
					<tr>
						<th>최다 판매 상품</th>
						<td><span class="tdspans">${tcdto.mostProduct }</span>&nbsp;&nbsp;
							/&nbsp;&nbsp; ${tcdto.mostProductCount } 개</td>
						<th>최고 매출 상품</th>
						<td><span class="tdspans">${tcdto.bestProduct }</span>
							&nbsp;&nbsp;/&nbsp;&nbsp; <fmt:formatNumber value="${tcdto.bestProductEarn }" pattern="#,###" /> 원</td>
					</tr>
					<tr>
						<th>최저 판매 상품</th>
						<td><span class="tdspans">${tcdto.leastProduct }</span>
							&nbsp;&nbsp;/&nbsp;&nbsp; ${tcdto.leastProductCount } 개</td>
						<th>최저 매출 상품</th>
						<td><span class="tdspans">${tcdto.worstProduct }</span>&nbsp;&nbsp;
							/&nbsp;&nbsp; ${tcdto.worstProductEarn } 원</td>
					</tr>
					<tr>
						<th>최다 좋아요 상품</th>
						<td><span class="tdspans">${tcdto.mostLikeProduct } </span>&nbsp;&nbsp;/&nbsp;&nbsp;
							${tcdto.mostLikeCount } 개</td>
						<th>최고 공헌 유저</th>
						<td></td>
					</tr>
					<tr>
						<th>최다 구매 유저</th>
						<td><span class="tdspans">${budto.bestBuyUser }</span>&nbsp;&nbsp;
							/&nbsp;&nbsp; ${budto.bestBuyCount } 건</td>
						<th>최고 공헌 유저</th>
						<td><span class="tdspans">${budto.bestPayUser }</span>
							&nbsp;&nbsp;/&nbsp;&nbsp; <fmt:formatNumber value="${budto.bestPay }" pattern="#,###" /> 원</td>
					</tr>
				</table>
			</div>
		</div>
	</div>

	<input type="hidden" id="period" value="3">
<%@ include file="/WEB-INF/views/footer.jsp"%>
</body>
<script src="https://code.jquery.com/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="js/httpRequest.js"></script>
<script
	src='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js'></script>
<link rel='stylesheet'
	href='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css' />
</html>