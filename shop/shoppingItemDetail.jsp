<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
<script src='https://code.jquery.com/jquery-3.5.1.min.js'></script>
<script
   src='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js'></script>
<link rel='stylesheet'
   href='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css' />
<script type="text/javascript"
   src="${pageContext.request.contextPath }/ckeditor/ckeditor.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"/></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.raty.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/img/*"></script>
<link rel="stylesheet" href="jquery.raty.css">
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
.tabBorder {
   padding-top: 15px;
   border-radius: 5px 5px 0px 0px;
}


.popup1 {
	position: fixed;
	background: rgb(245, 245, 245);
	z-index: 10;
	left: 40%;
	top: 40%;
}
.back-to-top {
    cursor: pointer;
    position: fixed;
    bottom: 100px;
    right: 100px;
    display:none;
}

</style>

<!-- ckeditor 사용을 위해 js파일을 연결함 -->

<script type="text/javascript">

window.onload = function(){
	show();
	
}
function changeImg(img){
   var biggerImg = document.getElementById("bigger");
   var selectImg = img.getAttribute("src");
   biggerImg.setAttribute("src",selectImg);
}

$(window).scroll(function() { // 스크롤 이벤트가 발생할 때마다 인식

    // 스크롤이 끝에 닿음을 인식

   if ( $(window).scrollTop() == $(document).height() - $(window).height() ) {
      var infoDiv = document.getElementById("item_info");
      if(infoDiv.style.display == 'none'){
         
      
       var cp = document.getElementById("cp");
       var newCp = 1+parseInt(cp.value);
         cp.value = newCp;
         showReview();
      }
   }
});
onscroll = function() {
   /* var nVScroll = document.documentElement.scrollTop || document.body.scrollTop;
     if(nVScroll > 600){
        $("#scrollMenu").css("position", "fixed"); 
        $("#scrollMenu").css("left", "0px"); 
        $("#scrollMenu").css("top", "0px"); 
        $("#scrollMenu").css("width", "100%"); 
        $("#scrollMenu").css("z-index", "100%"); 
     }
     else $("#scrollMenu").css("position", "relative");*/
     
   /* var lnb = $("#scrollMenu").offset().top;
    var window = $(this).scrollTop();
       
       if(lnb <= window) {
         $("#scrollMenu").addClass("fixed");
       }else{
         $("#scrollMenu").removeClass("fixed");
       }*/
   }
$(window).scroll(function () {
    if ($(this).scrollTop() > 50) {
        $('#back-to-top').fadeIn();
    } else {
        $('#back-to-top').fadeOut();
    }
});

// scroll body to 0px on click
$('#back-to-top').click(function () {
    $('#back-to-top').tooltip('hide');
    $('body,html').animate({
        scrollTop: 0
    }, 800);
    return false;
});

$('#back-to-top').tooltip('show');




function putCart(idx){
   var cart_unit = document.getElementById("cart_unit").value;
   var cart_unit = document.getElementById("cart_unit").value;
   
   var formData = {"cart_unit":cart_unit, "item_idx":idx};
   
    $.ajax({
         url : "insertCart.do",
          data:  formData,
         type:"post",
         success : function(getData){
            cartCallBack(getData);
         }
      });
}
function cartCallBack(getData){
	var msg = getData.msg;
	if(msg=="로그인 후 이용 가능합니다."||msg=="장바구니에 담지 못했습니다."){
		var allC = document.getElementById("allC");
		allC.style.display = '';
   		var cartMsg_div = document.getElementById("cartMsg_div");
	    cartMsg_div.style.display = '';
	    var msgP = document.createElement('p');
	    var cart_msg = document.getElementById("cart_msg");
	    	cart_msg.innerHTML = '';
	    	   var goCartOk = document.getElementById("goCartOk");
	    	   document.getElementById("link").value='login';
	    	   		
   			
   
   		msgP.innerHTML = getData.msg;
   cart_msg.appendChild(msgP);
	}else{
		
	
	var allC = document.getElementById("allC");
		allC.style.display = '';
   var cartMsg_div = document.getElementById("cartMsg_div");
   cartMsg_div.style.display = '';
   
   var cart_msg = document.getElementById("cart_msg");
   	   cart_msg.innerHTML = '';
   var goCartOk = document.getElementById("goCartOk");
   document.getElementById("link").value='goCartList';
   		
     var msgP = document.createElement('p');
          msgP.innerHTML = getData.msg;
          cart_msg.appendChild(msgP);
        

	}
}

