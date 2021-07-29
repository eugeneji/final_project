<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src='https://code.jquery.com/jquery-3.5.1.min.js'></script>
<style type="text/css">
</style>
</head>
<style>

#cartCheck {
	margin: 0 auto;
}
</style>
<script type="text/javascript">
window.onload = function(){
	showCartList();
	show();
}
function showCartList(){
	
	 $.ajax({
	      url : "getCartList.do",
	      type:"post",
	      success : function(getData){
	    	  showCartCallBack(getData);
	      }
	   });
}
function showCartCallBack(getData){
	var cartList = document.getElementById("cart_list");
		cartList.innerHTML = '<colgroup> <col style="width:150px;"><col style="width:600px;"><col style="width:150px;"><col style="width:300px;"><col style="width:200px;"><col style="width:150px;"></colgroup><tr><th> <input type="checkbox" id="checkAll" checked onclick="allCkControll(this)"> 선택</th><th>상품 정보</th><th>수량</th><th>상품 가격</th><th>할인</th><th>배송비</th></tr>';
	var list = getData.list;
	for(var i =0;i<list.length;i++){
		var cartListTr = document.createElement('tr');
		var html_txt='';
		var unit_totalPrice =list[i].item_price*list[i].cart_unit;
		var ckPrice = list[i].item_price*list[i].cart_unit;
			unit_totalPrice = unit_totalPrice.toLocaleString();
		var itemPrice = list[i].item_price;
			itemPrice = list[i].item_price.toLocaleString();
		
		html_txt+='<td>';
		html_txt+='<input type="checkbox"  id="putTotal" name="putTotal" value="'+list[i].item_idx+'"checked onclick="putCheckData()">';
		html_txt+='</td>';
		html_txt+='   <td style="text-align:left;"><span class="reviewImg1"><img src ="${pageContext.request.contextPath }/itemImg/'+list[i].item_mainimg+'" style="width:100px;height:100px;"></span>';
		html_txt+='<span style="margin-left:40px;">'+list[i].item_name+'</span>';
		html_txt+='</td>';
		html_txt+='<td>';
		html_txt+='<span class="col-2"><input type="text" class="form-control" id="changeUnit'+list[i].item_idx+'" value="'+list[i].cart_unit+'" onchange="Unitchanger('+list[i].item_idx+')"></span>';
		html_txt+='<input type="hidden" id="origin'+list[i].item_idx+'" value="'+list[i].cart_unit+'">';
		html_txt+='</td>';
		html_txt+='<td>';
		html_txt+='<p>'+unit_totalPrice+'</p>';
		html_txt+='<input type="hidden" id="'+list[i].item_idx+'" value="'+ckPrice+'">';
		html_txt+='<span>'+itemPrice+'원  * '+list[i].cart_unit+' 개 </span>';
		html_txt+='</td>';
		html_txt+='<td>';
		html_txt+='0 원';
		html_txt+='</td>';
		html_txt+='<td>3,000';
		html_txt+='</td>';
		cartListTr.innerHTML = html_txt;
		cartList.appendChild(cartListTr);
	}
	putCheckData();
}
function Unitchanger(idx){
	var idKey = 'changeUnit'+idx;
	var updateUnit = document.getElementById(idKey).value;
	var originKey = 'origin'+idx;
	var originUnit = document.getElementById(originKey).value;

	if(isNaN(updateUnit)){
		window.alert('숫자만 입력 가능합니다');
		document.getElementById(idKey).value = originUnit*1;
		return;
	}
	if(updateUnit>20){
		window.alert('최대 20개 까지 담을 수 있습니다.');
		document.getElementById(idKey).value = originUnit*1;
		return;
	}
	
	var jsonData = new Object;
		jsonData.item_idx = idx;
		jsonData.update_unit = updateUnit;
	
		
		$.ajax({ 
		      url :"updateCartUnit.do", 
		      type : 'post', 
		      dataType : 'json', 
		      contentType: 'application/json',
		      data : JSON.stringify(jsonData), 
		      success: function(data){ 
		    	  showCartList();
		      } });
	
	}
