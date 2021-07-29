<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css" integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay" crossorigin="anonymous">
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>


<style type="text/css">
input[type="text"]::placeholder {
  font-size: 15px;
  
}
p{
 font-size: 20px;
}

</style>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>
	
	<div class="container" style="padding-top: 150px;">
		<h3 class="titleFont mt-3">예약 세부사항</h3>
		<div class="card col-sm-12 font" style=" border-radius: 15px; box-shadow: rgba(0, 0, 0, 0.05) 0px 2px 20px;">
			
			<div class="col-sm-12 mt-3">
				<div class="col-sm-12 p-0">
					<div class="col-6 pt-5" style="float: left;">
						<p>${sitter.user_name += ' 펫시터님'}<p>
						<p>${sitter.user_addr }</p>
					</div>
						<img src="${pageContext.request.contextPath}/sitter/${sitter.user_idx}/background0.png" style="width: 300px; height: 150px; border-radius: 5px; float: left;">
				</div>
					
			</div>
			
			<div class="col-sm-12 mt-5">
				<div class="col-sm-6 pt-1 mb-5">
					<p>예약하실 날짜 </p>
					<div class="input-group" id = "daterange"  style="background-color: white;">
						<span class="input-group-addon" style="width: 50px; font-size: 23px;">
							<i class="fa fa-calendar bigger-110"></i>
						</span>
						<input class="form-control" type="text" name="from" placeholder="시작날짜 " readonly="readonly" style="text-align: center; font-size: 15px; height: 40px;">
						<input class="form-control" type="text" name ="to" placeholder="종료날짜" readonly="readonly" style="text-align: center; font-size: 15px; height: 40px;">
						
					</div>
				</div>
				<div class="col-sm-6 pt-1 mb-5">
					<p>체크인/아웃 시간</p>
					<div class="input-group" style="background-color: white;">
						<span class="input-group-addon" style="width: 50px; font-size: 23px; ">
							<i class="far fa-clock" ></i>
						</span>
						<input class="form-control" type="text" name="from_t" placeholder="체크인" readonly="readonly" style="text-align: center; font-size: 15px; height: 40px;">
						<input class="form-control" type="text" name="to_t" placeholder="체크아웃" readonly="readonly" style="text-align: center; font-size: 15px; height: 40px;" >
					</div>
				</div>
			</div>
			
			
			<div class="col-sm-12 mt-3">
				
				<div class="col-sm-12 ">
					<p>맡기실 반려동물<p>
					<fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy" var="today" /> 
					<c:forEach var="pet" items="${petList}">
						<div class="col-sm-6 mb-3 p-1" style="border: 1px solid gray;">
							<img src="${pageContext.request.contextPath}/pet/${pet.PET_IDX}/profile.png" style="width: 80px; height: 80px; float: left;">
							<div class="col-6" style="float: left;">
								<p>${pet.PET_NAME }</p>
								<p><label name='${pet.PET_IDX }'>
									<c:if test="${pet.PET_WEIGHT < 7}">
										<c:if test="${sitter.ss == 0 }"></c:if>
									소형
									</c:if>
	                                <c:if test="${pet.PET_WEIGHT >= 7 and pet.PET_WEIGHT < 15}">중형</c:if>
	                                <c:if test="${pet.PET_WEIGHT >= 15}">대형</c:if>
								</label> / 
								<c:if test="${pet.PET_SEX == 'male'}">남</c:if>
	                            <c:if test="${pet.PET_SEX == 'female'}">여</c:if>/ 
									
								<fmt:formatDate value="${pet.PET_BIRTH}" pattern="yyyy" var="birth" />  
	                                ${birth-today+1}살
	                           	</p>
							</div>
							<div class="col-sm-2 pl-5" style="height: 80px;">
								<input type="checkbox" value="${pet.PET_IDX }" onchange="price(this,'${pet.PET_WEIGHT}');" style="width: 30px; height: 30px;"
								<c:if test="${(pet.PET_WEIGHT < 7 and sitter.ss == 0) || (pet.PET_WEIGHT >= 15 and sitter.ls == 0) || (pet.PET_WEIGHT >= 7 and pet.PET_WEIGHT < 15 and sitter.ms == 0)}">
									disabled="disabled"
								</c:if>
								
								
								></input>
							</div>
						</div>
					</c:forEach>
					
				</div>
				
				<div class="text-center col-sm-12 mt-3">
						<p style="font-size: 25px;"><a href = "pet_register.do"><i class="fas fa-plus-circle"></i> 반려동물 등록</a></p>
				</div>
				
				<div class=" col-sm-12 mt-3" style="height: 300px;">
					<p>요청사항</p>
					<textarea name ="req" rows="" cols="" placeholder="ex)낯가림이 심해요." style="height: 200px;"></textarea>
				</div>
				
			</div>
				
			<div class="col-sm-12">
				<div class="text-center col-sm-6 mb-5" >
					<i class="far fa-credit-card" onclick="addCard();" style="width: 300px; height: 200px; font-size: 300px;"></i>
				</div>
				<div class="col-sm-6 font">
					<p style="margin-top: 50px; font-size: 30px;">결제하실 카드를 등록해주세요</p> 
					<p>예약 수락전에는 결제되지 않습니다.</p>
				</div>
			</div>
		</div>
	</div>	
