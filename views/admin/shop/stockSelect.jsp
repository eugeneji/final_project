<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/httpRequest.js"></script>
<script type="text/javascript"
	src="js/admin/productstock/prodectStock.js"></script>
<script src='https://code.jquery.com/jquery-3.5.1.min.js'></script>
<script
	src='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js'></script>
<link rel='stylesheet'
	href='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css' />
<style>
.popup1 {
	position: absolute;
	top: 30%;
	left: 25%;
	background: rgb(245, 245, 245);
	z-index: 3;
}

.popup2 {
	position: absolute;
background: rgb(245, 245, 245);
	z-index: 10;
	left: 40%;
	top: 40%;
}

.mainContent {
	z-index: 1;
}

.allC {
	position: fixed;
	width: 100%;
	height: 100%;
	top: 0px;
	background-color: black;
	opacity: 0.7;
	z-index: 2;
}
</style>
<script type="text/javascript">
	function secondSelect(cateCodeVal) {
		var cateCodeVal = cateCodeVal.value;
		var cateCodeNode = document.getElementById("cateCode2_v");
		cateCodeNode.innerHTML = '';
		var CodeList = new Array();
		CodeList = JSON.parse('${jscate}');

		option = document.createElement('option');
		option.setAttribute('value', cateCodeVal);
		option.innerHTML = '전체';
		cateCodeNode.appendChild(option);

		for (var i = 0; i < CodeList.length; i++) {
			if (CodeList[i].cate_parent == cateCodeVal && cateCodeVal != 1000) {
				option = document.createElement('option');
				option.setAttribute('value', CodeList[i].cate_code);
				option.innerHTML = CodeList[i].cate_name;
				cateCodeNode.appendChild(option);
			}
		}

		var cate_code = document.getElementById("cate_code");
		var cate_code2 = document.getElementById("cate_code2");
		var cateCode_v = document.getElementById("cateCode_v").value;
		var cateCode2_v = document.getElementById("cateCode2_v").value;
		cate_code.setAttribute('value', cateCode_v);
		cate_code2.setAttribute('value', cateCode2_v);
		show(1)
	}

	function clickRadio() {
		$("input:radio[name=stock_type]")
				.click(
						function() {
							window.alert();
							$("#stock_cause").html('');
							if ($("input:radio[name=stock_type]:checked").val() == 'in') {
								$("#stock_cause").append(
										'<option value="정기입고">정기입고</option>');
								$("#stock_cause").append(
										'<option value="추가입고">추가입고</option>');
								$("#stock_cause").append(
										'<option value="반품">반품</option>');
								$("#stock_cause").append(
										'<option value="기타">기타</option>');
							} else {
								$("#stock_cause").append(
										'<option value="판매">판매</option>');
								$("#stock_cause").append(
										'<option value="불량">불량</option>');
								$("#stock_cause")
										.append(
												'<option value="분실 및 파손">분실 및 파손</option>');
								$("#stock_cause").append(
										'<option value="기타">기타</option>');
							}
						});

	}
</script>
</head>
<body>

<div class="allC" id="allC" style="display: none;"></div>

<div class="container mainContent" style="position: relative;">
   <table class="table table-striped table-bordered" style="margin-top: 20px;">
      <colgroup>
         <col width="10%">
         <col width="auto">
         <col width="10%">
         <col width="auto">
         <col width="10%">
         <col width="auto">
      </colgroup>
      <tr>
         <th>
            1차 메뉴
         </th>
         <td> 
            <select id="cateCode_v" name="cateCode" class="form-control" onchange="secondSelect(this)"> 
               <option value="1000">==전체==</option>
               <c:forEach var="cate" items="${cate }">
                  <c:if test="${cate.level==1 }">
                        <option value="${cate.cate_code }">${cate.cate_name }</option>
                     </c:if>
                  </c:forEach>
               </select>
             </td>
            <th>
            2차 메뉴
         </th>
            <td> 
               <select name="cateCode2" id="cateCode2_v" class="form-control" onchange="cateValue()">
                  <option value="1000"> ==전체== </option>
               </select>
            </td>
         <th>
            검색 조건
         </th>
            <td colspan="3"> 
            <select id="selectOption" class="form-control col-4" style="float: left;">
               <option value="item_name">상품명</option>
               <option value="item_idx">상품번호</option>
               <option value="item_regid">상품등록인</option>
            </select>
            <div class="col-8" style="float: left;">
               <input type="text" id="itemName_v" class="form-control">
            </div>
            </td>
      </tr>
   </table>

   <div class="form-row justify-content-center" style="margin-bottom: 10px;">
      <input type="button" class="btn btn-info" onclick="setValue()" value="검색">
   </div>
   
   <table id="selectTable" class="table align-middle">
   </table>
		<div class="form-row justify-content-center">
			<span id="paging"></span>
		</div>
		<div class="form-row justify-content-center">
		<button type="button" class="btn btn-outline-dark" onclick="javascript:location.href='adminPage.do'">돌아가기</button>
		</div>
   <input type="hidden" id="cate_code" value="1000">
   <input type="hidden" id="cate_code2" value="1000" >
   <input type="hidden" id="item_name" value="" >
