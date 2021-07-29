<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
<link rel="stylesheet" href="css/starability-all.min.css">

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
	height: 500px;
	margin: 0;
}
.table tbody tr td{
	border: 0;
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
<%@ include file="/WEB-INF/views/header.jsp" %>
	<div class="pt-5"></div>
	<div class="col-sm-12 p-0 mt-5 " >
		<div id="carousel-example-generic" class="carousel slide">
			<ol class="carousel-indicators">
			<c:forEach var="idx" begin="0" end="${fn:length(sitter.img)-1}">
				<li data-target="#carousel-example-generic" data-slide-to="${idx}" class="active"></li>
			</c:forEach>
			</ol>
			<div class="carousel-inner" role="listbox">
			<c:forEach var="idx" begin="0" end="${fn:length(sitter.img) - 1}">	
				<div class="item ${idx == '0'? 'active' : '' }">
					<img src="${pageContext.request.contextPath}/sitter/${sitter.user_idx}/background${idx}.png" style=" object-fit: fill ;width: 100%;">
					<div class="carousel-caption" style="color: white;">시터 집안 이미지</div>
				</div>
			</c:forEach>
			</div>
			<a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
			</a>
			<a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
				<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
			</a>
		</div>
	</div>

	<div class='container mt-5' style="padding-top: 80px;">

		<div class="row">
			
			<h3 class="titleFont col-sm-12 mt-5" style="color: white;">시터 프로필</h3>
			
			<div class="col-sm-7 mt-5">	
	            <div class="card">
	                <div class="card-body font">
	                    <div class="table-responsive">
	                        <table class="table">
	                            <tbody>
	                            <tr style="line-height:32px;">
	                                <td rowspan="2" style="width: 100px;">
	                                	<img src="${pageContext.request.contextPath}/user/${sitter.user_idx}/profile.png" style="width: 90px; height: 90px; border-radius: 12px;">
	                                </td>
	                                <td style="font-size: 17px;">
	                                    ${sitter.user_addr += ' 펫시터 ' += sitter.user_name += '님' }
	                       			</td>         
	                            </tr>
	                            <tr>
	                                <td>${sitter.subject}</td>
	                         	</tr>
	                            </tbody>
	                        </table>
	                    </div>
	                </div>
	            </div>
			
				<div class="pt-5"></div>
			
	            <div class="card">
	                <div class="card-header font">${sitter.user_name }님을 소개합니다</div>
	                <div class="card-body font">
	                   	<table class="table">
	                       	<tbody>
	                           	<tr style="line-height:32px;">
	                               	<td style="font-size: 15px;">
	                               		${sitter.content }
	                               	</td>
	                           	</tr>
	                       	</tbody>
	                   	</table>
	                </div>
	           	</div>
	           	
	           	<div class="pt-5"></div>
	           	
	           	<c:if test="${!empty petList}">
	           	<fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy" var="today" /> 
		        <c:forEach var="pet" items="${petList}">
	            <div class="card">
	                <div class="card-header font">함께 사는 반려동물</div>
	                <div class="card-body font">
	                    <table class="table">
	                        <tbody>
	                            <tr style="line-height:32px;">
	                                <td rowspan="2" style="width: 100px;"><img src="${pageContext.request.contextPath}/pet/${pet.PET_IDX }/profile.png" style="width: 70px; height: 70px; border-radius: 12px;"></td>
	                                <td>
	                                    ${pet.PET_NAME}
	                       			</td>         
	                            </tr>
	                            <tr>
	                                <td><c:if test="${pet.PET_WEIGHT < 7}">소형</c:if>
	                                <c:if test="${pet.PET_WEIGHT >= 7 and pet.PET_WEIGHT < 15}">중형</c:if>
	                                <c:if test="${pet.PET_WEIGHT >= 15}">대형</c:if>/
	                                <c:if test="${pet.PET_SEX == 'male'}">남</c:if>
	                                <c:if test="${pet.PET_SEX == 'female'}">여</c:if>/ 
									<fmt:formatDate value="${pet.PET_BIRTH}" pattern="yyyy" var="birth" />  
	                                ${today-birth+1}살
	                                </td>
	                         	</tr>
	                    	</tbody>
	                	</table>
	                </div>
	            </div>
				</c:forEach>
				</c:if>
				
				<div class="pt-5"></div>
				
	            <div class="card">
	                <div class="card-header font">자격증 및 수료증</div>
	                <div class="card-body font">
	                    <table class="table">
	                        <tbody>
	                            <tr style="line-height:32px;">
	                                <td rowspan="2" style="text-align: center;">
	                                	<img src="${pageContext.request.contextPath}/sitter/${sitter.user_idx}/license.png" style="width: 200px; height: 130px; margin: auto;">
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
	            
	            <div class="pt-5"></div>  
		            <div class="card">
				        <div class="card-header font">
				        	펫시터 후기 ${fn:length(reviewList)}개
				        	
				        	<fieldset class="starability-fade float-right"> 
								
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
							    
	  						</fieldset>
				        	
				        </div>
				        <div class="card-body font">
				            <table class="table">
				                <tbody>
				                <c:forEach var="review" items="${reviewList }">	
		                            <tr style="line-height:32px;">
		                                <td rowspan="2" style="width: 100px;"><img src="${pageContext.request.contextPath}/user/${review.user_idx}/profile.png" style="width: 70px; height: 70px; border-radius: 12px;"></td>
		                                <td>
		                                    ${review.user_name += ' 님'}
		                                    
		                       			</td>         
		                            </tr>
		                            <tr>
		                                <td>${review.review_writedate }</td>
		                         	</tr>		                  
		                         	<c:if test="${!empty review.review_img }">
		                         	<tr>		                     
		                         	<c:set var="idx" value="${fn:length(review.review_img)-1 }"></c:set>
		                         	<td colspan="2">
	                         		<c:forEach  var="i" begin="0" end="${idx}">
	                         			<img src="${pageContext.request.contextPath}/review/${review.book_idx}/${i}.png" style="width: 100px; height: 100px; border-radius: 5px;">
	                         		</c:forEach>
	                         		</td>
		                         	</tr>		                    
		                         	</c:if>
		                         	<tr>
		                         		<td colspan="2">${review.review_content }</td>
		                         	</tr>
				                 </c:forEach>
				            	</tbody>
				        	</table>
				        	<!-- <img src="${pageContext.request.contextPath}/review/${review.review_idx}/"+i+" style="width: 70px; height: 70px; border-radius: 12px;"> -->
				        </div>
				    </div>  	
			</div>
			
		    <div class="col-sm-5 mt-5" >
	            <div class="card" style = "box-shadow: rgba(0, 0, 0, 0.05) 0px 2px 20px;">
	                <div class="card-header font">이용요금</div>
	                <div class="card-body font">
	                    <table class="table">
	                        <tbody>
	                            <tr style="line-height:32px;">
	                                <td colspan="3" style="font-size: 15px; text-align: right;">1박 케어 &nbsp&nbsp|&nbsp&nbsp 데이케어 </td>
	                            </tr>
	                            <tr style="line-height:32px;">
	                                <td style="font-size: 15px;">소형견&nbsp(7키로 미만) </td>
	                                <td  colspan="2" style="font-size: 15px; text-align: right;">
	                                	${sitter.sl == '0' ? '예약불가&nbsp' : sitter.sl += '원'} &nbsp&nbsp&nbsp${sitter.ss == '0' ? '예약불가' : sitter.ss += '원'}
	                                </td>
	                            </tr>
	                            <tr style="line-height:32px;">
	                                <td style="font-size: 15px;">중형견&nbsp(7~15키로) </td>
	                                <td style="font-size: 15px; text-align: right;">
	                                	${sitter.ml == '0' ? '예약불가&nbsp' : sitter.ml += '원'} &nbsp&nbsp&nbsp${sitter.ms == '0' ? '예약불가' : sitter.ms += '원'}
	                                </td>
	                            </tr>
	                            <tr style="line-height:32px;">
	                                <td style="font-size: 15px;">대형견&nbsp(15키로 이상) </td>
	                                <td style="font-size: 15px; text-align: right;">
			 							${sitter.ll == '0' ? '예약불가&nbsp' : sitter.ll += '원'} &nbsp&nbsp&nbsp${sitter.ls == '0' ? '예약불가' : sitter.ls += '원'}
			 						</td>
	                            </tr>
	                        </tbody>
	                    </table>
	                </div>
	            </div>
				
				<div class="pt-5"></div>
				
	            <div class="card" style = "box-shadow: rgba(0, 0, 0, 0.05) 0px 2px 20px;">
	                <div class="card-header font">예약 가능 날짜</div>
	                <div class="card-body font">
						<div class="my-calendar">
							<div class="calendar-box">
								<div class="ctr-box ">
									<button type="button" title="prev" class="btn-cal prev"></button>
									<span class="cal-year"></span> &nbsp&nbsp<span class="cal-month"></span> 
									<button type="button" title="next" class="btn-cal next"></button>
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
												<div style="display: flex; flex-direction: row; justify-content: space-between;  margin-left: 15%; margin-right: 15%;">	
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
	            
	            <div class="card" style="z-index: 0; margin-bottom: 100px; box-shadow: rgba(0, 0, 0, 0.05) 0px 2px 20px;">
	                <div class="card-header font">펫시터님 위치<span style="margin-left: 30%;">${sitter.user_addr}</span></div>
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
		
	        <div class="col-sm-7">
				
				</div>
			</div>
		</div>
	<div class="text-center mt-5 p-3 pt-4" style="position: fixed; bottom: 0px; left: 0px; right: 0px; height: 80px; background-color: white; box-shadow: rgba(0, 0, 0, 0.05) 0px -3px 7px; z-index: 2;">
       	<span style="border-radius:12px; background-color: white; display:inline-block; height: 50px;">
       		<c:if test="${sessionScope.s_user.user_idx != sitter.user_idx }">
       		<button type="button" class="btn btn-outline-primary font" style="border-radius:12px; width: 150px; height: 50px; font-size: 20px" onclick="location.href = 'book.do?idx=${sitter.user_idx }'">예약하기</button>
       		<button type="button" class="btn btn-outline-warning font" style="border-radius:12px; width: 150px; height: 50px; font-size: 20px" onclick="joinRoom('${sitter.user_idx}','user')">시터상담</button>
       		</c:if>
       		<c:if test="${sessionScope.s_user.user_idx == sitter.user_idx }">
       		<button type="button" class="btn btn-outline-primary font" style="border-radius:12px; width: 150px; height: 50px; font-size: 20px" onclick="location.href = 'updateProfile.do?user_idx=${sitter.user_idx }'">수정하기</button>
       		</c:if>
       	</span>
    </div>
<%@ include file="/WEB-INF/views/footer.jsp" %>
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
		        trtd += ` data-date="${countDay + 1}" data-fdate="${fullDate}">`;
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
	center: new kakao.maps.LatLng(${sitter.user_y}, ${sitter.user_x}), //지도의 중심좌표.
	level: 3 //지도의 레벨(확대, 축소 정도)
};

var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
</script>
</html>