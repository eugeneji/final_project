<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="//code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="//fengyuanchen.github.io/cropper/js/cropper.js"></script>
<link rel="stylesheet" type="text/css" href="//fengyuanchen.github.io/cropperjs/css/cropper.css">
<link rel="stylesheet" href="//stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="//stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">

<script>
var canvas;

if(${empty sessionScope.s_user}){
	location.href='index.do';
}
var user_idx = '${sessionScope.s_user.user_idx}';


$(function(){
	var cropper;
    // 사진 업로드 버튼
    $('#photoBtn').on('change', function(){
        $('.them_img').empty().append('<img id="image" src="">');
        var image = $('#image');
        var imgFile = $('#photoBtn').val();
        var fileForm = /(.*?)\.(jpg|jpeg|png)$/;
		
        // 이미지가 확장자 확인 후 노출
        if(imgFile.match(fileForm)) {
        	var reader = new FileReader();
        	reader.onload = function(event) { 
        		image.attr("src", event.target.result);
        		cropper = image.cropper( {
        			dragMode: 'move',
        			viewMode:1,
        			aspectRatio: 1,
        			autoCropArea:0.9,
        			minCropBoxWidth:200,
       				restore: false,
                    guides: false,
                    center: false,
                    highlight: false,
                    cropBoxMovable: false,
                    cropBoxResizable: false,
                    toggleDragModeOnDblclick: false
                });
            }; 
        	reader.readAsDataURL(event.target.files[0]);
        } else{
        	alert("이미지 파일(jpg, png형식의 파일)만 올려주세요");
        	$('#photoBtn').focus();
        	return; 
        }
	});
    // 사진 다시 올리기 버튼
    $('#resetPhoto').on('click', function(){
        if($('input[type="file"]').val() != ""){
        	$('#photoBtn').val('');
        	$('.them_img img').attr('src','').remove();
        	$('.btn_wrap a:last-child').removeClass('bg1');
        	$('input[type="file"]').click();
        }else{
        	//alert('업로드된 사진이 없습니다.');
        }
    });
    // 업로드 버튼
    $('#complete').on('click', function(){
    	$('.them_img').append('<div class="result_box"><img id="result" src=""></div>');
    	var image = $('#image');
    	var result = $('#result');
    	if($('input[type="file"]').val() != ""){
    	canvas = image.cropper('getCroppedCanvas',{
    		width:200,
    		height:200
    	});
    	result.attr('src',canvas.toDataURL("image/jpg"));
    	$('#pet_photo').attr('src',canvas.toDataURL("image/jpg"));
    	$('#upload_photo').css('display','none');
    	$('#bg_black').css('display','none');
    	
      }else{
          alert('보내실 얼굴을 업로드 해주세요');
          $('input[type="file"]').focus();
          return;
      }
    });
});

function showImageUpload(){
	document.getElementById('upload_photo').style.display = 'block';
	document.getElementById('bg_black').style.display = 'block';
}

