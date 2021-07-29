<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="js/httpRequest.js"></script>
<script
	src='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js'></script>
<link rel='stylesheet'
	href='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css' />

<script>
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

	function cateValue() {
		var cate_code = document.getElementById("cate_code");
		var cate_code2 = document.getElementById("cate_code2");
		var cateCode_v = document.getElementById("cateCode_v").value;
		var cateCode2_v = document.getElementById("cateCode2_v").value;
		cate_code.setAttribute('value', cateCode_v);
		cate_code2.setAttribute('value', cateCode2_v);
		show(1)
	}
</script>
<script>
	window.onload = function() {

		show(1);
	}
	function setValue() {
		var cate_code = document.getElementById("cate_code");
		var cate_code2 = document.getElementById("cate_code2");
		var item_name = document.getElementById("item_name");

		var cateCode_v = document.getElementById("cateCode_v").value;
		var cateCode2_v = document.getElementById("cateCode2_v").value;
		var itemName_v = document.getElementById("itemName_v").value;
		cate_code.setAttribute('value', cateCode_v);
		cate_code2.setAttribute('value', cateCode2_v);
		item_name.setAttribute('value', itemName_v);
		show(1);
	}

	function show(cp) {
		var data = {};
		data["cate_code"] = document.getElementById("cate_code").value;
		data["cate_code2"] = document.getElementById("cate_code2").value;
		data["item_name"] = document.getElementById("item_name").value;
		data["selectOption"] = document.getElementById("selectOption").value;
		data["cp"] = cp;
		$.ajax({
			url : "selectItemListAdmin.do",
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
		var paging = getData.paging;
		var list = getData.list;
		var st = document.getElementById("selectTable");
		var pg = document.getElementById("paging");

		st.innerHTML = "";
		var html_txt = '';

		if (list == null || list.length == 0) {
			html_txt += '<tr>';
			html_txt += '   <td colspan="6">일치하는 정보가 없습니다.</td>';
			html_txt += '</tr>';
			pg.innerHTML = '';
		} else {
			html_txt += '<tr class="text"><th class="text-center text-nowrap">번호</th><th >상품 번호</th><th>썸네일</th><th>상품 이름</th><th>상품 가격</th><th>상품 재고</th><th>등록인</th><th>등록날짜</th><th class="text-center text-nowrap">게시여부</th></tr>';
			for (var i = 0; i < list.length; i++) {
				var tf = list[i].item_tf;
				var selT = tf == 'T' ? 'selected' : '';
				var selF = tf == 'F' ? 'selected' : '';
				var price = list[i].item_price;
				price = price.toLocaleString();
				html_txt += '<tr>';
				html_txt += '   <td class="align-middle"  itemIdx="idx'+i+'" name="idx'+i+'">'
						+ list[i].rnum + '</td>';
				html_txt += '   <td class="align-middle"  itemIdx="idx'+i+'" name="idx'+i+'">'
						+ list[i].item_idx + '</td>';
				//   html_txt += '   <td class="align-middle text-nowrap" id="itemName'+i+'" name="itemName'+i+'"><div class="reviewImg1"><img src ="${pageContext.request.contextPath }/itemImg/'+list[i].item_mainimg+'/0" ></div></td>';
				//			   html_txt += '   <td class="align-middle text-nowrap" id="itemName'+i+'" name="itemName'+i+'"><div class="reviewImg1"><img src ="${pageContext.request.contextPath }/itemImg/'+list[i].item_name+'/'+list[i].item_mainimg+'" ></div></td>';
				html_txt += '   <td class="align-middle text-nowrap" id="itemName'+i+'" name="itemName'+i+'"><div class="reviewImg1"><img src ="${pageContext.request.contextPath }/itemImg/'+list[i].item_mainimg+'" style="width:100px;height:100px;"></div></td>';
				html_txt += '   <td class="align-middle text-nowrap" id="itemName'+i+'" name="itemName'+i+'"><a href="updateItemForm.do?item_idx='
						+ list[i].item_idx
						+ '">'
						+ list[i].item_name
						+ '</a></td>';
				html_txt += '   <td class="reviewText2" id="itemPrice'+i+'" name="itemPrice'+i+'">'
						+ price + '</td>';
				html_txt += '   <td id="itemStock'+i+'" name="itemStock'+i+'">'
						+ list[i].item_stock + '</td>';
				html_txt += '   <td id="itemregId'+i+'" name="itemregId'+i+'">'
						+ list[i].item_regid + '</td>';
				html_txt += '   <td id="itemregDate'+i+'" name="itemregDate'+i+'">'
						+ list[i].item_regdate + '</td>';
				html_txt += '   <td id="item_tf'+i+'" name="item_tf'+i+'"><select name="'
						+ list[i].item_idx
						+ '" onchange="tf_controll(this)"><option value="F" '+selF+'>F</option><option value="T" '+selT+'>T</option></select></td>';
				html_txt += '</tr>';
			}
			html_txt += '<tr>';
			html_txt += '<td colspan="9">' + paging;
			html_txt += '</td>';
			html_txt += '</tr>';
		}

		st.innerHTML = html_txt;
	}
	function tf_controll(item) {
		var item_idx = item.name;
		var item_tf = item.value;
		var formData = new FormData();
		formData.append('item_idx', item_idx);
		formData.append('item_tf', item_tf);

		$.ajax({
			url : "controllTf.do",
			data : {
				'item_idx' : item_idx,
				'item_tf' : item_tf
			},
			type : "post",
			async : false,
			success : function(getData) {
				itemTfCallBack(getData);
			},
			error : function(e) {
				window.alert('a');
			}

		});
	}
	function itemTfCallBack(getData) {
		window.alert(getData.msg);
		var divNode = document.getElementById("resultDiv");
		divNode.style.display = "";

		var divSpan = document.getElementById("resultSpan");
		divSpan.innerHTML = getData.msg
	}

	function closeMsg() {
		var divNode = document.getElementById("resultDiv");
		divNode.style.display = "none";
	}

	function creatPriceForm(price) {
		var len = price.length;
		var price_s = '' + price;
		while (len / 3 != 0) {

		}
	}
</script>
</head>
<body>
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
            </div></td>
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
		<input type="hidden" id="cate_code" value="1000"> <input
			type="hidden" id="cate_code2" value="1000"> <input
			type="hidden" id="item_name" value="">
	</div>
	<div id="resultDiv" style="display: none; position: absolute;">
		<span id="resultSpan"></span>
		<button type="button" id="cancelMod" class="btn btn-outline-secondary"
			onclick="closeMsg()">확인</button>
			<%@ include file="/WEB-INF/views/footer.jsp"%>
	</div>
</body>
</html>