<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css" integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay" crossorigin="anonymous">

<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
<style>

#addr::placeholder {
  font-size: 20px;
}
.item { 
    object-fit: fill;
    height: 245px;"
}

.sitterDto{
	background-color: white;
	height: auto;
}
ol.carousel-indicators {
    list-style: none;
    margin: 0px;
    padding: 0px;
    width: 0px;
    height: 0px;
}
.carousel-indicators .active{
	width: 0px;
	height: 0px;
}
</style>
<script>
$(function() {
	$('#daterange').daterangepicker({ 
		"locale": { 
			"format": "YYYY-MM-DD", 
			"separator": "  ~  ", 
			"applyLabel": "확인", 
			"cancelLabel": "취소", 
			"fromLabel": "From", 
			"toLabel": "To", 
			"customRangeLabel": "Custom", 
			"weekLabel": "W", 
			"daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"], 
			"monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"], 
		},  
	"maxSpan": {"days": 14},
	"minDate": new Date(),
	"maxDate": new Date(2021,3),
	"drops": "down" 
	}, 
	
	function (start, end, label) { 
		console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')'); 
	});
	
	$("#daterange").on('apply.daterangepicker', function(ev, picker) {
		var from = picker.startDate.format('YYYY-MM-DD/hh').split('/');
		var to = picker.endDate.format('YYYY-MM-DD/hh').split('/'); 
	    $('input[name="from"]').val(from[0]);
	    $('input[name="to"]').val(to[0]);
	    $('input[name="from_t"]').val(from[1]);
	    $('input[name="to_t"]').val(to[1]);
	});

	$("#daterange").on('cancel.daterangepicker', function(ev, picker) {
		 $('input[name="from"]').val('');
		 $('input[name="to"]').val('');
		 $('input[name="from_t"]').val('');
		 $('input[name="to_t"]').val('');
	});
});

</script> 
<script>
function searchAddress(){
	
	var q = document.getElementById('addr').value; //검색 내용
    //ajax 시작
    if(q){
		$.ajax({
			url : 'https://dapi.kakao.com/v2/local/search/address.json',
			headers : {'Authorization':'KakaoAK 3d2dbf77d9a9ba6a4c73493da5d7fc07'},
			type: 'GET',
			data : { 'query' : q },
			success : function(data){
				//호출 성공하면 작성할 내용
        	    if(data.documents){ // 값이 있으면
        	    	
        	    	var result="";
        	    	for(var i=0;i<data.documents.length;i++){
        	    		
        	    		result += "<i class='fas fa-map-marker-al' style='width:50px;'></i>"+"<a onclick='show(this);'>"+data.documents[i].address_name+"</a>"+"<br>";
        	    		
        	    	}
        	    	document.getElementById('searchAddr').style.display = '';
        	    	document.getElementById('searchAddr').innerHTML = result;
        	   		
				}
			}, 
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		}).done(function(data){console.log(data);});
    }
}

