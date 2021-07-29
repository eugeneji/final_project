<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src='https://code.jquery.com/jquery-3.5.1.min.js'></script>
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
<script type="text/javascript"
	src="${pageContext.request.contextPath }/ckeditor/ckeditor.js"></script>
<style type="text/css">
.imgNameDiv {
	float: left;
}

.imgShow {
	float: left;
	width: 600px;
	height: 300px;
	border: 1px;
}
</style>

<!-- ckeditor 사용을 위해 js파일을 연결함 -->

<script type="text/javascript">
	var i = 1;
	function addFile() {
		if (i < 5) {
			var newImgTag = document.createElement('tr');
			newImgTag.innerHTML = '<th>서브 이미지</th><td><input type="file" name="item_subimg" id="product_main_image" onchange="setThumbnail(event)"></td>';
			var ulNode = document.getElementById('mainImgTag');
			ulNode.appendChild(newImgTag);
			i++;

		} else {
			window.alert('서브 썸네일은 5개 까지 업로드 가능합니다');
		}

	}
	function goSubTf() {
		document.getElementById("subimg_tf").value = 1;
	}

	function imgCheck(fm) {
		var item_name = fm.item_name.value;
		var item_price = fm.item_price.value;
		var cate_code = fm.cateCode2_v.value;
		var item_mainimg = fm.item_mainimg.value;
		var item_info = fm.item_info.value;

		item_mainimg = item_mainimg.trim();

		if (item_name == null || item_name == "") {
			window.alert('제목을 입력해주세요');
			return false;
		}
		if (img.length == 0) {
			var result = window.confirm('사진 추가없이 상품을 등록하시겠습니까?');
			if (result == true) {
				return true;
			} else {
				return false;
			}
		} else {
			var imgtp = item_mainimg.lastIndexOf(".");
			var imgtp2 = item_mainimg.substr(imgtp + 1);
			var imgtp2 = imgtp2.toLowerCase();
			if (imgtp2 == "png" || imgtp2 == "jpg" || imgtp2 == "jpeg"
					|| imgtp2 == "gif") {
				return true;
			} else {
				window.alert('올바른 파일 형식이 아닙니다.');
				return false;
			}
		}
		return true;
	}
	
	var subfiles = [];
	var Thumfile = [];
	function setSubThumbnail(event) {
		goSubTf();
		subfiles = [];
		var uploadWrap = event.target.parentNode;
		var subImgsWrap = document.getElementById("subImgs");
		subImgsWrap.innerHTML = '';
		var files = event.target.files;
		var filesArr = Array.prototype.slice.call(files);
		if(filesArr.length>4){
			window.alert("4장가능");
			return;
		}
		var index = 0;
		filesArr.forEach(function(f){
			if(!f.type.match("image.*")){
				window.alert("이미지 파일만 가능합니다.");
				return;
			}
			subfiles.push(f);
			var reader = new FileReader();
			reader.onload = function(event) {
				var newImg = document.createElement("img");
				subImgsWrap.appendChild(newImg);
				newImg.setAttribute("src", event.target.result);
				newImg.setAttribute("onclick", "deleteImg("+index+")");
				newImg.setAttribute("id", "sub"+index);
				newImg.setAttribute("width", 200);
				newImg.setAttribute("class", "pre_img");
				index++;
			}
			
			reader.readAsDataURL(f);
		});
		
	}

	function setThumbnail(event) {
		goSubTf();
	    var uploadWrap = event.target.parentNode; 
	    //이벤트 대상자의 부모
	          var reader = new FileReader();

	           reader.onload = function(event) {
	                var newImg = document.createElement("img");
	                uploadWrap.appendChild(newImg);
	                newImg.setAttribute("src", event.target.result);
	                newImg.setAttribute("width", 200);
	                newImg.setAttribute("class", "pre_img");
	        }; 
	        reader.readAsDataURL(event.target.files[0]);
		
	}
	
	
	
	
	function deleteImg(i){
		subfiles.splice(i,1);
		var subId = "sub"+i;
		document.getElementById(subId).remove();
	}

	function secondSelect(cateCodeVal) {
		var cateCodeVal = cateCodeVal.value;
		var cateCodeNode = document.getElementById("cateCode2_v");
		cateCodeNode.innerHTML = '';
		var CodeList = new Array();
		CodeList = JSON.parse('${jscate}');

		option = document.createElement('option');
		option.setAttribute('value', cateCodeVal);
		option.innerHTML = '선택';
		cateCodeNode.appendChild(option);

		for (var i = 0; i < CodeList.length; i++) {
			if (CodeList[i].cate_parent == cateCodeVal && cateCodeVal != 1000) {
				option = document.createElement('option');
				option.setAttribute('value', CodeList[i].cate_code);
				option.innerHTML = CodeList[i].cate_name;
				cateCodeNode.appendChild(option);
			}
		}
	}
	function insertForm() {

	}
