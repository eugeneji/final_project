<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/ckeditor/ckeditor.js"></script>
	<script src="https://code.jquery.com/jquery-1.11.2.min.js"></script>
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
		showWishList();
		show();
	}
	$(window).scroll(function() { // 스크롤 이벤트가 발생할 때마다 인식

	    // 스크롤이 끝에 닿음을 인식

	   if ( $(window).scrollTop() == $(document).height() - $(window).height() ) {
	      
	       var cp = document.getElementById("cp");
	       var newCp = 1+parseInt(cp.value);
	         cp.value = newCp;
	         showWishList();
	   }
	});
	
	function showWishList() {
		var cp = document.getElementById("cp").value;
		$.ajax({
			url : "getWishList.do",
			data : {"cp": cp},
			type : "post",
			success : function(getData) {
				showWishCallBack(getData);
			}
		});
	}
	function showWishCallBack(getData) {
		var orderList = document.getElementById("orderList");
		var list = getData.wishList;
		var html_txt = '';
		if((list==null||list.length==0) && $('.card').length==0){
			
			html_txt += '<div style="width:80%;height:500px;text-align:center; padding-top:100px;">'
			html_txt += '<div class="" style="margin: 0 auto; text-align:center;">';
			html_txt += '<p style="font-size: 20px; font-weight: bold; margin-top: 40px;margin-bottom: 10px;">위시 리스트가 존재하지 않습니다 !</p>   ';
			html_txt += '<button type="button" class="btn btn-dark" onclick="'+'javascript:location.href='+"'goShopList.do'"+'">쇼핑 계속하기</button>';
			html_txt += '</div>';
			html_txt += '</div>';
			
			
		}else{
			
		
		for (var i = 0; i < list.length; i++) {
			
			html_txt += '<li>';
			html_txt += '<div class="card bg-light mb-12" style="margin-top:15px;">';
		    html_txt += '   <div class="row no-gutters">';
		    html_txt += '      <div class="col-md-4">';
		    html_txt += '         <img src="${pageContext.request.contextPath }/itemImg/'+list[i].item_mainimg+'" style="width:200px;height:200px;" class="card-img" alt="주문 첫 상품">';
		    html_txt += '      </div>';
		    html_txt += '      <div class="col-md-8">';
		    html_txt += '         <div class="card-body">';
		    html_txt += '            <ul class="orderUl">';
		    html_txt += '               <li>';
		    html_txt += '                  <strong>상품 이름:</strong>';
		    html_txt += '                  <span>'+list[i].item_name+'</span>원';
		    html_txt += '               </li>';
		    html_txt += '               <li>';
		    html_txt += '                  <strong>상품 가격:</strong>';
		    html_txt += '                  <span>'+list[i].item_price.toLocaleString();+'</span>원';
		    html_txt += '               </li>';
		     html_txt += '            </ul>';
	         html_txt += '         </div>';
	         html_txt += '      </div>';
	         html_txt += '   </div>';
	         html_txt += '</li>';
		    
			
		}
		}
		orderList.innerHTML += html_txt;
	}

			
	
	function divClose() {
		var allC = document.getElementById("allC");
		allC.style.display = 'none';
		document.getElementById("stockControll").style.display = 'none';
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
	<div class="container" style="padding-top: 150px; min-height: 1000px;" >
	<div class="row">
		<div class="col-sm-12" id="orderList_div">
			<ul id="orderList">
			</ul>
		</div>
</div>

		   <div class="panel-group remote" id="accordion" role="tablist"
      aria-multiselectable="true"
      style="position: fixed; right: 5%; top: 40%; width: 200px;">
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
                  <li>상품목록</li>
                  <li onclick="javascript:location.href='goCartList.do'">장바구니</li>
                  <li onclick="javascript:location.href='orderList.do'">구매내역</li>
                  <li>위시리스트</li>
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
<input type="hidden" id="cp"  value="1" >
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