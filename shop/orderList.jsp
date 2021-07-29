<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/ckeditor/ckeditor.js"></script>
	<style type="text/css">
	.allC{
position:fixed;
	width:100%;
	height:100%;
	top:0px;
	background-color: black;
	opacity: 0.7;
	z-index: 2;
}
.writePopup{
position: absolute;
	top: 30%;
	left: 20%;
	background: white;
	z-index: 3;
}
.popup1 {
	position: absolute;
	background: white;
	z-index: 3;
	left: 30%;
	top: 10%;
}
ul {
   list-style: none;
   padding-bottom: 5px;
}

li {
   padding-top: 10px;
}

li>strong
{
   padding-bottom: 5px;
}
table th{
background: rgb(245,245,245);
}
.table11 th {
text-align: center;
background: rgb(245,245,245);
}
.orderUl li{
padding-top:10px; 
}
	</style>
<script>
	window.onload = function() {
		showOrderList();
		show();
	}

	function showOrderList() {
		$.ajax({
			url : "getOrderList.do",
			type : "post",
			success : function(getData) {
				showOrderCallBack(getData);
			}
		});
	}
	function showOrderCallBack(getData) {
		var orderList = document.getElementById("orderList");
		var orderListli = document.createElement('li');
		orderList.innerHTML = '';
		var list = getData.list;
		var html_txt = '';
		if(list==null||list.length==0){
			html_txt += '<div style="width:80%;height:500px;text-align:center; padding-top:100px;">'
			html_txt += '<div class="" style="margin: 0 auto; text-align:center;">';
			html_txt += '<p style="font-size: 20px; font-weight: bold; margin-top: 40px;margin-bottom: 10px;">주문 목록이 존재하지 않습니다 !</p>   ';
			html_txt += '<button type="button" class="btn btn-dark" onclick="'+'javascript:location.href='+"'goShopList.do'"+'">쇼핑 계속하기</button>';
			html_txt += '</div>';
			html_txt += '</div>';
			
		}else{
			
		
		for (var i = 0; i < list.length; i++) {
			
			
			html_txt += '<div class="card bg-light mb-12" style="margin-top:15px;">';
			html_txt += '   <div class="card-header">'+list[i].item_name+' 외 '+list[i].order_item_count+'개 상품 주문';
			html_txt += '      <span onclick="stateUpdateForm('+list[i].order_idx+')" style="float: right;">더보기</span>';
			html_txt += '   </div>';
		    html_txt += '   <div class="row no-gutters">';
		    html_txt += '      <div class="col-md-4">';
		    html_txt += '         <img src="${pageContext.request.contextPath }/itemImg/'+list[i].item_mainimg+'" style="width:200px;height:200px;" class="card-img" alt="주문 첫 상품">';
		    html_txt += '      </div>';
		    html_txt += '      <div class="col-md-8">';
		    html_txt += '         <div class="card-body">';
		    html_txt += '            <ul class="orderUl">';
		    html_txt += '               <li>';
		    html_txt += '                  <strong>총 주문 금액:</strong>';
		    html_txt += '                  <span>'+list[i].user_totalpay.toLocaleString();+'</span>원';
		    html_txt += '               </li>';
		    html_txt += '               <li>';
		    html_txt += '                  <strong>주문 일자:</strong>';
		    html_txt += '                  <span>'+list[i].order_date+'</span>';
		    html_txt += '               </li>';
		    html_txt += '               <li>';
		    html_txt += '                  <strong>주문상태:</strong>';
		    html_txt += '                  <span>'+list[i].order_state+'</span>';
		    html_txt += '               </li>';
			  
		         
		       
		    if (list[i].order_state == '결제완료' || list[i].order_state == '상품준비중') {
				 html_txt += '         <li>';
	               html_txt += '            <button onclick="orderCancel('+list[i].order_idx+')" class="btn btn-outline-info">주문취소</button>';
	               html_txt += '         </li>';

			} else {
				if (list[i].order_state == '취소요청') {
					 html_txt += '         <li>';
		               html_txt += '            <strong>주문 취소 승인 대기 중</strong>';
		               html_txt += '         </li>';

				} else if (list[i].order_state == '배송완료') {
					  html_txt += '         <li>';
		               html_txt += '            <button onclick="selectReview('+list[i].order_idx+')" class="btn btn-outline-info">리뷰쓰기</button>';
		               html_txt += '         </li>';

				}
			}
		    
		     html_txt += '            </ul>';
	         html_txt += '         </div>';
	         html_txt += '      </div>';
	         html_txt += '   </div>';
	         html_txt += '</div>';

		    
			
		}
		}
		orderListli.innerHTML = html_txt;
		orderList.appendChild(orderListli);
	}

			
	function selectReview(idx) {
		$.ajax({
			url : "selectReview.do",
			type : "post",
			data : {
				'order_idx' : idx
			},
			success : function(getData) {
				reviewWrite(getData);
			}
		});
	}
	
	function reviewWrite(getData){
		var list = getData.list;
		var radioTb = document.getElementById("itemRadio");
		var radio_txt = '<tr>';
			radio_txt += '<th colspan="2" style="text-align:center;">리뷰 대상</th>'
				radio_txt += '</tr>';
				radio_txt += '<tr>';
			radio_txt += '<td colspan="2" style="text-align:center;">'
		for(var i=0;i<list.length;i++){
			radio_txt += '<div class="form-check" data-toggle="buttons">';
			radio_txt += '<label class="btn"> <input type="radio" value="'+list[i].item_idx+'" name="item_idx">'+list[i].item_name+'</label> ';
			radio_txt += '</div>';
		}
		radio_txt += '</td>';
		radio_txt += '</tr>';
		var allC = document.getElementById("allC");
		allC.style.display = '';
		document.getElementById("reviewDiv").style.display='';
		radioTb.innerHTML = radio_txt;		
	
	}
	function divClose() {
		var allC = document.getElementById("allC");
		allC.style.display = 'none';
		document.getElementById("stockControll").style.display = 'none';
	}
	
	function closeReviewWrite(){
		document.getElementById("reviewDiv").style.display='none';
		var allC = document.getElementById("allC");
		allC.style.display = 'none';
	}
	
	function orderCancel(idx) {
		if (window.confirm('취소 요청을 한 뒤 되돌릴 수 없습니다. 해당 주문을 정말 취소하시겠습니까?')) {

			$.ajax({
				url : "orderCancel.do",
				type : "post",
				data : {
					'order_idx' : idx
				},
				success : function(msgData) {
					window.alert(msgData.msg);
					var aMsg = '<a href="orderManageForm.do">'+'${sessionScope.s_user.user_email}'+'님으로부터 주문 취소가 들어왔습니다.'+'</a>';
			    	  send('alarm',2,aMsg);
					showOrderList();
				}
			});

		}
	}
	
	function goWrite(){
		//데이터 보내는 법 바꿔서 에디터 값 보내기
		document.getElementById("review_content").value = CKEDITOR.instances.review_content_s.getData();
	//  var formdata = $("#reviewForm").serialize();
		var formData = new FormData($("#reviewForm")[0])  
		//     window.alert(formdata);
		 //    window.alert(CKEDITOR.instances.review_content_s.getData());
		   $.ajax({
		      url : "shopReviewWrite.do",
		       data:  formData,
		       contentType:false,
		       processData:false,
		      type:"post",
		      success : function(getData){
		         window.alert(getData.msg);
		         document.getElementById("reviewDiv").style.display='none';
		 		var allC = document.getElementById("allC");
		 		allC.style.display = 'none';
		      }
		      
		   });
	}
	
	function setThumbnail(event) {
	    var uploadWrap = event.target.parentNode; 
	    //이벤트 대상자의 부모
	          var reader = new FileReader();

	           reader.onload = function(event) {
	                var newImg = document.createElement("img");
	                uploadWrap.appendChild(newImg);
	                newImg.setAttribute("src", event.target.result);
	                newImg.setAttribute("width", 200);
	                newImg.setAttribute("class", "pre_img");
	        }; 
	        reader.readAsDataURL(event.target.files[0]);
		
	}
	
	function stateUpdateForm(idx) {

		$.ajax({
			url : "stateUpdateForm.do",
			type : "post",
			data : {
				'order_idx' : idx
			},
			success : function(getData) {
				stateTableCallBack(getData);
			}
		});

	}

	function stateTableCallBack(getData) {
		var allC = document.getElementById("allC");
		allC.style.display = '';
		var master = getData.master;
		var details = getData.details;
		document.getElementById("stockControll").style.display = '';
		var order_idx = document.getElementById("order_idx");
		var user_name = document.getElementById("user_name");
		var user_email = document.getElementById("user_email");
		var user_addr = document.getElementById("user_addr");
		var user_tel = document.getElementById("user_tel");
		var user_totalpay = document.getElementById("user_totalpay");
		var order_date = document.getElementById("order_date");
		var order_state = document.getElementById("order_state");

		order_idx.innerHTML = master.order_idx;
		user_name.innerHTML = master.user_name;
		user_email.innerHTML = master.user_email;
		user_addr.innerHTML = master.user_addr;
		user_tel.innerHTML = master.user_tel;
		user_totalpay.innerHTML = master.user_totalpay.toLocaleString()+"  원";
		order_date.innerHTML = master.order_date;
		order_state.innerHTML = master.order_state;

		var detailTb = document.getElementById("detailList");
		detailTb.innerHTML = '';
		var html_txt = '';
		for (var i = 0; i < details.length; i++) {
			html_txt += '<tr>';
			html_txt += '<td>'
					+ details[i].item_name
					+ '<input type="hidden" name="item_idx" value="'+details[i].item_idx+'"></td>';
			html_txt += '<td>'
					+ details[i].item_price.toLocaleString()+'  원'
					+ '<input type="hidden" name="item_price" value="'+details[i].item_price+'"></td>';
			html_txt += '<td name="detail_unit">' + details[i].detail_unit
					+ '   개</td>';
			html_txt += '</tr>';
		}

		detailTb.innerHTML = html_txt;

	}
	function show(){
		   $.ajax({
		      url : "lastCookie.do",
		      type:"post",
		      success : function(getData){
		         lastCookieCallBack(getData);
		      }
		   });
		   

		}
		function lastCookieCallBack(getData){
			 var last = getData.last;
		     var lastList = document.getElementById("lastList");
		     
		     var last_txt = '';
		     if(last==null||last.length==0){
		        last_txt += '<li>';
		        last_txt += '   <p>일치하는 정보가 없습니다.</p>';
		        last_txt += '</li>';
		     }else{
		           for(var i = 0; i<last.length; i++){
		          	 var l_name = last[i].item_name.length>5?last[i].item_name.substr(0,5)+'...':last[i].item_name;
		                   
		              last_txt +='<li onclick="showItemDetail('+last[i].item_idx+')">';
		              last_txt +='<img src ="${pageContext.request.contextPath }/itemImg/'+last[i].item_mainimg+'"  style="width: 50px; align-self: center;" alt="" />';
		              last_txt +='<h5>'+l_name+'</h5>';
		              last_txt +='</li>';
		              
		           }
		     }
		     lastList.innerHTML = last_txt;
			
		}