</script>
</head>
<body>
	<div class="container" style="padding-top: 8px;">
		<div class="row" id="titleDiv">
			<div class="col">
				<h3>상품등록</h3>
			</div>
		</div>

		<form id="uploadForm" method="post" enctype="multipart/form-data"
			action="insertItem.do" onsubmit="return imgCheck(this)">

			<div>
				<p style="font-size: 20px; font-weight: bold; margin-top: 40px;margin-bottom: 10px;">상품 기본 정보</p>
				<table class="table table-striped table-bordered">
					<colgroup>
						<col width="20%">
						<col width="auto">
					</colgroup>
					<tr>
						<th><label><strong>상품 1차 분류</strong></label></th>
						<td><select id="cateCode_v" name="cateCode"
							class="form-control" onchange="secondSelect(this)">
							<option>선택</option>
								<c:forEach var="cate" items="${cate }">
									<c:if test="${cate.level==1 }">
										<option value="${cate.cate_code }">${cate.cate_name }</option>
									</c:if>
								</c:forEach>
						</select></td>
					</tr>
					<tr>
						<th><label><strong>상품 2차 분류</strong></label></th>
						<td><select name="cate_code" id="cateCode2_v"
							class="form-control"><option>선택</option>
						</select></td>
					</tr>
					<tr>
						<th><label for="productName"><strong>상품명</strong></label></th>
						<td><input type="text" class="form-control" name="item_name"
							id="productName" placeholder="상품명 입력" required="required"></td>
					</tr>
					<tr>
						<th><label for="product_name_price"><strong>상품
									가격</strong></label></th>
						<td><input type="number" class="form-control"
							name="item_price" id="product_name_price"
							placeholder="ex>2000(단가,단위 생략)" required="required"></td>
					</tr>
					<tr>
						<th><label for="promotioncode"><strong>상품 게시
									여부</strong></label></th>
						<td>
							<div class="form-check" data-toggle="buttons">
								<label class="btn"> <input type="radio" value="T"
									name="item_tf" checked> 게시
								</label> <label class="btn"> <input type="radio" value="F"
									name="item_tf"> 미게시
								</label>
							</div>
						</td>
					</tr>
					<tr>
						<th><label for="productName"><strong>등록인</strong></label></th>
						<td><input type="text" class="form-control" name="item_regid"
							id="productName" value="${s_user.user_email }" readonly></td>
					</tr>
				</table>
			</div>

			<div>
			<p style="font-size: 20px; font-style: italic; font-weight: bold; margin-top: 40px;margin-bottom: 10px;">상품 상세 정보</p>
				<table class="table table-striped table-bordered"
					id="mainImgTag">
					<colgroup>
						<col width="20%">
						<col width="auto">
					</colgroup>
					<tr>
						<th><label for="product_name_image"><strong>섬네일
									이미지업로드</strong></label></th>
						<td><input type="file" name="item_mainimg"
							id="product_main_image" onchange="setThumbnail(event)" required="required"></td>
					</tr>
					<tr>
						<th><label for="product_name_image"><strong>서브
									이미지업로드</strong></label></th>
						<td><input type="file" name="item_subimg"
							id="product_main_image" onchange="setSubThumbnail(event)" multiple="multiple"></td>
					</tr>
					<tr>
						<td colspan="2" id="subImgs">
					</tr>					
				</table>
			</div>
			<input type="hidden" id="subimg_tf" name="subimg_tf" value="0">
			<div class="imgNameDiv"></div>
		<p style="font-size: 20px; font-style: italic; font-weight: bold; margin-top: 40px;margin-bottom: 10px;">상품 페이지 내용</p>
			<table class="table table-striped table-bordered table-hover">
				<colgroup>
					<col width="20%">
					<col width="auto">
				</colgroup>
				<tr>
					<td><textarea id="item_info" name="item_info" class="ckeditor"></textarea>
						<script type="text/javascript">
							CKEDITOR
									.replace(
											'item_info',
											{
												filebrowserImageUploadUrl : '${pageContext.request.contextPath}/itemInfoImgUpload.do'
											});
						</script></td>
				</tr>

			</table>




			<div class="form-row">
				<div class="form-group col" align="center">
					<button type="submit" class="btn btn-outline-success">상품등록</button>
					<button type="reset" class="btn btn-outline-secondary">다시작성</button>
					<button type="button" class="btn btn-outline-dark" onclick="javascript:location.href='adminPage.do'">취소</button>
				</div>
			</div>

		</form>

	</div>
	<%@ include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>