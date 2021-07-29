<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
window.onload = function(){
	show();
}
function show(){
    var data = $("form[name=search_option]").serialize();
    
   $.ajax({
      url : "getStockDetailList.do",
       data:  data,
      type:"post",
      success : function(getData){
         stockDetailListCallBack(getData);
      }
   });
}
function stockDetailListCallBack(getData){
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
			html_txt += '<td>' + list[i].stock_unit + '</td>';
			html_txt += '<td>' + list[i].stock_unitcost + '</td>';
			html_txt += '<td>' + list[i].stock_type + '</td>';
			html_txt += '<td>' + list[i].stock_cause + '</td>';
			html_txt += '<td>' + list[i].stock_dater + '</td>';
			html_txt += '</tr>';
		}
	}
	inOrderTb.innerHTML = html_txt;	
	
}
</script>
</head>
<body>
<div class="container mainContent" style="position: relative;">

<table class="table table-striped table-bordered"
			style="margin-top: 20px;">
			<thead>
				<tr>
					<td colspan="10">
					<div  class="form-row justify-content-center">
					<select onchange="putSearchOp(this)" class="form-control col-2" style="float: left;">
							<option value="order_idx">==전체==</option>
							<option value="order_idx">입고</option>
							<option value="user_email">출고</option>
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
					<th>수량</th>
					<th>단가</th>
					<th>구분</th>
					<th>사유</th>
					<th>날짜</th>
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


</div>
<form name="search_option">
<input type="hidden" name="item_idx" id="item_idx" value="${item_idx }">
<input type="hidden" name="" id="" value="">
<input type="hidden" name="" id="" value="">
<input type="hidden" name="" id="" value="">
<input type="hidden" name="" id="" value="">
</form>
</body>
</html>