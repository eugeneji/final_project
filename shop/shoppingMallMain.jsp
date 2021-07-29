<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.11.2.min.js"></script>
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
* {
	margin: 0;
	padding: 0;
}

li {
	list-style: none;
}

.slider_wrapper {
	position: relative;
	float: left;
	width: 80%;
	min-width: 950px;
	height: 400px;
	padding: 0px;
	overflow: hidden;
	border-radius: 0px 7px 7px 0px;
}

.slides {
	position: absolute;
	left: 0;
	top: 0;
	transition: left 0.5s ease-out;
	padding-left: 5px;
	padding-right: 5px;
	width: 100%;
}

.slides li {
	display: inline-block;
	padding-top: 13px;
	height: 326px;
}

.controls {
	text-align: center;
	margin-top: 50px;
}

.controls span {
	background: #333;
	color: #fff;
	padding: 10px 20px;
	margin: 0 10px;
}

.controls .prev {
	right: calc(100% +50px);
	border-radius: 10px;
}

.controls .next {
	left: calc(100% +50px);
	border-radius: 10px;
}

img {
	width: 300px;
	height: 300px;
	border-radius: 7px;
	margin-left: 5px;
	margin-right: 5px;
}

/* 
.dd {
   display: inline-block;
   list-style: none;
   margin: 10px;
}

.dd li {
   display: inline;
}

.dd div.goodsThumb img {
   width: 300px;
   height: 300px;
}

.dd div.goodsName {
   padding: 10px;
} 
*/
.cateList {
	margin: 0px auto;
	float: left;
}

.mainContent {
	width: 100%;
	height: 400px;
	padding: 0px;
}

.hamMenuCl {
	display: none;
	position: absolute;
	width: 150px;
	background: gray;
	padding-top: 20px;
	padding-bottom: 10px;
	border-radius: 7%;
	list-style: disc;
}

.hamMenuCl li {
	margin-bottom: 10px;
}

.menuTab {
	width: 20%;
	padding-top: 18px;
	padding-left: 10px;
	text-align: center;
	min-width: 200px;
	height: 80px;
	margin: 0px;
	border-radius: 5px 0px 0px 5px;
	font-size: 24px;
	font-weight: bold;
	color: rgb(74, 74, 74);
	margin-bottom: 1.5px;
	border: 2px solid;
}
</style>


<script>
	window.onload = function() {
		show(1100);
		 $('.cateList').children()[0].click();
	}
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


	function show(select_code) {

		var data = {};
		data["cate_code"] = select_code;
		$.ajax({
			url : "selectShopitem.do",
			data : JSON.stringify(data),
			dataType : "json",
			contentType : "application/json;charset=UTF-8",
			type : "post",
			success : function(getData) {
				selectItemListCallBack(getData);
			}

		});

	}
	function selectItemListCallBack(getData) {
		var list = getData.list;
		var st = document.getElementById("slides");
		st.innerHTML = "";
		var html_txt = '';
		var itemListUl = document.getElementById("itemList");
		var itemListTxt = '';
		if (list == null || list.length == 0) {
			html_txt += '<tr>';
			html_txt += '   <td colspan="6">일치하는 정보가 없습니다.</td>';
			html_txt += '</tr>';

		} else {
			for (var i = 0; i < list.length; i++) {

				var price = list[i].item_price;
				price = price.toLocaleString();
				html_txt += '<li onclick="location.href='+"'"+'itemDetail.do?item_idx='+ list[i].item_idx +"'"+'">'; 
				html_txt += '<img src ="${pageContext.request.contextPath }/itemImg/'+list[i].item_mainimg+'" style="width:300px;height:300px;">';
				html_txt += '<p style="margin-left:10px;">'+list[i].item_name + '<br>';
				html_txt +=  price + '<br>';
				html_txt += list[i].star_avg + '점   '
						+ list[i].star_total + '명 참여<br></p>';
				html_txt += '</li>';

			}
		}
		var len = list.length;
		var code = 1210;
		st.innerHTML = html_txt;
		nextBtn(len, 1210);
	}