</div>


<div class="container popup1" id="stockControll" style="display: none; width: 50%; padding-top: 10px;">     

   <div align="center">
      <h4>입/출고 수량 및 단가 반영</h4>      
   </div>
   
   <form name="insertStockForm">
      <div class="card card-body">
         <input type="hidden" id="idx" name="item_idx" >
         <input type="hidden" id="price" >
         
         <table class="table table-bordered">
            <tr>
               <th colspan="3">
                  <span style="margin-right: 20px;">입출고 구분</span>
                  <div class="custom-control custom-radio custom-control-inline">
                          <input type="radio"  value="in" id="added" name="stock_type" class="custom-control-input" checked>
                          <label class="custom-control-label" for="added">입고</label>
                     </div>
                     <div class="custom-control custom-radio custom-control-inline">
                         <input type="radio"  value="out" id="modified" name="stock_type" class="custom-control-input">
                         <label class="custom-control-label" for="modified">출고</label>
                     </div>
               </th>
            </tr>
            <tr>
               <th scope="row">재고 반영 전</th>
               <th scope="row">재고 증감</th>
               <th scope="row">재고 반영 후</th>
            </tr>
            <tr>
               <td>
                  <input type="number" class="form-control-plaintext" id="beforeVal" value="" readonly>
               </td>
               <td>
                  <input type="number"  class="form-control" id="stock_unit" name="stock_unit" value="0"  onchange="afterStock(this)">
               </td>
               <td>
                  <input type="number" class="form-control-plaintext" name="item_stock" id="stock" value="" readonly>
               </td>
            </tr>
            <tr>
               <th>실행 단가</th>
               <th>재고 증감</th>
               <th>총 발생 금액</th>
            </tr>
            <tr>
               <td>
                  <input type="number" class="form-control" name="stock_unitcost" id="unitcost" value="" onchange="totalCostView(this)">            
               </td>
               <td>
                  <input type="text" class="form-control" id="stock_unit2" value="" readonly>   
               </td>
               <td>
                  <input type="number"  class="form-control" id="totalCost" value="0" readonly> 
               </td>
            </tr>
            <tr>
               <th colspan="3">입/출고 사유</th>
            </tr>
            <tr>
               <td colspan="3">
                  <input type="text" class="form-control col-12" name="stock_cause" id="stock_cause" value="">   
               </td>
            </tr>
         </table>
      </div>
   </form>
   
   <div class="form-row justify-content-center" style="margin-top: 10px; margin-bottom: 10px;">
      <button id="doModify" class="btn btn-outline-info active" onclick="insertStock()" style="margin-right: 5px;">재고 반영</button>        
      <button id="cancelMod" class="btn btn-outline-secondary" onclick="closeStockManager()">닫기</button>                        
   </div>
</div>



   <div id="resultDiv" class="popup2" style="display: none; width: 500px; height: 200px; text-align: center;">
      <div id="resultSpan" style="padding-top: 70px;"></div>
      <div style="margin-top: 30px;">
      <input type="button" class="btn btn-primary" id="cancelMod" value="확인" onclick="closeMsg()">
      </div>
   </div>
<%@ include file="/WEB-INF/views/footer.jsp"%>
</body>

</html>