<div class="text-center mt-5 p-3 pt-4" style="position: fixed; bottom: 0px; left: 0px; right: 0px; height: 80px; background-color: white; box-shadow: rgba(0, 0, 0, 0.05) 0px -3px 7px; z-index: 2;">
       	
       	<div class="text-center font">
       	<span style="border-radius:12px; background-color: white; display:inline-block; height: 50px; margin-left: 20px;">
			<div>
				<p style="float: left">최종결제 금액<br>
				<label id = "price"></label>
				</p>
				<span style="border-radius:12px; top:20px; background-color: white; display:inline-block; height: 50px; margin-left: 20px;">
					<button id = "bookSubmit" type="button" class="btn btn-outline-primary font" style="border-radius:12px; width: 150px; height: 50px; font-size: 20px">예약하기</button>       	
				</span>
			</div>
		</span>
       	
		</div>
    </div>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
<script>
$(function() {
	$("#bookSubmit").click(function() {
		var pet_idx = '';
	    $("input[type='checkbox']:checked").each(function(i) {
	        pet_idx +=$(this).val()+',';
	    });
	    pet_idx = pet_idx.substring(0,pet_idx.length-1);
	    
	    var allData = { 
	    	"user_idx" : '${sessionScope.s_user.user_idx}',
	    	"sitter_idx" : '${sitter.user_idx}',
	    	"book_from" : $('input[name="from"]').val() + ' ' + $('input[name="from_t"]').val() + ':00', 
	   		"book_to" : $('input[name="to"]').val() + ' ' + $('input[name="to_t"]').val() + ':00',
	   		"book_req" : $('textarea[name="req"]').val(),
	   		"pet_idx" : pet_idx,
	   		"book_price" : totalP
	   	};
	    $.ajax({
			url : 'bookApply.do',
			data : allData,
			type : 'GET',
			success : function(result) {
				
				send('alarm','${sitter.user_idx}',result.message)
				location.href='bookList.do';
			}
		});
	});
})
var fromD;
var toD;
var dateDiff;
$(function() {
	var a = moment("2021-02-17");
	var b = moment("2021-02-20");
	var x = moment("2021-03-17");
	var y = moment("2021-03-20");
	$("#daterange").daterangepicker({ 
		 
		isInvalidDate: function (date) {
			if (date >= a && date <= b) {
                return true;
            }
            if(date >= x && date <= y) {
                return true;
            }
            return false;
	    },
		locale: { 
			format : "YYYY-MM-DD/hh24", 
			separator : "  ~  ", 
			applyLabel : "확인", 
			cancelLabel : "취소", 
			fromLabel : "From", 
			toLabel : "To", 
			customRangeLabel : "Custom", 
			weekLabel : "W", 
			daysOfWeek : ["일", "월", "화", "수", "목", "금", "토"], 
			monthNames : ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"], 
			datesDisabled : ['2021-02-24','2021-02-26']
		},  
		maxSpan : {"days": 14},
		minDate : new Date(),
		maxDate : new Date(2021,3),
		timePicker : true,
		timePickerIncrement : 60,
		autoUpdateInput: false
		}, 
	
	function (start, end, label) { 
		console.log('New date range selected: ' + start.format('YY-MM-DD / hh') + ' to ' + end.format('YY-MM-DD / hh') + ' (predefined range: ' + label + ')'); 
	});
	
	$("#daterange").on('apply.daterangepicker', function(ev, picker) {
		var from = picker.startDate.format('YYYY-MM-DD/hh').split('/');
		var to = picker.endDate.format('YYYY-MM-DD/hh').split('/'); 
		

		fromD = from[0].split('-');
		toD = to[0].split('-');
		totalP = 0;
		fromD = new Date(fromD[0], fromD[1]-1, fromD[2]);
		toD = new Date(toD[0], toD[1]-1, toD[2]);
		dateDiff = Math.ceil((toD.getTime()-fromD.getTime())/(1000*3600*24));
		
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
var u_id = new Date().getTime();
</script>

<script>
var totalP = 0;
var price_ = 0;
function price(box,weight){
	var text = '';
	
	if($('input[name="from"]').val() === $('input[name="to"]').val()){
		text = '(데이케어)';
		if(weight < 7){
			price_ = ${sitter.ss};	
		}else if(weight >= 15 ){
			price_ = ${sitter.ls};	
		}else{
			price_ = ${sitter.ms};	
		}
	}else{
		text = ' ('+dateDiff+'박)';
		if(weight < 7){
			price_ = ${sitter.sl}*dateDiff;	
		}else if(weight >= 15 ){
			price_ = ${sitter.ll}*dateDiff;	
		}else{
			price_ = ${sitter.ml}*dateDiff;	
		}
	}
	
	if(box.checked == true){		
		totalP = totalP + price_;
	}else{
		totalP = totalP - price_;
	}
	
	$("#price").html(totalP + text);
	
}
</script>
<script>
function addCard(){
IMP.init('imp69207811'); 
	IMP.request_pay({ // param
	    pg: "kakaopay",
	    pay_method: "card", // "card"만 지원됩니다
	    merchant_uid: 'merchant_' + new Date().getTime(), // 빌링키 발급용 주문번호
	    customer_uid: "${sessionScope.s_user.user_idx}", // 카드(빌링키)와 1:1로 대응하는 값
	    name: "최초인증결제",
	    amount: 0, // 0 으로 설정하여 빌링키 발급만 진행합니다.
	    buyer_email: "${sessionScope.s_user.user_email}",
	    buyer_name: "${sessionScope.s_user.user_name}",
	    buyer_tel: "${sessionScope.s_user.user_tel}",
	    buyer_addr: "${sessionScope.s_user.user_addr}",
	    buyer_postcode: ""
	},function (rsp) { // callback
	    if (rsp.success) {
	        // 빌링키 발급 성공
	        // jQuery로 HTTP 요청
	    	$.ajax({
				url : 'cardSave.do',
				success : function(result) {
					alert('카드등록 성공');
				}
			});
	    } else {
	        alert('등록 실패');
	    }
	});
}
</script>
</html>