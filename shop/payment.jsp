<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src='https://code.jquery.com/jquery-3.5.1.min.js'></script>
<script type="text/javascript"
   src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script src='https://code.jquery.com/jquery-3.5.1.min.js'></script>
<script src='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js'></script>
<link rel='stylesheet' href='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css' />
<!-- daum 도로명주소 찾기 api -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

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
.popup1 {
	position: absolute;
	background: white;
	z-index: 3;
	left: 30%;
	top: 10%;
}
h4{
   margin-top: 50px;
}
table th, td {
	height: 40px;
}
</style>

</head>
<body>
<div class="allC" id="allC" style="display: none;"></div>
<%@ include file="/WEB-INF/views/header.jsp"%>
<div class="container" style="width: 60%; padding-top: 150px;">
   
   <p style="font-size: 20px;  font-weight: bold; margin-top: 40px;margin-bottom: 10px;">주문자 정보</p>
   <div class="card card-body">
      <table>
         <colgroup>
            <col width="13%">
            <col width="auto">
         </colgroup>
         <tr>
            <th>이름</th>
            <td>${s_user.user_name }</td>
         </tr>
         <tr>
            <th>이메일</th>
            <td>${s_user.user_email }</td>
         </tr>
         <tr>
            <th>연락처</th>
            <td>${s_user.user_tel }</td>
         </tr>
      </table>
   </div>
<p style="font-size: 20px;  font-weight: bold; margin-top: 40px;margin-bottom: 10px;">받는 사람 정보</p>   
   <div class="card card-body">
      <table>
         <colgroup>
            <col width="13%">
            <col width="auto">
         </colgroup>
         <tr>
         	<td colspan="2"><a class="btn btn-secondary btn-md" onclick="changeInfo()" style="float: right;">배송 정보 변경</a>
         	</td>
         </tr>
         <tr>
            <th>이름</th>
            <td id="deName" >${s_user.user_name }</td>
         </tr>
         <tr>
            <th>이메일</th>
            <td id="deEmail">${s_user.user_email }</td>
         </tr>
         <tr>
            <th>연락처</th>
            <td id="deTel">${s_user.user_tel }</td>
         </tr>
         <tr>
            <th>배송지</th>
            <td id="deAddr">${s_user.user_addr }</td>
         </tr>
         <tr>
            <th>상세주소</th>
            <td id="deDeAddr">${s_user.user_addr_detail }</td>
         </tr>
      </table>
   </div>
   
   
   
   
   
   
   
   
   
 <p style="font-size: 20px; font-weight: bold; margin-top: 40px;margin-bottom: 10px;">주문 상품 정보</p>
   <div class="card card-body">
      <table>
         <c:forEach var="item" items="${list }">
            <tr>
               <td><span style="font-weight: bold;">${item.item_name }</span>&nbsp;&nbsp;${item.cart_unit }개
                  <input type="hidden" name="cartIdxs" value="${item.cart_idx }"> 
                  <input type="hidden" name="cartItemIdxs" value="${item.item_idx }">
                  <input type="hidden" name="cartUnits" value="${item.cart_unit }">
               </td>
            </tr>
         </c:forEach>
      </table>
   </div>
   <br>
   <hr>
   <p style="font-size: 20px; font-weight: bold; margin-top: 40px;margin-bottom: 10px;">결제 정보</p>
   <div class="card card-body">
      <table>
         <colgroup>
            <col width="13%">
            <col width="auto">
         </colgroup>
         <tr>
            <th>총 결제 금액</th>
            <td colspan="2"><h4 style="margin-bottom: 25px;"><fmt:formatNumber type="number" maxFractionDigits="3" value="${paymentPrice}"></fmt:formatNumber><span>&nbsp;원</span></h4>
            
            </td>
         </tr>
      </table>
   </div>
   
   <div class="form-row justify-content-center" style="margin-top: 25px;padding-bottom: 100px;">
      <input type="button" class="btn btn-primary btn-lg" value="결제하기" onclick="a2()">
   </div>
</div>
<form>
   <input type="hidden" id="userName" value="${s_user.user_name }"> 
   <input type="hidden" id="userID" value="${s_user.user_email }"> 
   <input type="hidden" id="userTel" value="${s_user.user_tel }"> 
   <input type="hidden" id="userAddr" value="${s_user.user_addr }"> 
   <input type="hidden" id="userDeAddr" value="${s_user.user_addr_detail }"> 
   <input type="hidden" id="totalPrice" value="${paymentPrice }">
