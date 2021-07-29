<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.allC {
	position: fixed;
	width: 100%;
	height: 100%;
	top: 0px;
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
</style>
<script type="text/javascript">
	window.onload = function() {

		show(1);
	}
	function show(cp) {
		var formdata = $("#hiddenStorage").serialize();
		var cpdata = '&cp=' + cp;
		formdata += cpdata;
		$.ajax({
			url : "orderManager.do",
			data : formdata,
			dataType : "json",
			contentType : "application/json;charset=UTF-8",
			type : "GET",
			success : function(getData) {
				orderListCallBack(getData);
			}

		});
	}
	function orderListCallBack(getData) {
		var list = getData.list;
		var paging = getData.paging;

		var pgTd = document.getElementById("paging");
		pgTd.innerHTML = paging;

		var inOrderTb = document.getElementById("inOrder");
		var html_txt = '';
		if (list == null || list.length == 0) {
			html_txt += '<tr>';
			html_txt += '<td colspan="10">일치하는 정보가 없습니다.</td>';
			html_txt += '</tr>';
			pgTd.innerHTML = '';
		} else {
			pgTd.innerHTML = paging;

			for (var i = 0; i < list.length; i++) {
				html_txt += '<tr>';
				html_txt += '<td>' + list[i].rnum + '</td>';
				html_txt += '<td>' + list[i].order_idx + '</td>';
				html_txt += '<td>' + list[i].user_name + '</td>';
				html_txt += '<td>' + list[i].user_email + '</td>';
				html_txt += '<td>' + list[i].user_addr + '</td>';
				html_txt += '<td>' + list[i].user_tel + '</td>';
				html_txt += '<td>' + list[i].user_totalpay + '</td>';
				html_txt += '<td>' + list[i].order_date + '</td>';
				if (list[i].order_state == '취소요청') {
					html_txt += '<td>'
							+ list[i].order_state
							+ '<br><input type="button" value="요청승인" onclick="confirmCancel('
							+ list[i].order_idx + ')"></td>';
				} else if (list[i].order_state == '결제완료') {
					html_txt += '<td>'
							+ list[i].order_state
							 + '</td>';
				} else {
					html_txt += '<td>' + list[i].order_state + '</td>';
				}
				html_txt += '<td>'
						+ list[i].order_state
						+ '<input type="button" value="상품상태변경" onclick="stateUpdateForm('
						+ list[i].order_idx + ')"></td>';
				html_txt += '</tr>';
			}
		}
		inOrderTb.innerHTML = html_txt;
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
		var user_addr_detail = document.getElementById("user_addr_detail");
		var user_tel = document.getElementById("user_tel");
		var order_totalpay = document.getElementById("order_totalpay");
		var order_date = document.getElementById("order_date");
		var order_state = document.getElementById("order_state");

		order_idx.innerHTML = master.order_idx;
		user_name.innerHTML = master.user_name;
		user_email.innerHTML = master.user_email;
		user_addr.innerHTML = master.user_addr;
		user_addr_detail.innerHTML = master.user_addr_detail;
		user_tel.innerHTML = master.user_tel;
		order_totalpay.innerHTML = master.user_totalpay;
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
					+ details[i].item_price
					+ '<input type="hidden" name="item_price" value="'+details[i].item_price+'"></td>';
			html_txt += '<td name="detail_unit">' + details[i].detail_unit
					+ '</td>';
			html_txt += '<td name="item_stock">' + details[i].item_stock
					+ '</td>';
			html_txt += '</tr>';
		}

		detailTb.innerHTML = html_txt;

	}

	function divClose() {
		var allC = document.getElementById("allC");
		allC.style.display = 'none';
		document.getElementById("stockControll").style.display = 'none';
	}
	function putSearchOp(op) {
		var search_option = document.getElementById("search_option");
		search_option.setAttribute('value', op.value);
	}
	function goSearch() {
		var putKeyword = document.getElementById("putKeyword");
		var keyword = document.getElementById("keyword");
		keyword.setAttribute('value', putKeyword.value);

		show(1);
	}
	function confirmCancel(idx) {
		if (window.confirm(' 해당 주문 취소를 정말 승인하시겠습니까?')) {

			$.ajax({
				url : "confirmCancel.do",
				type : "post",
				data : {
					'order_idx' : idx,
					'order_state' : '취소'
				},
				success : function(msgData) {
					window.alert(msgData.msg);
					show(1);
				}
			});

		}

	}

	function orderManage() {
		var order_idx = document.getElementById("order_idx").innerHTML;
		var user_email = document.getElementById("user_email").innerHTML;
		var newState = document.getElementById("newState").value;
		var detail_units = document.getElementsByName("detail_unit");
		var item_prices = document.getElementsByName("item_price");
		var item_stock = document.getElementsByName("item_stock");
		var item_idxs = document.getElementsByName("item_idx");

		var item_idx = new Array();
		var detail_unit = new Array();
		var item_price = new Array();
		var du;
		var is;
		var ip;
		for (var i = 0; i < item_stock.length; i++) {

			du = parseInt(detail_units[i].innerHTML);
			is = parseInt(item_stock[i].innerHTML);
			if (du > is) {
				window.alert('상품의 재고가 부족합니다.');
				return;
			}
			item_idx.push(item_idxs[i].value);
			detail_unit.push(detail_units[i].innerHTML);
			item_price.push(item_prices[i].value);
		}

		$.ajax({
			url : "stateUpdate.do",
			type : "post",
			data : {
				'order_idx' : order_idx,
				'user_email' : user_email,
				'order_state' : newState,
				'item_idx' : item_idx,
				'detail_unit' : detail_unit,
				'item_price' : item_price
			},
			success : function(msgData) {
				window.alert(msgData.msg);
				var idx = msgData.user_idx;
				var txt = '<a>'+'회원님의 주문이'+newState+' 상태로 변경되었습니다.'+'</a>'
				send('alarm',idx,txt);
				show(1);
				var allC = document.getElementById("allC");
				allC.style.display = 'none';
				document.getElementById("stockControll").style.display = 'none';
				
			}
		});

	}