function goCart(){
	var link =  document.getElementById("link").value
   location.href=link+".do";
}
function stayHere(){
	var allC = document.getElementById("allC");
		allC.style.display = 'none';
   var cartMsg_div = document.getElementById("cartMsg_div");
   cartMsg_div.style.display = 'none';
   
}


function showReview(){
   
    $('#reviewTap').css('border', 'solid orange');
    $('#reviewTap').css('border-width', '4px 4px 0px 4px');
    $('#reviewTap').css('background', 'white');  
    $('#detailTap').css('border', 'solid rgb(237, 237, 237)');
    $('#detailTap').css('border-width', '4px 4px 1px 4px');
    $('#detailTap').css('background', 'rgb(245,245,245)');
   
   var item_idx = document.getElementById("item_idx").value;
   var sort_option = document.getElementById("sort_option").value;
   var sortVal = document.getElementById("sortVal");
   
   
   var cp = document.getElementById("cp");
if(sort_option != sortVal.value){
   cp.value = 1;
   sortVal.value = sort_option;
   document.getElementById("review_list").innerHTML = '';
   
   }
   var reviewDiv = document.getElementById("item_review");
   var infoDiv = document.getElementById("item_info");
   infoDiv.style.display = 'none';
   reviewDiv.style.display = '';
   $.ajax({
      url : "getItemReviewList.do",
      type : "post",
      data : {
         'item_idx' : item_idx,
         'cp' : cp.value,
         'sort_option':sort_option
      },
      success : function(getData) {
         viewReviewList(getData);
      }
   });
   
}

function viewReviewList(getData){
   var reviewList = getData.reviewList;
   var review_list = document.getElementById("review_list");
   var ook = review_list.innerHTML;
   var yStar = '<i class="fas fa-star" style="color: orange; float: left;"></i>';
   var nStar = '<i class="fas fa-star" style="color: #828282; float: left;"></i>';
   var html_txt = '';
   var imgArr;
   var imgs;
   var yStar = '<i class="fas fa-star" style="color: orange; float: left;"></i>';
   var nStar = '<i class="fas fa-star" style="color: #828282; float: left;"></i>';
   
   if((reviewList.length==0||reviewList==null )&& ook.length==0){
	   html_txt +='<li class="card" style="text-align:left; margin-top:15px; padding-left: 10px;">';
	   html_txt +='	<div class="card-body col-12 p-0">';
	   html_txt +='	<div> 등록된 리뷰가 없습니다.';
	   html_txt +='	</div>'
	   html_txt +='	</div>'
		      html_txt +='</li>';
   }else{
	   
   
   for(var i = 0;i<reviewList.length;i++){
      imgs = reviewList[i].imgs;
       
      console.log(imgs);
      html_txt +='<li class="card" style="text-align:left; margin-top:15px; padding-left: 10px;">';
      html_txt +='	<div style="padding-top:20px;padding-left:10px;"><img src="${pageContext.request.contextPath }/user/'+reviewList[i].user_idx+'/profile.png" style="width: 50px; height: 50px;">&nbsp;&nbsp;<span style="font-weight:bold;">'+reviewList[i].user_email+'<br>'+reviewList[i].review_date+'</span></div>';
      html_txt +='	<div class="card-body col-12 p-0" style="padding-top:20px;padding-left:20px;">';
      html_txt +='		<span style="padding-top:20px;padding-left:20px;">';
      for(var j=1;j<=5;j++){
    	  if(j<=reviewList[i].star_score){
    		  html_txt +=  yStar;
    	  }else{
    		  html_txt += nStar;
    	  }
      }
      html_txt +=' </span><br>';
      if(imgs!=null&&imgs.length!=0){
         imgArr = imgs.split(',');
         for(var j=0; j<imgArr.length;j++){
            html_txt +='<span><img src="${pageContext.request.contextPath }/reviewImg/'+reviewList[i].review_idx+'/'+imgArr[j]+'" style="width:100px;height:100;"></span>';
         }   
      }
      
      html_txt +='		<span> '+reviewList[i].review_content+'</span><br>';
      html_txt +='	</div>'
      html_txt +='</li>';
   }
   }
   review_list.innerHTML += html_txt;
}