</script>
<script type="text/javascript">
	function nextBtn(len, code) {

		var slides = document.querySelector('.slides');
		var slide = document.querySelectorAll('.slides li');
		var currentIdx = 0;
		var slideCount = len + 1;
		var slideWidth = 300;
		var slideMargin = 15;
		var prevBtn = document.querySelector('.prev');
		var nextBtn = document.querySelector('.next');

		slides.style.width = (slideWidth + slideMargin) * slideCount
				- slideMargin + 'px';

		function moveSlide(num) {

			slides.style.left = -num * 315 + 'px';
			currentIdx = num;
		}
		nextBtn.addEventListener('click', function() {
			if (currentIdx < slideCount - 4) {
				moveSlide(currentIdx + 1);
				console.log(currentIdx);
			} else {

				moveSlide(0);
			}
		});

		prevBtn.addEventListener('click', function() {
			if (currentIdx > 0) {
				moveSlide(currentIdx - 1);
			} else {
				moveSlide(slideCount - 3);

			}

		});

	}
	
	function fnBackColorCh(obj, color)
	{
	   $('.menuTab').css('background-color', '');
	   $('.slider_wrapper').css('background-color', color);
	   $(obj).css('background-color', color);
	}

	
	function goSearchItem() {

		var searchForm = document.searchForm;
		searchForm.submit();
	}
</script>


</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>
	<div class="container" style="padding-top: 150px;">
		<div class="panel" >
			<!-- 검색바 및 햄버거 -->
				<!-- 햄버거 -->
				<div class="row">
			<div class="col-md-12 justify-content-center" style="text-align: center;" >
					<!-- 검색 설렉트 --><form name="searchForm" id="search" action="goShopList.do"
						method="post">
					<div style="padding-top: 10px; margin-right: 10px; float: left;"
						class="col-md-2">
						<select class="form-control" id="cate_select">
							<option value="1000">전체</option>
							<c:forEach var="cate" items="${cate }">
								<c:if test="${cate.level==1 }">
									<option value="${cate.cate_code }">${cate.cate_name }</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
					<!-- 검색 인풋 +버튼 -->
					<div class="col-md-7" style="float: left;">
						<input id="search_select"
							class="form-control border-secondary rounded-pill"
							style="margin-top: 10px; padding-left: 30px;"
							placeholder="검색어를 입력하세요">
					</div>
					<div class="col-md-1" style="float: left;">
						<button class="btn" onclick="goSearchItem()"
							style="margin-top: 5px; padding: 0px; width: 60px; height: 60px;">
							<img src="${pageContext.request.contextPath }/img/search.jpg"
								alt="검색" style="width: 60px; height: 60px;">
						</button>
					</div>
						</form>
			</div>
				
				</div>
				<button class="btn btn-outline-success btn-lg"
					style="float: right; margin: 100px 20px 10px 0px;" id="goShopList">전체보기</button>

				<div style="width: 100%; clear: both;">
					<div class="row">
						<div class="mainContent col-md-12">
						<div class="row">
							<div class="cateList mainContent col-md-2">
								<c:forEach var="cate" items="${cate }">
									<c:if test="${cate.level==1 }">
										<div
											onclick="show(${cate.cate_code });"
											class="menuTab" >
											${cate.cate_name }</div>
									</c:if>
								</c:forEach>
							</div>

							<div class="col-md-10" style="border: 1px solid black;" >
								<div class="slider_wrapper" >
									<ul class="slides" id="slides">
									</ul>
								</div>
								<div>
					<div class="controls">
						<span class="prev">prev</span> <span class="next">next</span>
					</div>
				</div>
								
								</div>
							</div>
						</div>

					</div>
				</div>
				

				<div>
					<div>
						<ul id="itemList" class="dd">

						</ul>
					</div>
				</div>
		</div>
	</div>
	<input type="hidden" name="cate_code" value="1">
	<script type="text/javascript">
		var goShopList = document.getElementById("goShopList");
		goShopList.addEventListener('click', function() {

			location.href = 'goShopList.do';
		});
	</script>
	<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>