</script>
</head>
<body>
	<div class="allC" id="allC" style="display: none;"></div>
	<div class="container mainContent" style="position: relative;">
		<table class="table table-striped table-bordered"
			style="margin-top: 20px;">
			<thead>
				<tr>
					<td colspan="10">
					<div  class="form-row justify-content-center">
					<select onchange="putSearchOp(this)" class="form-control col-2" style="float: left;">
							<option value="order_idx">주문번호</option>
							<option value="user_email">주문자아이디</option>
					</select>
					<div class="col-6" style="float: left; margin-left: 15px;">
					<input type="text" id="putKeyword"  class="form-control">
					</div>
					<input type="button" value="검색" class="btn btn-info" style="margin-left: 10px;"
						onclick="goSearch()">
						</div>
						</td>
				</tr>
				<tr>
					<th>번호</th>
					<th>주문번호</th>
					<th>주문자</th>
					<th>주문자아이디</th>
					<th>배송지</th>
					<th>연락처</th>
					<th>결제금액</th>
					<th>결제일</th>
					<th>주문상태</th>
					<th>상세보기</th>
				</tr>
			</thead>
			<tbody id="inOrder">
			</tbody>
			<tfoot>
				<tr>
					<td colspan="10" style="text-align: center;" id="paging"></td>
				</tr>
			</tfoot>
		</table>
		<div class="form-row justify-content-center">
		<button type="button" class="btn btn-outline-dark" onclick="javascript:location.href='adminPage.do'">돌아가기</button>
		</div>
		<form name="hiddenStorage" id="hiddenStorage">
			<input type="hidden" id="keyword" name="keyword" value=""> <input
				type="hidden" id="search_option" name="search_option"
				value="order_idx"> <input type="hidden" id="sort_option"
				name="sort_option" value="order_idx"> <input type="hidden">
			<input type="hidden">
		</form>

		<div class="container popup1" id="stockControll"
			style="display: none; position: absolute; left: 30px; top: 30px;">
			<p style="font-size: 20px; font-style: italic; font-weight: bold; margin-top: 40px;margin-bottom: 10px;">주문 정보</p>
			<table class="table table-striped table-bordered table-hover">
				<colgroup>
					<col width="20%">
					<col width="auto">
				</colgroup>
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
					<th><label><strong>배송지</strong></label></th>
					<td id="user_addr_detail"></td>
				</tr>
				<tr>
					<th><label><strong>주문자 연락처</strong></label></th>
					<td id="user_tel"></td>
				</tr>
				<tr>
					<th><label><strong>결제 총액</strong></label></th>
					<td id="order_totalpay"></td>
				</tr>
				<tr>
					<th><label><strong>결제일</strong></label></th>
					<td id="order_date"></td>
				</tr>
			</table>
			<p style="font-size: 20px; font-style: italic; font-weight: bold; margin-top: 40px;margin-bottom: 10px;">주문 상세 정보</p>
			<table class="table table-striped table-bordered table-hover">
				<colgroup>
					<col width="20%">
					<col width="auto">
				</colgroup>
				<thead>
					<tr>
						<th>상품 이름</th>
						<th>상품가격</th>
						<th>주문 수량</th>
						<th>상품재고</th>
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
						<th><label><strong>상태 변경</strong></label></th>
						<td colspan="3"><select id="newState">
								<option value="취소">취소</option>
								<option value="취소요청">취소요청</option>
								<option value="결제완료">결제완료</option>
								<option value="배송시작">배송시작</option>
								<option value="배송완료">배송완료</option>
						</select></td>
					</tr>
					<tr>
						<td colspan="4" style="text-align: center;"><input type="button" class="btn btn-info" value="적용"
							onclick="orderManage()"> <input type="button" class="btn btn-outline-dark" value="닫기"
							onclick="divClose()"></td>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/footer.jsp"%>
</body>
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