</form>


<div class=" popup1" id="chgI" style="display: none;">
<p style="font-size: 20px; font-style: italic; font-weight: bold; margin-top: 40px;margin-bottom: 10px;">배송지 정보 입력</p>
      <table class="table">
         <colgroup>
            <col width="50%">
            <col width="auto">
         </colgroup>
         <tr>
            <th>받는 사람</th>
            <td><input type="text" id="chName" value="${s_user.user_name }"></td>
         </tr>
         <tr>
            <th>받을 이메일</th>
            <td><input type="text" id="chEmail" value="${s_user.user_email }"></td>
         </tr>
         <tr>
            <th>받을 연락처</th>
            <td><input type="text" id="chTel" value="${s_user.user_tel }"> 
            </td>
         </tr>
         <tr>
            <th>받을 주소</th>
            <td><input type="text" id="chAddr" value="${s_user.user_addr }">
            <button type="button" class="btn btn-default"
               onclick="execPostCode();">
               <i class="fa fa-search"></i> 우편번호 찾기
            </button>
            </td>
         </tr>
         <tr>
            <th>상세 주소</th>
            <td><input type="text" id="chDeAddr" value="${s_user.user_addr_detail }"></td>
         </tr>
         <tr>
          <td colspan="2" style="text-align:  center;">
          <input type="button" class="btn btn-primary" value="적용" onclick="goChangeInfo()">
          <input type="button" class="btn btn-outline-dark " value="닫기" onclick="divClose()">
          </td>
         </tr>
      </table>
   </div>


<script type="text/javascript">
function changeInfo(){
	document.getElementById("allC").style.display = '';
	document.getElementById("chgI").style.display = '';
	
}
function goChangeInfo(){
	var name = document.getElementById("deName");
	var email = document.getElementById("deEmail");
	var tel = document.getElementById("deTel");
	var addr = document.getElementById("deAddr");
	var deAddr = document.getElementById("deDeAddr");
	
	var cName = document.getElementById("chName").value;
	var cEmail = document.getElementById("chEmail").value;
	var cTel = document.getElementById("chTel").value;
	var cAddr = document.getElementById("chAddr").value;
	var cDeAddr = document.getElementById("chDeAddr").value;
	
	name.innerHTML = cName;
	email.innerHTML = cEmail;
	tel.innerHTML = cTel;
	addr.innerHTML = cAddr;
	deAddr.innerHTML = cDeAddr;
	var allC = document.getElementById("allC");
	allC.style.display = 'none';
	document.getElementById("chgI").style.display = 'none';
	
}
function divClose() {
	var allC = document.getElementById("allC");
	allC.style.display = 'none';
	document.getElementById("chgI").style.display = 'none';
}
function a2(){
	
	var name = document.getElementById("deName").innerHTML;
	var email = document.getElementById("deEmail").innerHTML;
	var tel = document.getElementById("deTel").innerHTML;
	var addr = document.getElementById("deAddr").innerHTML;
	var deAddr = document.getElementById("deDeAddr").innerHTML;
	
	var totalPrice = document.getElementById("totalPrice").value;
	ckObj = new Object;
	ckObj.totalPrice = totalPrice;
	ckObj.user_name = name;
	ckObj.user_email = email;
	ckObj.user_tel = tel;
	ckObj.user_addr = addr;
	ckObj.user_addr_detail = deAddr;
	var ckObjString = JSON.stringify(ckObj);
	
	$.ajax({ 
	      url :"a2.do", 
	      type : 'post', 
	      dataType : 'json', 
	      contentType: 'application/json',
	      data : ckObjString, 
	      success: function(data){ 
	    		    	  
	    	  IMP.init('imp67624609');

	    	  IMP.request_pay({
	    	      pg : 'inicis', // version 1.1.0부터 지원.
	    	      pay_method : 'card',
	    	      merchant_uid : 'merchant_' + new Date().getTime(),
	    	      name : data.user.user_name,
	    	      amount : totalPrice, //판매 가격
	    	      buyer_email : data.user.user_email,
	    	      buyer_name : data.user.user_name,
	    	      buyer_tel : data.user.user_tel,
	    	      buyer_addr : data.user.user_addr,
	    	      buyer_postcode : data.user.user_addr_detail
	    	  }, function(rsp) {
	    	      if ( rsp.success ) {
	    	          var msg = '결제가 완료되었습니다.';
	    	          msg += '고유ID : ' + rsp.imp_uid;
	    	          msg += '상점 거래ID : ' + rsp.merchant_uid;
	    	          msg += '결제 금액 : ' + rsp.paid_amount;
	    	          msg += '카드 승인번호 : ' + rsp.apply_num;
	    	          alert(msg);
	    	          removeCartAndInsetOrder();
	    	      } else {
	    	    	  window.alert(rsp.buyer_email);
	    	          var msg = '결제에 실패하였습니다.';
	    	          msg += '에러내용 : ' + rsp.error_msg;
	    	          alert(msg);
	    	      }
	    	      
	    	  });
	      } });
	
}

