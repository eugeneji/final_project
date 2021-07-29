<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src='https://code.jquery.com/jquery-3.5.1.min.js'></script>
<script src='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js'></script>
<link rel='stylesheet' href='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css' />
<script type="text/javascript" src="${pageContext.request.contextPath }/ckeditor/ckeditor.js"></script>


<!-- ckeditor 사용을 위해 js파일을 연결함 -->

<script type="text/javascript">

function addFile(){
	var imgNum =document.getElementById("imgNum");
	
	if(imgNum.value<5){
	var newImgTag = document.createElement('tr');
	newImgTag.innerHTML = '<th>서브 이미지</th><td><input type="file" name="item_subimg" id="product_main_image" onchange="setThumbnail(event)"></td>';
	var ulNode = document.getElementById('mainImgTag');
	ulNode.appendChild(newImgTag);
	var num = (imgNum.value*1)+1;
	imgNum.value = num;
	
	}else{
		window.alert('썸네일은 5개 까지 업로드 가능합니다');
	}
	
}
function goSubTf(){
	document.getElementById("subimg_tf").value = 1;
}

function secondSelect(cateCodeVal){
	var cateCodeVal = cateCodeVal.value;
	var cateCodeNode = document.getElementById("cateCode2_v");
	cateCodeNode.innerHTML = '';
	var CodeList = new Array();
	CodeList = JSON.parse('${jscate}');
	
		option = document.createElement('option');
		option.setAttribute('value',cateCodeVal);
		option.innerHTML = '선택';
		cateCodeNode.appendChild(option);
	
for(var i=0;i<CodeList.length;i++){
	if(CodeList[i].cate_parent==cateCodeVal && cateCodeVal != 1000){
		option = document.createElement('option');
		option.setAttribute('value',CodeList[i].cate_code);
		option.innerHTML = CodeList[i].cate_name;
		cateCodeNode.appendChild(option);
	}
 }
}
function deleteImg(putNode){
	var thumName = document.getElementById("mainimg").value;
	
	var delSpan = putNode.parentNode;
	var delTd = delSpan.parentNode;
	var delTr = delTd.parentNode;
	var delT = delTr.parentNode;



	var delImg = delSpan.firstChild;
	var delHidden = delImg.nextSibling;
	var name= delHidden.value;
	if(delImg.getAttribute("id")==thumName){
		if(window.confirm("해당 이미지는 썸네일입니다 지우시겠습니까?")){
			
			var hiddenStorage = document.getElementById("hiddenStorage");
			var thumTr = document.getElementById("thumTr");
			var delThum = thumTr.parentNode;
			delThum.removeChild(thumTr);
			var hiddenName = document.createElement("input");
			 	hiddenName.setAttribute("type","hidden");
			 	hiddenName.setAttribute("value",name);
			 	hiddenName.setAttribute("name","delImg");
			 	hiddenStorage.appendChild(hiddenName);
			 	delT.removeChild(delTr);
			 	
			 	var imgNum =document.getElementById("imgNum");
			 	var num = (imgNum.value*1)-1;
				imgNum.value = num;
				document.getElementById("thum_tf").value = 0;
				
				var viewThum =document.getElementById("viewThum");
				viewThum.innerHTML = '';
		}
		
	}else{
	
	var hiddenStorage = document.getElementById("hiddenStorage");
	var hiddenName = document.createElement("input");
	 	hiddenName.setAttribute("type","hidden");
	 	hiddenName.setAttribute("value",name);
	 	hiddenName.setAttribute("name","delImg");
	 	hiddenStorage.appendChild(hiddenName);
	 	delT.removeChild(delTr);
	 	
	 	var imgNum =document.getElementById("imgNum");
	 	var num = (imgNum.value*1)-1;
		imgNum.value = num;
	}
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
function goThumTf(){
	document.getElementById("thum_tf").value = 1;
}
</script>
</head>
<body>
<div class="container">
	<div class="row" id="titleDiv">
		<div class="col">
			<h3>상품 정보 관리</h3>
		</div>
	</div>  
		
	<form id="uploadForm" method="post" enctype="multipart/form-data" action="updateItem.do">
			
			
			<div>
				<span>상품 기본 정보</span>
				<table class="table table-striped table-bordered table-hover">
					<colgroup>
						<col width="20%">
						<col width="auto">
					</colgroup>
					<tr>
					<th><label ><strong>상품 번호</strong></label></th>
					<td><input type="text" class="form-control" name="item_idx" id="item_idx" value="${item.item_idx }" readonly></td>
					</tr>
					<tr>
						<th><label><strong>상품 1차 분류</strong></label></th>
						<td><select id="cateCode_v" name="cateCode" class="form-control" onchange="secondSelect(this)">
			<c:forEach var="cate" items="${cate }">
<c:if test="${cate.level==1 }">
				<option value="${cate.cate_code }" ${dto.cate_parent eq cate.cate_code? 'selected':'' }>${cate.cate_name }</option>
				</c:if>
			</c:forEach>						 
				</select></td>
					</tr>
					<tr>
						<th><label><strong>상품 2차 분류</strong></label></th>
						<td><select  name="cate_code" id="cateCode2_v"  class="form-control" >
				<c:forEach var="cate2" items="${cate }">
<c:if test="${cate2.level==2 }">
				<option value="${cate2.cate_code }" ${dto.cate_code eq cate2.cate_code? 'selected':'' }>${cate2.cate_name }</option>
				</c:if>
			</c:forEach>
				</select></td>
					</tr>
					<tr>
						<th><label for="productName"><strong>상품명</strong></label></th>
						<td><input type="text" class="form-control" name="item_name" id="productName" value="${item.item_name }"></td>
					</tr>
					<tr>
						<th><label for="product_name_price"><strong>상품
									가격</strong></label></th>
						<td><input type="number" class="form-control" name="item_price" id="product_name_price" value="${item.item_price }" placeholder="ex>2000(단가,단위 생략)"></td>
					</tr>
					<tr>
						<th><label for="promotioncode"><strong>상품 게시
									여부</strong></label></th>
						<td>
							<div class="form-check" data-toggle="buttons">
								<label class="btn"> <input type="radio" value="T"
									name="item_tf"  ${item.item_tf eq 'T'? 'checked':''}> 게시
								</label> <label class="btn"> <input type="radio" value="F"
									name="item_tf"  ${item.item_tf eq 'F'? 'checked':''}> 미게시
								</label>
							</div>
						</td>
					</tr>
					<tr>
						<th><label for="productName"><strong>등록인</strong></label></th>
						<td><input type="text" class="form-control" name="item_regid" id="productName" value="${item.item_regid }" readonly></td>
					</tr>
				</table>
			</div>

			<div>
				<table class="table table-striped table-bordered table-hover"
					id="mainImgTag">
					<colgroup>
						<col width="20%">
						<col width="auto">
					</colgroup>
					<tr>
						<th><label for="product_name_image"><strong>섬네일
									이미지업로드</strong></label></th>
						<td><input type="file" name="item_mainimg" id="product_name_image" onchange="setThumbnail(event)"></td>
					</tr>
					<tr id="thumTr">
						<th><label for="product_name_image"><strong>섬네일</strong></label></th>
						<td><span id="viewThum"><img src ="${pageContext.request.contextPath }/itemImg/${item.item_mainimg }" style="width: 200px;height: 200px;"></span></td>
					</tr>
					<tr>
						<th><label for="product_name_image"><strong>서브
									이미지업로드</strong></label><input type="button" value="서브 썸네일 추가"
							onclick="addFile()"></th>
						<td><input type="file" name="item_subimg"
							id="product_main_image" onchange="setThumbnail(event)"></td>
					</tr>
					<c:forEach var="f" items="${imgs }">
<tr><th></th><td>
<c:if test="${f.name eq thum }"><p>썸네일입니다!</p></c:if>
		<span><img class="smallImg" id="${f.name}" src ="${pageContext.request.contextPath }/itemImg/${path }/${f.name }" style="width: 100px;height: 100px;"><input type="hidden" value="${f.name }">
		<input type="button" name="item_subImg" value="삭제" onclick="deleteImg(this)"> </span></td>
		</tr>
	</c:forEach>
				</table>
			</div>
			<div class="imgNameDiv"></div>

			<table class="table table-striped table-bordered table-hover">
				<colgroup>
					<col width="20%">
					<col width="auto">
				</colgroup>
				<tr>
					<th><label for="editor_admin"><strong>상품 페이지
								내용</strong></label></th>
				</tr>
				<tr>
					<td><textarea id="item_info" name="item_info" class="ckeditor" >
				${item.item_info }
				</textarea>
				<script type="text/javascript">
				CKEDITOR.replace( 'item_info', {
					 filebrowserImageUploadUrl: '${pageContext.request.contextPath}/itemInfoImgUpload.do'
				});
				</script></td>
				</tr>

			</table>

			<div id="hiddenStorage">
			<input type="hidden" id="thum_tf" name="thum_tf" value="${!empty thum?'1':'0' }">
		    <input type="hidden" id="mainimg" value="${thum }"/>
		    <input type="hidden" name="item_mainimg_s" value="${item.item_mainimg }"/>
		      <input type="hidden" id="subimg_tf" name="subimg_tf" value="0">
		      <input type="text" id="imgNum" value="${imgs.size() }">
			</div>
				

			<div class="form-row">
				<div class="form-group col" align="center">
					<button type="submit" class="btn btn-outline-success">상품수정</button>
					<button type="reset" class="btn btn-outline-secondary">다시작성</button>
					<button type="button" class="btn btn-outline-dark">취소</button>
				</div>
			</div>
			
			
			
				</form>				
			
<%@ include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>