</script>

</head>
<body>
<div class="allC" id="allC" style="display: none;"></div>
<%@ include file="/WEB-INF/views/header.jsp" %>
	<div class="container" style="padding-top: 150px;">
	<div class="row">
		<div class="col-sm-12" id="orderList_div">
			<ul id="orderList">
			</ul>
		</div>
</div>
		<div id="reviewDiv" class="writePopup" style="display: none;">
		<form name="reviewForm" id="reviewForm" method="post" enctype="multipart/form-data">
			<table class="table" style="margin: 0 auto;">
				<caption>생생한 리뷰를 작성해주세요!</caption>
				<thead id="itemRadio">
				</thead>
				<tbody>
					<tr>
						<th>별점</th>
						<td> 
						<fieldset class="starability-basic"> 
    <input type="radio" id="rate5" name="star_score" value="1" />
    <label for="rate5" title="Amazing">5 stars</label>

    <input type="radio" id="rate4" name="star_score" value="2" />
    <label for="rate4" title="Very good">4 stars</label>

    <input type="radio" id="rate3" name="star_score" value="3" />
    <label for="rate3" title="Average">3 stars</label>

    <input type="radio" id="rate2" name="star_score" value="4" />
    <label for="rate2" title="Not good">2 stars</label>

    <input type="radio" id="rate1" name="star_score" value="5" />
    <label for="rate1" title="Terrible">1 star</label>
  </fieldset>
						</td>
					</tr>
					<tr>
						<th>사진 등록</th>
						<td>
						<input type="file" name="review_img"
							id="product_main_image" onchange="setSubThumbnail(event)" multiple="multiple">
						</td>
					</tr>
					<tr>
						<td colspan="2">
						<textarea id="review_content_s" name="review_content_s" rows="10" cols="20" class="ckeditor"></textarea>
						<script type="text/javascript">
							CKEDITOR
									.replace(
											'review_content_s',
											{
												filebrowserImageUploadUrl : '${pageContext.request.contextPath}/itemInfoImgUpload.do'
											});
						</script><input type="hidden" id="review_content" name="review_content" value=""> </td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="2" style="text-align: center; "><span><button type="button" class="btn btn-primary btn-lg" onclick="goWrite()">작성</button></span>
							<span style="padding-left: 20px;"><button type="button" class="btn btn-dark btn-lg" onclick="closeReviewWrite()">닫기</button></span></td>
					</tr>
				</tfoot>
			</table>
			</form>
		</div>
		   <div class="panel-group remote" id="accordion" role="tablist"
      aria-multiselectable="true"
      style="position: fixed; right: 0; top: 40%; width: 200px;">
      <!-- 하나의 item입니다. data-parent 설청과 href 설정만 제대로 하면 문제없이 작동합니다. -->
      <div class="panel panel-default form-row justify-content-center">
         <div class="panel-heading" role="tab">
            <a role="button" data-toggle="collapse" data-parent="#accordion"
               href="#collapse1" aria-expanded="false" style="width: 150px;"
               class="btn btn-outline-dark"> My Shopping ▽</a>
         </div>
         <div id="collapse1" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body" style="padding-top: 10px; width: 140px;">
               <ul>
                  <li onclick="javascript:location.href='goShopList.do'">상품목록</li>
                  <li onclick="javascript:location.href='goCartList.do'">장바구니</li>
                  <li onclick="javascript:location.href='orderList.do'">구매내역</li>
                  <li onclick="javascript:location.href='goWishList.do'">위시리스트</li>
               </ul>
            </div>
         </div>
      </div>
      <!-- -->
      <!-- 하나의 item입니다. -->
      <div class="panel panel-default form-row justify-content-center" style="margin-top: 20px;">
         <div class="panel-heading" role="tab">
            <a role="button" data-toggle="collapse" data-parent="#accordion"
               href="#collapse2" aria-expanded="false" style="width: 150px;"
               class="btn btn-outline-dark"> 최근 본 상품 ▽</a>
         </div>
         <div id="collapse2" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
               <ul id="lastList" style="padding-top: 20px; width: 140px;">
               </ul>
            </div>
         </div>
      </div>
   </div>
		
		
		<div class="container popup1" id="stockControll"
			style="display: none; position: absolute; left: 20%; top: 5%;">
			<p style="font-size: 20px; font-weight: bold; margin-top: 40px;margin-bottom: 10px;">주문서 상세보기</p>
			<table class="table table-bordered table-hover trtb">
				<colgroup>
					<col width="20%">
					<col width="auto">
				</colgroup>
				<caption>주문 정보</caption>
				<tr>
					<th><label><strong>주문 번호</strong></label></th>
					<td id="order_idx"></td>
				</tr>
				<tr>
					<th><label><strong>주문자</strong></label></th>
					<td id="user_name"></td>
				</tr>
				<tr>
					<th><label><strong>주문자 이메일</strong></label></th>
					<td id="user_email"></td>
				</tr>
				<tr>
					<th><label><strong>배송지</strong></label></th>
					<td id="user_addr"></td>
				</tr>
				<tr>
					<th><label><strong>주문자 연락처</strong></label></th>
					<td id="user_tel"></td>
				</tr>
				<tr>
					<th><label><strong>결제 총액</strong></label></th>
					<td id="user_totalpay"></td>
				</tr>
				<tr>
					<th><label><strong>결제일</strong></label></th>
					<td id="order_date"></td>
				</tr>
			</table>
			<table class="table table-bordered table-hover table11">
				<colgroup>
					<col width="20%">
					<col width="auto">
				</colgroup>
				<caption>주문 상품 목록</caption>
				<thead>
					<tr>
						<th>상품 이름</th>
						<th>상품가격</th>
						<th>주문 수량</th>
					</tr>
				</thead>
				<tbody id="detailList">
				</tbody>
				<tfoot>
					<tr>
						<th><label><strong>상품 상태</strong></label></th>
						<td id="order_state" colspan="3"></td>
					</tr>
					<tr>
						<td colspan="4" style="text-align: center;"><input type="button" class="btn btn-primary" value="적용"
							onclick="orderManage()"> <input type="button" class="btn btn-dark" value="닫기"
							onclick="divClose()"></td>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
 <link rel="stylesheet" href="${pageContext.request.contextPath }/css/starability-all.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
	integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
	integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
	integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"
	integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-1.11.2.min.js"></script>
</html>