function register_upload(){
	var pet_name = document.getElementById('pet_name').value;
	var pet_type = document.getElementsByName('pet_type');
	for(var i=0; i<pet_type.length; i++){
		if(pet_type[i].checked){
			pet_type = pet_type[i].value;
		}
	}
	var pet_kind = '장지웅';
	var pet_birth = document.getElementById('pet_birth').value;
	var pet_sex = document.getElementsByName('pet_sex');
	for(var i=0; i<pet_sex.length; i++){
		if(pet_sex[i].checked){
			pet_sex = pet_sex[i].value;
		}
	}
	var pet_neuter = document.getElementsByName('pet_neuter');
	for(var i=0; i<pet_neuter.length; i++){
		if(pet_neuter[i].checked){
			pet_neuter = pet_neuter[i].value;
		}
	}
	var pet_weight = document.getElementById('pet_weight').value;
	
	var formData = new FormData();
	formData.append('pet_name', pet_name);
	formData.append('pet_type', pet_type);
	formData.append('pet_kind', pet_kind);
	formData.append('pet_birth', pet_birth);
	formData.append('pet_sex', pet_sex);
	formData.append('pet_neuter', pet_neuter);
	formData.append('pet_weight', pet_weight); 
	formData.append('user_idx', user_idx);
	
	if(canvas!=null){
		canvas.toBlob(function (blob) {//해당 blob이 function 바깥으로 나가면 없어짐. 전역변수에 담아도 function 바깥으로 나가면 변수에 담아둔 값이 사라짐. 이유 모르겠음
			formData.append('blob',blob);
			$.ajax({
				url: 'pet_register_com.do',
		   		method: 'POST',
		        data: formData,
		        processData: false,
		   		contentType: false,
		        success: function () {
		        	if(${empty beforeURL}){
		        		location.href='pet_list.do';
		        		console.log(${empty beforeURL});
		        	}else{
		        		location.href='${beforeURL}';
		        	}
		        },
		        error: function () {
		        	alert('업로드 실패');
		        	$('.result_box').remove();
		        },
			});
		});
	}else{
		$.ajax({
			url: 'pet_register_com.do',
	   		method: 'POST',
	        data: formData,
	        processData: false,
	   		contentType: false,
	        success: function () {
	        	location.href='${beforeURL}';
	        },
	        error: function () {
	        	alert('업로드 실패');
	        	$('.result_box').remove()
	        },
		});
	}
	
}
function close_upload(){
	document.getElementById('bg_black').style.display = 'none';
	document.getElementById('upload_photo').style.display = 'none';
}
</script>
<style>

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
input[type=radio] + label{
font-size: 20px;
margin-left: 10px;
}
</style>
</head>
<body>
<%@ include file="../header.jsp" %>
<div id="bg_black"></div>
<div id="upload_photo" style="">
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
<div id="contaner" style="padding-top: 150px; font-family: 'Jua', sans-serif;">
<div style="margin: 0px auto; width: 600px;">
<section class="col-xs-12 col-sm-12 col-md-12" id="pet_register_form" style="margin: 0px auto; width: 600px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.35); border-radius: 15px;">
		<h1 style="text-align: center; margin-top: 20px;">반려동물 등록</h1>
		<div id="pet_photo_form" style="width: 200px; height: 200px;  border-radius: 100%; margin: 0px auto; overflow: hidden; border-style: solid; border-width: 1px;" onclick="showImageUpload();">
			<img id="pet_photo" src="${pageContext.request.contextPath}/images/plus_icon.png" style="width:200px; height: 200px;"> 
		</div>
		
	<form id="pet_register_data" class="col-xs-12 col-sm-12 col-md-12" style="margin-top: 30px; height: 100%;" action="pet_register_com.do" method="post">
		<div id="pet_name_form" class="col-xs-12 col-sm-12 col-md-12" style="margin:0px auto; height: 50px; line-height: 50px;">
			<div class="col-xs-4 col-sm-4 col-md-4" style="font-size: 17px;">이름</div>
			<div class="col-xs-8 col-sm-8 col-md-8">
				<input type="text" name="pet_name" id="pet_name">
			</div>
		</div>
		<div id="pet_sex_form" class="col-xs-12 col-sm-12 col-md-12" style="margin:0px auto; height: 50px; line-height: 50px;">
			<div class="col-xs-4 col-sm-4 col-md-4" style="font-size: 17px;">성별</div>
			<div class="col-xs-8 col-sm-8 col-md-8">
				<div class="col-xs-6 col-sm-6 col-md-6"><input id="radio_male" type="radio" name="pet_sex" value="male" checked><label style="margin-bottom: 0px;" for="radio_male">남자</label></div>
				<div class="col-xs-6 col-sm-6 col-md-6"><input id="radio_female" type="radio" name="pet_sex" value="female"><label style="margin-bottom: 0px;" for="radio_female">여자</label></div>
			</div>
			
		</div>
		<div id="pet_type_form" class="col-xs-12 col-sm-12 col-md-12" style="margin:0px auto; height: 50px; line-height: 50px;">
			<div class="col-xs-4 col-sm-4 col-md-4" style="font-size: 17px;">반려동물 종</div>
			<div class="col-xs-8 col-sm-8 col-md-8">
				<div class="col-xs-6 col-sm-6 col-md-6"><input id="radio_dog" type="radio" name="pet_type" value="dog" checked><label style="margin-bottom: 0px;" for="radio_dog">강아지</label></div>
				<div class="col-xs-6 col-sm-6 col-md-6"><input id="radio_cat" type="radio" name="pet_type" value="cat"><label style="margin-bottom: 0px;" for="radio_cat">고양이</label></div>
			</div>
		</div>
		<div id="pet_kind_form" class="col-xs-12 col-sm-12 col-md-12" style="margin:0px auto; height: 50px; line-height: 50px;">
			<div class="col-xs-4 col-sm-4 col-md-4" style="font-size: 17px;">반려동물 상세 종</div>
			<div class="col-xs-8 col-sm-8 col-md-8">
				<input type="text" name="pet_name" id="pet_name">
			</div>
		</div>
		<div id="pet_birth_form" class="col-xs-12 col-sm-12 col-md-12" style="margin:0px auto; height: 50px; line-height: 50px;">
			<div class="col-xs-4 col-sm-4 col-md-4" style="font-size: 17px;">반려동물 생일</div>
			<div class="col-xs-8 col-sm-8 col-md-8">
				<input type="date" name="pet_birth" id="pet_birth">
			</div>
		</div>
		<div id="pet_neuter_form" class="col-xs-12 col-sm-12 col-md-12" style="margin:0px auto; height: 50px; line-height: 50px;">
			<div class="col-xs-4 col-sm-4 col-md-4" style="font-size: 17px;">중성화 여부</div>
			<div class="col-xs-8 col-sm-8 col-md-8">
				<div class="col-xs-6 col-sm-6 col-md-6"><input id="radio_done" type="radio" name="pet_neuter" value="done"><label style="margin-bottom: 0px;" for="radio_done">했어요</label></div>
				<div class="col-xs-6 col-sm-6 col-md-6"><input  id="radio_notdone" type="radio" name="pet_neuter" value="notdone"><label style="margin-bottom: 0px;" for="radio_notdone">안 했어요</label></div>
			</div>
		</div>
		<div id="pet_weight_form" class="col-xs-12 col-sm-12 col-md-12" style="margin:0px auto; height: 50px; line-height: 50px;">
			<div class="col-xs-4 col-sm-4 col-md-4" style="font-size: 17px;">반려동물 몸무게</div>
			<div class="col-xs-8 col-sm-8 col-md-8">
				<input type="number" id="pet_weight" style="width: 80%;"><span>kg</span>
			</div>
		</div>
		<div id="submit_form" class="col-xs-12 col-sm-12 col-md-12" style="margin:0px auto; height: 50px; line-height: 50px; margin-bottom: 10px;">
			<div class="col-xs-12 col-sm-12 col-md-12">
				<input type="button" onclick="register_upload();" style=" width: 100%; font-size: 17px;" value="등록하기">
			</div>
		</div>
	</form>
</section>
</div>
</div>
<div class="col-xs-12 col-sm-12 col-md-12" style="width: 100vw; padding: 0px;">
	<%@ include file="../footer.jsp" %>
</div>
</body>
</html>