function putCheckData(){
	var ck = document.getElementsByName("putTotal");
	var totalPrice = 0;
	var ckCount = 0;
	for(var i=0;i<ck.length;i++){
		if(ck[i].checked){
			var ckv = ck[i].value;
			var hdP = document.getElementById(ckv).value;
			totalPrice += (hdP*1);
			ckCount ++;	
		}
	}
	var checkAll = document.getElementById("checkAll");
	
	if(ckCount==ck.length){
		checkAll.checked = true;
	}else{
		checkAll.checked = false;
	}
	
	var tpvalue = document.getElementById("total_price");
	var paymentValue = document.getElementById("paymentValue");
	var cartCheck_count = document.getElementById("cartCheck_count");
	cartCheck_count.innerHTML = '('+ckCount+' / '+ck.length+')';
	
	tpvalue.innerHTML = totalPrice.toLocaleString();
	paymentValue.value = totalPrice;
}


function allCkControll(allck){
	
	var allCk = allck.checked;
	var ck = document.getElementsByName("putTotal");
	
	if(allCk){
		for(var i=0;i<ck.length;i++){
			ck[i].checked = true;
		}
	}else{
		for(var i=0;i<ck.length;i++){
			ck[i].checked = false;
		}
	}
	putCheckData();
}

function delCart(){
	var ck = document.getElementsByName("putTotal");
	var ckArray = new Array();
	for(var i=0;i<ck.length;i++){
		if(ck[i].checked){
			ckArray.push(ck[i].value);
		}
	}
	
	ckObj = new Object;
	ckObj.itemIdx = ckArray;
	var ckObjString = JSON.stringify(ckObj);
	
	$.ajax({ 
	      url :"delCartList.do", 
	      type : 'post', 
	      dataType : 'json', 
	      contentType: 'application/json',
	      data : ckObjString, 
	      success: function(data){ 
	    	  window.alert(data.msg);
	    	  showCartList();
	      } });
	
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

<body>
	<%@ include file="/WEB-INF/views/header.jsp"%>
	<div class="container" style="padding-top: 150px;font-family: 'Lato', Arial, sans-serif;">
	
		<form name="cartInfo" action="PaymentForm.do" method="post">
			<div class="row" >
				<div class="col-lg-12" id="cartList_div" style="background: white;">
				<p style="font-size: 20px; font-weight: bold; margin-top: 40px;margin-bottom: 10px;">내 장바구니</p>   
					<table id="cart_list"
						class="table table-striped table-bordered table-hover"
						style="background-color: white; margin-top: 50px;">
					</table>
					<div style="padding-top: 30px;  padding-bottom: 50px;"><span id="cartCheck_count"></span>&nbsp;&nbsp;<span><input type="button"
						class="btn  btn-outline-warning" onclick="delCart()" value="선택삭제"></span>
						</div>
				</div>
			</div>
			<div class="row" style="padding-top: 40px;">
				<div id="cartCheck" class="col-md-12" style="background-color: white;">
					
					<div id="cartTotalCost_div" class="border" style="padding-left: 4%; padding-top: 4%; padding-bottom: 4%;">
						<div id="total_price_div">
							<h5 style="">총 상품 가격</h5>
							<h2 id="total_price" style="float: left;">ㅁㅁ</h2>
							<h5 style="margin-left: 30px; margin-top: 15px;">&nbsp;&nbsp;원</h5>
							<input type="hidden" id="paymentValue" name="paymentValue"
								value="0">
						</div>
					</div>
				</div>
			</div>

			<div class="row">
			<div class="col-md-12" style="text-align: center; padding-top: 50px; margin-bottom: 100px;">
			<button type="button" class="btn btn-dark" onclick="javascript:location.href='goShopList.do'">쇼핑 계속하기</button>
			<button type="submit" class="btn btn-success">결제하기</button>
			</div>
			</div>
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
		
	<%@ include file="/WEB-INF/views/footer.jsp"%>
</body>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
	integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
	integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"
	integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF"
	crossorigin="anonymous"></script>
</html>