function removeCartAndInsetOrder(){
	var idxs = document.getElementsByName("cartIdxs");
	var units = document.getElementsByName("cartUnits");
	var itemIdxs = document.getElementsByName("cartItemIdxs");
	var totalPrice = document.getElementById("totalPrice").value;
	var userID = document.getElementById("userID").value;
	
	
	var userName = document.getElementById("deName").innerHTML;
	var userTel = document.getElementById("deTel").innerHTML;
	var userAddr =  document.getElementById("deAddr").innerHTML;
	var userAddrDe = document.getElementById("deDeAddr").innerHTML;
	var totalPrice = document.getElementById("totalPrice").value;
	
	var ciArray = new Array();
	for(var i = 0; i<idxs.length;i++){
		var cartObj = new Object;
		cartObj.cart_idx = idxs[i].value;
		cartObj.item_idx = itemIdxs[i].value;
		cartObj.cart_unit = units[i].value;
		ciArray.push(cartObj);
	}
	endObj = new Object;
	endObj.cartDTOs = ciArray;
	endObj.userName = userName;
	endObj.userID = userID;
	endObj.userTel = userTel;
	endObj.userAddr = userAddr;
	endObj.userAddrDe = userAddrDe;
	endObj.totalPrice = totalPrice;
	var endObjString = JSON.stringify(endObj);
	window.alert(endObjString);
	//카트idx넣어두기까지함
	$.ajax({ 
	      url :"removeCartAndInsetOrder.do", 
	      type : 'post', 
	      dataType : 'json', 
	      contentType: 'application/json',
	      data : endObjString, 
	      success: function(data){ 
	    	  window.alert(data.msg);
	    	  var aMsg = '<a href="orderManageForm.do">'+'${sessionScope.s_user.user_email}'+'님으로부터 주문이 들어왔습니다.'+'</a>';
	    	  send('alarm',2,aMsg);
	    	  location.href = "orderList.do";
	      } });
	
}



function execPostCode() {
    new daum.Postcode({
        oncomplete: function(data) {
           // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

           // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
           // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
           var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
           var extraRoadAddr = ''; // 도로명 조합형 주소 변수

           // 법정동명이 있을 경우 추가한다. (법정리는 제외)
           // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
           if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
               extraRoadAddr += data.bname;
           }
           // 건물명이 있고, 공동주택일 경우 추가한다.
           if(data.buildingName !== '' && data.apartment === 'Y'){
              extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
           }
           // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
           if(extraRoadAddr !== ''){
               extraRoadAddr = ' (' + extraRoadAddr + ')';
           }
           // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
           if(fullRoadAddr !== ''){
               fullRoadAddr += extraRoadAddr;
           }

           // 우편번호와 주소 정보를 해당 필드에 넣는다.
           console.log(data.zonecode);
           console.log(fullRoadAddr);
        /*      var a = console.log(data.zonecode);
           var b = console.log(fullRoadAddr);
           
           if(a == null || b = null){
              alert("주소를 확인하세요.");
              return false;
           }   */
           
           document.getElementById("chDeAddr").value = data.zonecode;
           document.getElementById("chAddr").value = fullRoadAddr;
       /*    $("[name=mem_oaddress]").val(data.zonecode);
           $("[name=mem_address]").val(fullRoadAddr);
           
           document.getElementById('mem_oaddress').value = data.zonecode; //5자리 새우편번호 사용
           document.getElementById('mem_address').value = fullRoadAddr;
           */
           //document.getElementById('mem_detailaddress').value = data.jibunAddress; 
       }
    }).open();
}

</script>
<%@ include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>