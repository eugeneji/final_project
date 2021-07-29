<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
function Back(){
	window.history.back();
}
</script>
<script>
var canvas;
$(function() {
	var cropper;
	// 사진 업로드 버튼
	$('#photoBtn').on('change', function() {
		$('.them_img').empty().append('<img id="image" src="">');
		var image = $('#image');
		var imgFile = $('#photoBtn').val();
		var fileForm = /(.*?)\.(jpg|jpeg|png)$/;

		// 이미지가 확장자 확인 후 노출
		if (imgFile.match(fileForm)) {
			var reader = new FileReader();
			reader.onload = function(event) {
				image.attr("src", event.target.result);
				cropper = image.cropper({
					dragMode : 'move',
					viewMode : 1,
					aspectRatio : 1,
					autoCropArea : 0.9,
					minCropBoxWidth : 200,
					restore : false,
					guides : false,
					center : false,
					highlight : false,
					cropBoxMovable : false,
					cropBoxResizable : false,
					toggleDragModeOnDblclick : false
				});
			};
			reader.readAsDataURL(event.target.files[0]);
		} else {
			alert("이미지 파일(jpg, png형식의 파일)만 올려주세요");
			$('#photoBtn').focus();
			return;
		}
	});
	// 사진 다시 올리기 버튼
	$('#resetPhoto').on('click', function() {
		if ($('input[type="file"]').val() != "") {
			$('#photoBtn').val('');
			$('.them_img img').attr('src', '').remove();
			$('.btn_wrap a:last-child').removeClass('bg1');
			$('input[type="file"]').click();
		} else {
			//alert('업로드된 사진이 없습니다.');
		}
	});
	// 업로드 버튼
	$('#complete')
			.on(
					'click',
					function() {
						$('.them_img')
								.append(
										'<div class="result_box"><img id="result" src=""></div>');
						var image = $('#image');
						var result = $('#result');
						if ($('input[type="file"]').val() != "") {
							canvas = image.cropper('getCroppedCanvas', {
								width : 200,
								height : 200
							});
							result.attr('src', canvas
									.toDataURL("image/jpg"));
							$('#pet_photo').attr('src',
									canvas.toDataURL("image/jpg"));
							$('#upload_photo').css('display', 'none');
							$('#bg_black').css('display', 'none');
							$('#img_form').css('display', 'block');
						} else {
							alert('보내실 얼굴을 업로드 해주세요');
							$('input[type="file"]').focus();
							return;
						}
					});
});

function showImageUpload() {
	document.getElementById('upload_photo').style.display = 'block';
	document.getElementById('bg_black').style.display = 'block';
}

function close_upload(){
	document.getElementById('bg_black').style.display = 'none';
	document.getElementById('upload_photo').style.display = 'none';
}
</script>
<style>

.col-6{
	display: inline-block;
}