function show(addr){
	document.getElementById('addr').value = addr.text;
	document.getElementById('searchAddr').style.display = 'none';
}
$(function() {
	$('#carousel-example-generic').carousel({
		pause : "hover",
		wrap : true,
		keyboard : true
	});
});
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>
<div class="container" style="padding-top: 150px;">
	<div class="col-sm-12 font mb-5" style="box-shadow: rgba(0, 0, 0, 0.05) 0px 2px 20px;">
		
			<div class="col-sm-12 mt-5">
				<div class="col-sm-6 pt-1 mb-5">
					<p>어디에 사시나요?</p>
					<div class="input-group" style="background-color: white;">
						<span class="input-group-addon" style="width: 50px; font-size: 23px;">
							<i class="fas fa-search"></i>
						</span>
						<input class="form-control" id="addr" type="text" name="addr" placeholder="동이름을 검색(예: 논현동)" onkeyup="searchAddress();" style="text-align: center; font-size: 15px; height: 40px;">
						<span class="input-group-addon" onclick="document.getElementById('addr').value = null" style="width: 50px; font-size: 23px;">
							<i class="fas fa-times"></i>
						</span>
						<div class="font" id="searchAddr" style="position: absolute; background-color: white; display: none; margin-top: 40px; border: 2px solid lightgray; width: 100%; z-index: 5" ></div>	
					</div>
				</div>
				<div class="col-sm-6 pt-1 mb-5">
					<p>언제 맡기시나요?</p>
					<div class="input-group" id = "daterange"  style="background-color: white;">
						<span class="input-group-addon" style="width: 50px; font-size: 23px;">
							<i class="fa fa-calendar bigger-110"></i>
						</span>
						<input class="form-control" type="text" name="from" placeholder="시작날짜 " readonly="readonly" style="text-align: center; font-size: 15px; height: 40px;">
						<input class="form-control" type="text" name ="to" placeholder="종료날짜" readonly="readonly" style="text-align: center; font-size: 15px; height: 40px;">
					</div>
				</div>
				<div class="col-sm-12 ">
					<c:forEach var="tag" items="${tag}">
						<input type="checkbox" name="tag" value="${tag}">
					</c:forEach>
				</div>
			</div>
		
	</div>
	<div class="col-sm-12 text-right mt-5 ">
		<span style="border-radius:5px; background-color: white; display:inline-block; height: 30px; margin-right: 15px;">
      			<button type="button" class="btn btn-outline-primary font" style="border-radius:5px; width: 80px; height: 30px; font-size: 15px;" onclick="location.href ='#'">인기순</button>
      		</span>
      		<span style="border-radius:5px; background-color: white; display:inline-block; height: 30px; margin-right: 15px;">
      			<button type="button" class="btn btn-outline-primary font" style="border-radius:5px; width: 80px; height: 30px; font-size: 15px;" onclick="location.href ='#'">가격순</button>
      		</span>
      		<span style="border-radius:5px; background-color: white; display:inline-block; height: 30px; margin-right: 15px;">
      			<button type="button" class="btn btn-outline-primary font" style="border-radius:5px; width: 80px; height: 30px; font-size: 15px;" onclick="location.href ='#'">거리순</button>
      		</span>
	</div>

	<c:forEach var="sitter" items="${sitterList}">
	<div class="sitterDto col-sm-12 col-md-12 mt-5 p-1 rounded font" style="box-shadow: rgba(0, 0, 0, 0.05) 0px 2px 20px;">
		<div id="carousel-example-generic${sitter.user_idx }" class="carousel slide col-sm-12 col-md-5 p-0">
			<ol class="carousel-indicators">
			<c:forEach var="idx" begin="0" end="${fn:length(sitter.img)-1}">
				<li data-target="#carousel-example-generic${sitter.user_idx }" data-slide-to="${idx}" class="active"></li>
			</c:forEach>
			</ol>
			<div class="carousel-inner" role="listbox">
			<c:forEach var="idx" begin="0" end="${fn:length(sitter.img)-1 }">
				<div class="item ${idx == '0'? 'active' : ''} rounded">
					<img src="${pageContext.request.contextPath}/sitter/${sitter.user_idx}/background${idx}.png" style=" object-fit: fill ;width: 100%;">
					<div class="carousel-caption" style="color: white;">시터 집안 이미지</div>
				</div>
			</c:forEach>
			</div>
			<a class="left carousel-control" href="#carousel-example-generic${sitter.user_idx }" role="button" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
			</a>
			<a class="right carousel-control" href="#carousel-example-generic${sitter.user_idx }" role="button" data-slide="next">
				<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
			</a>
		</div>
		
		<div class="sitterInfo col-sm-12 col-md-7 pt-5 pl-5 pr-5" onclick="location.href='sitterProfile.do?user_idx=${sitter.user_idx}'">
			<p style="font-size: 15px;">${sitter.user_addr}</p>
			<p>${sitter.subject}</p>
			<hr style="margin-bottom: 50px;">
			<div class="col-sm-6">
        	<div class="starability-fade p-0"> 
				
			    <input type="radio"   value="1" disabled="disabled" ${sitter.avg == '1' ? 'checked' : ''}/>
			    <label for="rate5" title="Amazing">5 stars</label>
			
			    <input type="radio"   value="2" disabled="disabled" ${sitter.avg == '2' ? 'checked' : ''}/>
			    <label for="rate4" title="Very good">4 stars</label>
			
			    <input type="radio"  " value="3" disabled="disabled" ${sitter.avg == '3' ? 'checked' : ''}/>
			    <label for="rate3" title="Average">3 stars</label>
			
			    <input type="radio"   value="4" disabled="disabled" ${sitter.avg == '4' ? 'checked' : ''}/>
			    <label for="rate2" title="Not good">2 stars</label>
			
			    <input type="radio"   value="5" disabled="disabled" ${sitter.avg == '5' ? 'checked' : ''}/>
			    <label for="rate1" title="Terrible">1 star</label>
			   	<span style="font-size: 15px;"> 펫시터 후기 ${fn:length(sitter.star)}개</span>
			</div>
				
			</div>
			
			<div class="col-sm-6 right">
				<p>${sitter.ss += '원 | 데이케어' }</p>
				<p>${sitter.sl += '원 |  1박케어' }</p>
			</div>
			
		</div>
		
	</div>
	</c:forEach>
	
</div>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>