<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
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
<style>
body {
   padding: 60px 0;
}

.affix {
   top: 100px;
   left: 100px;
}

.affix-bottom {
   position: absolute;
}



input {
   outline: 0;
}

button {
   outline: 0;
}

.panel-title {
   font-size: 25px;
}

#kindOfBtn>button {
   margin-right: 2%;
}

#kindOfComb>div {
   float: left;
   margin-right: 2%;
}

.card {

background:white;
   float: left;
   width: 30%;
   height: 500px;
   margin-left: 3%;
   margin-top: 3%;
   padding-top: 15px;
}
.card:hover{
box-shadow: 0 0 10px rgba(0, 0, 0, 0.35);}
.card img {
   height: 50%;
   width: auto;
}

/*
.nextCateCl {
.remoteUnit{
box-shadow: 0 0 10px rgba(0, 0, 0, 0.35);
}
   position: absolute;
   margin-top: 50px;
}*/

.hamMenuCl {
   display: none;
   position: absolute;
   width: 150px;
   background: gray;
   padding-top: 20px;
   padding-bottom: 10px;
   border-radius: 5%;
   list-style: disc;
}

.hamMenuCl li {
   margin-bottom: 10px;
}

.navBtn {
   background: white;
   border-radius: 10px;
   color: bule;
   margin-bottom: 5px;
   font-size: 20px;
   margin-right: 5px;
   font-family: 'Jua', sans-serif;
}

.back-to-top {
   cursor: pointer;
   position: fixed;
   bottom: 100px;
   right: 100px;
   display: none;
   
}

.navBtn:hover {
   background-color: #c8ddff
}
</style>

<script type="text/javascript">

window.onload = function(){
      show();
}

$(window).scroll(function() { // 스크롤 이벤트가 발생할 때마다 인식

    // 스크롤이 끝에 닿음을 인식

   if ( $(window).scrollTop() == $(document).height() - $(window).height() ) {
      
       var cp = document.getElementById("cp");
       var newCp = 1+parseInt(cp.value);
         cp.value = newCp;
         show();
   }
});
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

/*$('#back-to-top').tooltip('show');*/

/*
 * 기능: 햄버거 버튼 클릭 시 메뉴 보여주기
 */
function btnHamClick()
{
   if( $('#hamMenu').css('display') == 'none' )
   {
      $('#hamMenu').css('display', 'block');
   }
   else
   {
      $('#hamMenu').css('display', 'none');
   }
}

//하위카테고리 생성
function clickParentCate(code){
   
   var childCate = document.getElementById("childCate");
   childCate.innerHTML = '';
   var CodeList = new Array();
   CodeList = JSON.parse('${jscate}');
   
   var html_txt = '' ;
   
   for(var i=0;i<CodeList.length;i++){
      if(CodeList[i].cate_parent==code && code != 1000){
         html_txt += '<li onclick="clickChildCate('+ CodeList[i].cate_code+')" style="float: left; margin-left: 30px;">';
         html_txt += CodeList[i].cate_name;
         html_txt += '</li>';
      }
    }
   
   childCate.innerHTML = html_txt;
   search_date_mod_bycate(code);
   show();
}

function clickChildCate(code){
   search_date_mod_bycate(code);
   show();
}
//카테고리를 통해 이동하기 전 조건 초기화
function search_date_mod_bycate(code){
   var cate_code = document.getElementById("cate_code");
   var search_option = document.getElementById("search_option");
   var sort_option = document.getElementById("sort_option");
   var cp = document.getElementById("cp");
   cp.value = 1;
   cate_code.value = code;
   search_option.value = '';
   var cardList = document.getElementById("cardList");
   cardList.innerHTML = "";
   sort_option.value = 'item_idx';
}



function searchItem(){
      var cate_code = document.getElementById("cate_code");
      var search_option = document.getElementById("search_option");
      var sort_option = document.getElementById("sort_option");
      var cate_select = document.getElementById("cate_select").value;
      var search_select = document.getElementById("search_select").value;
      var cp = document.getElementById("cp");
     cp.value = 1;
      cate_code.value = cate_select;
      search_option.value = search_select;
      sort_option.value = "item_idx";
      var cardList = document.getElementById("cardList");
      cardList.innerHTML = "";
      show();
}

function sortItem(op){
   var cp = document.getElementById("cp");
     cp.value = 1;
   var cardList = document.getElementById("cardList");
      cardList.innerHTML = "";
      var sort_option = document.getElementById("sort_option");
      sort_option.value = op.value;
      show();
}
   
   
function show(){
       var data = $("form[name=search_data]").serialize();
       
      $.ajax({
         url : "shopitemList.do",
          data:  data,
         type:"post",
         success : function(getData){
            shopItemListCallBack(getData);
         }
      });
      

}
 function abc(t){
    
    if(t.checked){
       
    
    $.ajax({
         url : "insertWish.do",
          data:  {'item_idx':t.value},
         type:"post",
         success : function(getData){
            wishCallBack(getData);
         }
      });
    }else{
       $.ajax({
            url : "deleteWish.do",
             data:  {'item_idx':t.value},
            type:"post",
            success : function(getData){
       
    }
       });
 }  
 }