.buttonClass{
	display:inline-block;
	margin-bottom: 20%;
}
#bg_black{
position: fixed;
width: 100%;
height: 100%;
background-color:rgba(0, 0,0, 0.5);
top:0;
left: 0;
bottom: 0;
z-index: 1;
display:none;
}
.photo_box{
margin:0 auto ;
width:50vw;
} 
.upload_btn{
overflow:hidden;
width:100%;
padding: 10px;
}
.upload_btn #photoBtn{
display:none;
}
.upload_btn .upload, .upload_btn a{
float:left;width:calc(50% - 10px);
text-align:center;
text-decoration: none;
color:#fff;
padding:15px 0;
}
.upload_btn .upload{
background-color:steelblue;
} 
.upload_btn a{
margin-left:20px; 
background:#ccc;

}
.photo_them{
position:relative;
width:100%;
height:250px;
background:#eee;
}
.them_img, .result_box{
position:absolute;
top:0;
left:0;
width:100%;
height:100%;
}
.result_box{
background:#fff;
}
.them_img img, .result_box img{
display:block;
margin:0 auto;
height:100%;
box-shadow: 0 0 10px rgba(0, 0, 0, 0.35);
}
.cropper-crop-box, .cropper-view-box {
    border-radius: 50%;
}
.cropper-view-box {
    box-shadow: 0 0 0 1px #39f;
    outline: 0;
}
#upload_photo{
display: none;
position: fixed;
z-index: 2;
margin: 0px auto;
background-color: white;
margin-top: 25vh;
margin-left: 25vw;
font-size: 17px;
}
</style>
<link rel="stylesheet" href="//stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="//stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<body>
<div id="bg_black"></div>
<div id="upload_photo">
	<div class="modal_close" style="width:50px; height: 50px; position: absolute; right: -60px; background-image:url('${pageContext.request.contextPath}/images/close.png'); background-size: cover;cursor: pointer;" onclick="close_upload();"></div>
	<div class="photo_box">
		<div class="photo_them">
	    	<div class="them_img">
	    		<img id="image" src="">
	    	</div>
	  	</div>
	  	<div class="upload_btn">
			<div class="upload" style="background:#ccc;">
		    	<input type="file" name="pet_photo_file" accept="image/jpeg, image/png" capture="camera" id="photoBtn"><label for="photoBtn">사진 첨부하기</label>
		    </div>
		    <div id="complete" class="upload" style="margin-left: 20px; cursor: pointer;"><label style="cursor: pointer;">업로드</label></div>
		</div>
	</div>
</div>
<%@ include file="../header.jsp" %>
<div class="container" style="padding-top: 150px;">
  	<div>
  		
  		<form action="userEdit.do" method="POST">
		<h1 id="sub" style="width: 100%; text-align: center;">회원정보 수정</h1>
	    <input type="hidden" name="user_idx" value="${dto.user_idx}">	
	    <div class="row" style="margin-bottom: 20px;">
	    	<div class='col-xs-6' style="margin: 0px auto">
	    		<img src="${pageContext.request.contextPath}/user/${dto.user_idx}/profile.png" style="width: 200px; height: 200px; margin: 0px auto; display: block;">
	    	</div>
	    </div>
	    	<div class="row" style="margin-bottom: 20px;">
		     	<div class='col-xs-6' style="margin: 0px auto;">
			      	<label>아이디</label><input type="text" name="user_email" value="${dto.user_email}" readonly="readonly" required="required" class="form-control" id="exampleDropdownFormEmail2">
		      	</div>
	      	</div>
	      	<div class="row" style="margin-bottom: 20px;">
	       <div class='col-xs-6' style="margin: 0px auto;">
	      	<label>닉네임</label><input type="text" name="user_nickname" value="${dto.user_nickname}" class="form-control" id="exampleDropdownFormEmail2">
	      </div>
	      </div>
	      <div class="row" style="margin-bottom: 20px;">
	      <div class='col-xs-6'  style="margin: 0px auto;">
	      	<label>전화번호</label><input type="text" name="user_tel" value="${dto.user_tel}" class="form-control" id="exampleDropdownFormEmail2">
	      </div>
	      </div>
	      <div class="row" style="margin-bottom: 20px;">
	       <div class='col-xs-6'  style="margin: 0px auto;">
	      	<label>주소</label><input type="text" name="user_addr" value="${dto.user_addr}" class="form-control" id="exampleDropdownFormEmail2" >
	      </div>
	      </div>
	      <div class="row" style="margin-bottom: 20px;">
	      <div class='col-xs-6'  style="margin: 0px auto;">
	      	<label>상세주소</label><input type="text" name="user_addr_detail" value="${dto.user_addr_detail}" class="form-control" id="exampleDropdownFormEmail2">
	      </div>
	      </div>
	      <div class="row" style="margin-bottom: 20px;">
		      <div class='buttonClass' style="text-align: center; width: 100%;" >
		      <input type="submit" value="수정 완료하기" class="btn btn-primary" id="button1">
		      <input type="button" value="뒤로가기" class="btn btn-primary" id="button2" onclick="Back();">
		      </div>
	      </div>
		</form>
	</div>
</div>
<%@ include file="../footer.jsp" %>
</body>
</html>