function showInfo(){
   
      $('#detailTap').css('border', 'solid orange');
      $('#detailTap').css('border-width', '4px 4px 0px 4px');
      $('#detailTap').css('background', 'white');
      $('#reviewTap').css('border', 'solid rgb(237, 237, 237)');
      $('#reviewTap').css('border-width', '4px 4px 1px 4px');
      $('#reviewTap').css('background', 'rgb(245,245,245)');
   var review_list = document.getElementById("review_list");
   review_list.innerHTML='';
    var cp = document.getElementById("cp");
    var newCp = 1;
      cp.value = newCp;
   var reviewDiv = document.getElementById("item_review");
   var infoDiv = document.getElementById("item_info");
   infoDiv.style.display = '';
   reviewDiv.style.display = 'none';
}
function goPay(idx){
	
	var cart_unit = document.getElementById("cart_unit").value;
	var ip = document.getElementById("ip").value;
	var tp = document.getElementById("goPay");
	
	location.href = 'imPaymentForm.do?item_idx='+idx+'&cart_unit='+cart_unit;
	
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
 function putWish(idx){
    
   
       
    
    $.ajax({
         url : "insertWishInDetail.do",
          data:  {'item_idx':idx},
         type:"post",
         success : function(getData){
            wishCallBack(getData);
         }
  
       });
 }  
 
 function wishCallBack(getData){
		var msg = getData.msg;
		if(msg=="로그인 후 이용 가능합니다."){
			var allC = document.getElementById("allC");
			allC.style.display = '';
	   		var cartMsg_div = document.getElementById("cartMsg_div");
		    cartMsg_div.style.display = '';
		    var msgP = document.createElement('p');
		    var cart_msg = document.getElementById("cart_msg");
		    	cart_msg.innerHTML = '';
		    	   var goCartOk = document.getElementById("goCartOk");
		    	   document.getElementById("link").value='login';
		    	   		
	   			
	   
	   		msgP.innerHTML = getData.msg;
	   cart_msg.appendChild(msgP);
		}else if(msg=="문제가 발생했습니다."){
			window.alert(msg);
			location.reload();
		}else{
		
		var allC = document.getElementById("allC");
			allC.style.display = '';
	   var cartMsg_div = document.getElementById("cartMsg_div");
	   cartMsg_div.style.display = '';
	   
	   var cart_msg = document.getElementById("cart_msg");
	   	   cart_msg.innerHTML = '';
	   var goCartOk = document.getElementById("goCartOk");
	   document.getElementById("link").value='goWishList';
	   		
	     var msgP = document.createElement('p');
	          msgP.innerHTML = getData.msg;
	          cart_msg.appendChild(msgP);
	        
		}
 }
 $(document).ready(function(){
	 
	 $('#star-rating').raty({
		  readOnly:  true,
		  number : parseInt('${item.star_avg}'),
		  start:     2
		  ,path : "${pageContext.request.contextPath }/img/"
		});
	 
 });
 </script>
</head>
<body>
<div class="allC" id="allC" style="display: none;"></div>
   <%@ include file="/WEB-INF/views/header.jsp"%>
   <div class="container " style="padding-top: 150px;">
       <div class="row" style="background: white;">
         <div class="col-md-12 form-row justify-content-center" >
               <!-- 검색 설렉트 -->
               <div style="padding-top: 10px; margin-right: 10px;"
                  class="form-group col-md-2">
                  <select class="form-control" id="cate_select" style="height: 50px;">
                     <option value="1000">전체</option>
                     <c:forEach var="cate" items="${cate }">
                        <c:if test="${cate.level==1 }">
                           <option value="${cate.cate_code }">${cate.cate_name }</option>
                        </c:if>
                     </c:forEach>
                  </select>
               </div>
               <!-- 검색 인풋 +버튼 -->
               <div class="form-group col-md-7">
                  <input id="search_select"
                     class="form-control border-secondary rounded-pill"
                     style="margin-top: 10px;height:50px; padding-left: 30px;"
                     placeholder="검색어를 입력하세요">
               </div>
               <div class="form-group col-md-1">
                  <button class="btn" onclick="searchItem()"
                     style="margin-top: 5px; padding: 0px; width: 60px; height: 60px;">
                     <img src="${pageContext.request.contextPath }/img/search.jpg"
                        alt="검색" style="width: 60px; height: 60px;">
                  </button>
               </div>
         </div>
      </div> 
      <div class="row"
         style="padding-bottom: 50px;padding-top: 50px; background-color: white;">
         <div class="col-lg-4" style="background-color: white;">
            <c:forEach var="cate" items="${cate }">
               <c:if test="${cate.level==1 && item.cate_parent eq cate.cate_code}">
                  <label><strong>${cate.cate_name } ></strong></label>
               </c:if>
            </c:forEach>
            <c:forEach var="cate" items="${cate }">
               <c:if test="${cate.level==2 && item.cate_code eq cate.cate_code}">
                  <label><strong>${cate.cate_name }</strong></label>
               </c:if>
            </c:forEach>
         </div>
      </div>

      <div class="row" style=" text-align:center;">
         <div class="col-lg-6" style=" padding-bottom: 30px;">
         <div class="row">
            <div class="col-lg-12" style="border: 1px; text-align: center;">
               <img id="bigger"
                  src="${pageContext.request.contextPath }/itemImg/${item.item_mainimg }"
                  style="width: 400px; height: 400px;">
            </div>
            </div>
            <div class="row" style="padding-top: 10%;">
            <div class="col-lg-12" style="text-align:center;">
               <ul>
                  <c:if test="${empty thums }"></c:if>
                  <c:forEach var="f" items="${thums }">
                     <li style="list-style-type: none; display: inline;"><img
                        class="smallImg"
                        src="${pageContext.request.contextPath }/itemImg/${path }/${f.name }"
                        style="width: 80px; height: auto;" onclick="changeImg(this)">
                     </li>
                  </c:forEach>
               </ul>
               </div>
            </div>
         </div>
         <div class="col-lg-6  border" style="text-align: left;padding-top:30px; padding-left: 50px;">
            <table class="table">
               <tr>
                  <td style="border: none;"><strong>상품명</strong></td>
               </tr>
               <tr>
                  <td style="border: none;"><h3>&nbsp;${item.item_name }</h3></td>
               </tr>
               <tr>
                  <td style="border: none;"><strong>별점</strong></td>
               </tr>
               <tr>
                  <td style="border: none;">
								
								<div>
								${item.star_avg}
								<span style="width: 75;"></span>
							<c:forEach  var="i" begin="1" end="5" >
							<c:choose>
							<c:when test="${item.star_avg>=i }">
							<i class="fas fa-star" style="color: orange; float: left;"></i>
							</c:when>
							<c:otherwise>
							<i class="fas fa-star" style="color: #828282; float: left;"></i>
							</c:otherwise>
							</c:choose>
							</c:forEach>
								</div>
							  
							    <span>${item.star_total }명 참여</span>
                
                  </td>
               </tr>
               <tr>
                  <td style="border: none;"><strong>가격</strong></td>
               </tr>
               <tr>
                  <td style="border: none;"><h3>
                        &nbsp;
                        <fmt:formatNumber value="${item.item_price }" pattern="#,###" />
                        원
                     </h3> <input type="hidden" id="ip" value="${item.item_price }"> </td>
               </tr>
               <tr>
                  <td style="border: none;"><strong>상품수량</strong></td>
               </tr>
               <tr>
                  <td style="border: none;"><input type="hidden" id="item_idx"
                     name="item_idx" value="${item.item_idx }"> <input
                     style="float: left; margin-right: 10px;"
                     class="form-control col-2" type="number" name="cart_unit"
                     id="cart_unit" value="1">
                     </td>
               </tr>
               <tr>
               <td colspan="2"><button style="float: left; margin-left: 4%;" class="btn btn-outline-primary"
                        onclick="goPay(${item.item_idx })">바로 구매</button>
                        <button style="float: left;margin-left: 4%;" class="btn btn-outline-success"
                        onclick="putCart(${item.item_idx })">장바구니 담기</button>
                        <button style="float: left;margin-left: 4%;" class="btn btn-outline-dark"
                        onclick="putWish(${item.item_idx })">관심상품 등록</button></td>
               </tr>
            </table>
         </div>
      </div>
<input type="hidden" id="sortVal" value="review_idx desc">
      <div class="row" id="scrollMenu" 
         style="text-align: center; margin-top: 50px;">
            <div class="col-lg-6 tabBorder" id="detailTap" onclick="showInfo()"
               style="border: solid orange; border-width: 4px 4px 0px 4px;">
               <label for="editor_admin"><strong>상품 페이지 내용</strong></label>
            </div>
            <div class="col-lg-6 tabBorder" id="reviewTap"
               onclick="showReview()"
               style="border: solid rgb(237, 237, 237);background:rgb(245,245,245); border-width: 4px 4px 1px 4px;">
               <label for="editor_admin"><strong>상품 리뷰</strong></label>
            </div>
            </div>
            <div class="row" style="text-align: center; background-color: white;">
            <div class="col-lg-12" id="item_info"
               style="margin-top: 50px; background-color: white;">${item.item_info }</div>

            <div class="col-lg-12" id="item_review"
               style="display: none; min-height: 700px;">
               <div>
                  <select class="form-control col-2" id="sort_option" onchange="showReview()">
                     <option value="review_idx desc">최신순</option>
                     <option value="star_score desc">별점높은순</option>
                     <option value="star_score asc">별점낮은순</option>
                  </select>
               </div>
               <ul class="list-group"id="review_list" style="width: 70%; margin-left: 15%;">
               </ul>
            </div>
         </div>
   </div>

   <input type="hidden" name="product_name_detail" />
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

   <a id="back-to-top" href="#" class="btn btn-primary btn-lg back-to-top" role="button" title="Click to return on the top page" data-toggle="tooltip" data-placement="left"><span class="glyphicon glyphicon-chevron-up">top</span></a>

   <input type="hidden" id="cp" value="1">
   <%@ include file="/WEB-INF/views/footer.jsp"%>
   <div id="cartMsg_div" class="popup1" style="display: none; width: 500px; height: 200px; text-align: center;">
      <div id="cart_msg" style="padding-top: 70px;"></div>
      <div style="margin-top: 30px;">
      <input type="button" class="btn btn-primary" id="goCartOk" value="확인" onclick="goCart()">
      <input type="button" style="margin-left: 20px;" class="btn btn-outline-dark" id="goCartNo" value="취소" onclick="stayHere()">
      </div>
   </div>
   <input type="hidden" id="link" value="goCartList">
</body>
</html>