function shopItemListCallBack(getData){
         var list = getData.list;
         var last = getData.last;
         var cardList = document.getElementById("cardList");
         var lastList = document.getElementById("lastList");
         var html_txt = '';
         var yStar = '<i class="fas fa-star" style="color: orange; float: left;"></i>';
         var nStar = '<i class="fas fa-star" style="color: #828282; float: left;"></i>';
//         var nStar = '<i class="far fa-star"></i>';
         if( (list==null||list.length==0) && $('.card').length==0 ){
              html_txt += '<div style="width:100;text-align:center;">';
             html_txt += '   <p>일치하는 정보가 없습니다.</p>';
             html_txt += '</div>';
         }else{
               for(var i = 0; i<list.length; i++){

                     var price = list[i].item_price;
                       price = price.toLocaleString();
                    var cked = list[i].wish > 0 ? "checked" : " ";
                    var aced = list[i].wish > 0 ? "active" : " ";
                  html_txt +='<div class="card border-hover" style="background: white;">';
                  html_txt +='<img class="card-img-top thumbnail" src ="${pageContext.request.contextPath }/itemImg/'+list[i].item_mainimg+'"  style="width: 200px;align-self: center;" alt="" />';
                  html_txt +='<div class="card-body">';
                  html_txt +='<h5 class="card-title">'+list[i].item_name+'</h5>';
                  html_txt +='<p class="card-text">';
                  html_txt += '<p class="card-text">'+price+'원&nbsp;&nbsp;<strong>당일배송</strong></p>';
                  html_txt += '<p class="card-text">';//+list[i].star_avg+'점   ';
                  for(var j=1;j<=5;j++){
                	  if(j<=list[i].star_avg){
                		  html_txt +=  yStar;
                	  }else{
                		  html_txt += nStar;
                	  }
                  }
                  html_txt +='&nbsp;&nbsp;<span style="font-size: 15px;">('+list[i].star_total+'명 참여)</span></p>';
                  html_txt +='</div>';
                  html_txt +='<div class="form-row justify-content-center" style="padding-bottom:10%;">';
                  html_txt +='<div class="form-check" data-toggle="buttons" style="float: left;">';
                  html_txt +='<label class="btn btn-outline-danger '+aced+'"style="margin:0px;">';
                  html_txt +='<input hidden="hidden" type="checkbox" onclick="abc(this)" value="'+list[i].item_idx+'" '+cked+'>❤';
                  html_txt +='</label></div>';
                  html_txt +='<button style="margin-left: 8px;" class="btn btn-primary" onclick="showItemDetail('+list[i].item_idx+')">more</button>';
                  html_txt +='</div></div>';
                  
               }
         }
               cardList.innerHTML += html_txt;

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

function showItemDetail(idx){
   
   location.href = 'itemDetail.do?item_idx='+idx;
}
      
</script>
</head>
<body>

   <%@ include file="/WEB-INF/views/header.jsp"%>
   <div class="container" style="padding-top: 200px;">
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
      <div class="row form-row justify-content-center">
            <div class="panel-body col-md-12"
               style="margin-top: 50px; text-align: center;">

               <div style="text-align: center;">
                  <nav class='nav justify-content-center'
                     style="text-align: center;">
                     <a class='nav-link  navBtn'
                        onclick="clickParentCate(1000)">All</a>
                     <c:forEach var="cate" items="${cate }">
                        <c:if test="${cate.level==1 }">
                           <a class='nav-link  navBtn' style="margin-left: 10%;"
                              onclick="clickParentCate(${cate.cate_code })">${cate.cate_name }</a>
                        </c:if>
                     </c:forEach>
                  </nav>
            </div>
            <div  class="form-row justify-content-center">
               <!-- append 하위 메뉴 시작입니다 -->
               <div class="" >
                  <ul id="childCate">
                  </ul>
               </div>
               <!-- append 하위 메뉴 끝입니다. -->
            </div>
         </div>
      </div>
      <div class="row" style="background: white;">
         <div class="col-lg-12" style="background: white; text-align: right;">
            <select id="sort_change" onchange="sortItem(this)"
               style="width: 100px;">
               <option value="item_idx">최신순</option>
               <option value="item_price">가격순</option>
               <option value="star_avg">별점순</option>
               <option value="star_total">리뷰순</option>
            </select>
         </div>
      </div>
      <div class="row" style="background: white;min-height: 800px; padding-bottom: 100px;">
         <div class="col-md-12" id="cardList" style="margin-top: 50px;"></div>
      </div>
   </div>

   <form name="search_data">
      <input id="cate_code" name="cate_code" type="hidden"
         value="${cate_code }"> <input id="search_option"
         name="search_option" type="hidden" value="${search_option }">
      <input id="sort_option" name="sort_option" type="hidden" value="">
      <input id="cp" name="cp" type="hidden" value="1">
   </form>




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




   <a id="back-to-top" href="#" class="btn btn-primary btn-lg back-to-top"
      role="button" title="Click to return on the top page"
      data-toggle="tooltip" data-placement="left"><span
      class="glyphicon glyphicon-chevron-up">top</span></a>
   <%@ include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>