<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="//code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="//stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="//stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
</head>
<style>
input::-webkit-input-placeholder { text-align: right;}
input::-moz-placeholder { text-align: right;}
input:-ms-input-placeholder { text-align: right; }
input:-moz-placeholder { text-align: right; }
input::placeholder { text-align: right;}

input:focus::-webkit-input-placeholder {
  opacity: 1;
}
input:focus::-moz-placeholder {
  opacity: 1;
}
input:focus:-ms-input-placeholder {
  opacity: 1;
}
input:focus::-ms-input-placeholder {
  opacity: 1;
}
.radio_box + div{
border-color: #E0E0E0;
}
.radio_box:checked + div{
border-color: #94b8ff;
}
</style>
<script>

window.onload= function(){
	$('#uploadCam').on('change', addFiles);
	cal_change();
	
}

function cal_change(){
	var cal_date = document.getElementById('pet_birth').value;
	console.log(cal_date);
	var cal_arr = cal_date.split('-');
	console.log(cal_arr[0]);
	document.getElementById('birth_year').innerHTML = cal_arr[0];
	document.getElementById('birth_month').innerHTML = cal_arr[1];
	document.getElementById('birth_date').innerHTML = cal_arr[2];
}
var file;

function addFiles(e){
	var image = $('#pet_photo');
	file = e.target.files[0];
	var reader = new FileReader();
   	reader.readAsDataURL(file);
   	reader.onload = function(event) { 
   		image.attr("src", event.target.result);
    }; 
	
}
function update_pet(){
	var formData = new FormData(document.getElementById('update_form'));
	
	if(file!=null){
		console.log('file!=null');
		formData.append('upload',file);
	}
	
	$.ajax({
		url: 'm_walk_app_petUpdate_com.do',
   		method: 'POST',
        data: formData,
        processData: false,
   		contentType: false,
        success: function () {
        	Android.pet_setting_com("반려동물 수정되었습니다.");
        },
        error: function () {
        },
	});
}
function delete_pet(pet_idx){
	$.ajax({
		url: 'pet_delete.do',
   		method: 'POST',
        data: {'pet_idx': pet_idx},
        contentType : "application/x-www-form-urlencoded; charset=utf-8",
        dataType : "json",
        success: function () {
        	Android.pet_setting_com("반려동물 삭제되었습니다.");
        },
        error: function () {
        	
        },
	});
}
</script>
<body>
<div id="contaner">
		
		<div class="col-xs-12" style="margin-top: 25px;">
			<input id="uploadCam" type="file" accept="image/*;capture=camera" style="display:none;">
			<div id="pet_photo_form" style="width: 200px; height: 200px; line-height: 200px;  border-radius: 100%; margin: 0px auto; overflow: hidden; border-style: solid; text-align: center; border-width: 2px;" onclick="$('#uploadCam').click();">
				<img id="pet_photo" src="${pageContext.request.contextPath}/pet/${dto.pet_idx}/profile.png" style="width:200px; height: 200px;"> 
			</div>
		</div>
		
		
		<form id="update_form">
		<input type="hidden" name="pet_idx" value="${dto.pet_idx}">
		<div class="col-xs-12" style="margin-top: 25px;">
			<div class="col-xs-12">이름</div>
		</div>
		<div class="col-xs-12">
			<div class="col-xs-12">
				<div style="border-bottom: solid; border-width: 2px; border-color: #94b8ff; height: 40px;">
					<input type="text" name="pet_name" value="${dto.pet_name}" style="font-size: 20px; border-style: none;">
				</div>
			</div>
		</div>
		<div id="pet_sex_form" class="col-xs-12" style="margin-top: 25px;">
			<div class="col-xs-12" style="margin: 0px auto; margin-bottom: 10px;">성별</div>
			<div class="col-xs-6">
				<input id="sex_male" class="radio_box" type="radio" name="pet_sex" value="male" style="display: none;" ${dto.pet_sex == "male"? "checked":""}>
				<div style="width: 100%; height: 85px; margin: 2%;  display: inline-block; border-radius: 15px; border-style: solid; border-width: 2px;" onclick="$('#sex_male').prop('checked', true);">
					<div style=" width: 100%; height: 100%;">
						<div style="width: 50px; height: 50px; margin: 0px auto; margin-top: 5px; background-image: url('${pageContext.request.contextPath}/images/male_icon.png'); background-size: cover;"></div>
						<div style="width: 100%; height: 20px; margin: 0px auto;  margin-top: 5px; text-align: center; font-size: 15px;">남아</div>
					</div>
				</div>
			</div>
			<div class="col-xs-6">
				<input id="sex_female" class="radio_box" type="radio" name="pet_sex" value="female" style="display: none;" ${dto.pet_sex != "male"? "checked":""}>
				<div style="width: 100%; height: 85px; margin: 3%; display: inline-block; border-radius: 15px; border-style: solid; border-width: 2px;" onclick="$('#sex_female').prop('checked', true);">
					<div style=" width: 100%; height: 100%;">
						<div style="width: 40px; height: 57px; margin: 0px auto; margin-top: 2px; background-image: url('${pageContext.request.contextPath}/images/female_icon.png'); background-size: cover;"></div>
						<div style="width: 100%; height: 20px; margin: 0px auto; text-align: center; font-size: 15px;">여아</div>
					</div>
				</div>
			</div>
		</div>
		
		<div id="eat_kind_form" class="col-xs-12" style="margin-top: 25px;">
			<div class="col-xs-12" style="margin: 0px auto; margin-bottom: 10px;"">반려동물 종</div>
			<div class="col-xs-6">
				<input id="type_dog" class="radio_box" type="radio" name="pet_type" value="dog" style="display: none;" ${dto.pet_type == "dog"? "checked":""}>
				<div style="width: 100%; height: 85px; margin: 2%; display: inline-block; border-radius: 15px; border-style: solid; border-width: 2px;" onclick="$('#type_dog').prop('checked', true);">
					<div style=" width: 100%; height: 100%;">
						<div style="width: 50px; height: 50px; margin: 0px auto;  margin-top:5px; background-image: url('${pageContext.request.contextPath}/images/feed_icon.png'); background-size: cover;"></div>
						<div style="width: 100%; height: 20px; margin: 0px auto;  margin-top:5px; text-align: center; font-size: 15px;">강아지</div>
					</div>
				</div>
			</div>
			<div class="col-xs-6">
				<input id="type_cat" class="radio_box" type="radio" name="pet_type" value="cat" style="display: none;" ${dto.pet_type != "dog"? "checked":""}>
				<div style="width: 100%; height: 85px; margin: 3%; display: inline-block; border-radius: 15px; border-style: solid; border-width: 2px;" onclick="$('#type_cat').prop('checked', true);">
					<div style=" width: 100%; height: 100%;">
						<div style="width: 50px; height: 50px; margin: 0px auto;  margin-top:5px; background-image: url('${pageContext.request.contextPath}/images/snack_icon.png'); background-size: cover;"></div>
						<div style="width: 100%; height: 20px; margin: 0px auto;  margin-top:5px; text-align: center; font-size: 15px;">고양이</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-xs-12" style="margin-top: 25px;">
			<div class="col-xs-12">반려동물 상세 종</div>
		</div>
		<div class="col-xs-12">
			<div class="col-xs-12">
				<div style="border-bottom: solid; border-width: 2px; border-color: #94b8ff; height: 40px;">
					<input type="text" name="pet_kind" value="${dto.pet_kind}" placeholder="" style="font-size: 20px; border-style: none;">
				</div>
			</div>
		</div>
		
		<div class="col-xs-12" style="margin-top: 25px;">
			<div class="col-xs-12">반려동물 생일</div>
		</div>
		<div class="col-xs-12">
			<div class="col-xs-12">
				<input id="pet_birth" type="date" name="pet_birth" style="visibility: hidden;" value="${dto.pet_birth}" onchange="cal_change();">
				<div class="col-xs-12" onclick="$('#pet_birth').click();" style="border-style: solid; border-radius: 10px; border-width: 2px; border-color: #94b8ff; height: 60px; width: 100%; margin: 0px auto;">
					<div class="col-xs-4" style="float:left; text-align: center; line-height: 60px;">
						<span id="birth_year"></span>
						<span>년</span>
					</div>
					<div class="col-xs-4" style="float:left; text-align: center; line-height: 60px;">
						<span id="birth_month"></span>
						<span>월</span>
					</div>
					<div class="col-xs-4" style="float:left; text-align: center; line-height: 60px;">
						<span id="birth_date"></span>
						<span>일</span>
					</div>
				</div>
			</div>
		</div>
		
		<div id="eat_kind_form" class="col-xs-12" style="margin-top: 25px;">
			<div class="col-xs-12" style="margin: 0px auto; margin-bottom: 10px;"">중성화 여부</div>
			<div class="col-xs-6">
				<input id="neuter_do" class="radio_box" type="radio" name="pet_neuter" value="done" style="display: none;" ${dto.pet_neuter == "done"? "checked":""}>
				<div style="width: 100%; height: 85px; margin: 2%; display: inline-block; border-radius: 15px; border-style: solid; border-width: 2px;" onclick="$('#neuter_do').prop('checked', true);">
					<div style=" width: 100%; height: 100%;">
						<div style="width: 50px; height: 50px; margin: 0px auto;  margin-top:5px; background-image: url('${pageContext.request.contextPath}/images/ok_icon.png'); background-size: cover;"></div>
						<div style="width: 100%; height: 20px; margin: 0px auto;  margin-top:5px; text-align: center; font-size: 15px;">했음</div>
					</div>
				</div>
			</div>
			<div class="col-xs-6">
				<input id="neuter_notdo" class="radio_box" type="radio" name="pet_neuter" value="notdone" style="display: none;" ${dto.pet_neuter != "done"? "checked":""}>
				<div style="width: 100%; height: 85px; margin: 3%; display: inline-block; border-radius: 15px; border-style: solid; border-width: 2px;" onclick="$('#neuter_notdo').prop('checked', true);">
					<div style=" width: 100%; height: 100%;">
						<div style="width: 50px; height: 50px; margin: 0px auto;  margin-top:5px; background-image: url('${pageContext.request.contextPath}/images/no_icon.png'); background-size: cover;"></div>
						<div style="width: 100%; height: 20px; margin: 0px auto;  margin-top:5px; text-align: center; font-size: 15px;">안했음</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-xs-12" style="margin-top: 25px;">
			<div class="col-xs-12">반려동물 몸무게</div>
		</div>
		<div class="col-xs-12">
			<div class="col-xs-12">
				<div style="border-bottom: solid; border-width: 2px; border-color: #94b8ff; height: 40px;">
					<input type="number" name="pet_weight" placeholder="Kg" value="${dto.pet_weight}" style="font-size: 20px; text-align:center; border-style: none;">
				</div>
			</div>
		</div>
		</form>
		
		<div class="col-xs-12" style="margin-top: 35px; height: 80px; line-height: 80px; background-color: #94b8ff; color: white; text-align: center;" onclick="update_pet();">수정하기</div>
		<div class="col-xs-12" style=" height: 80px; line-height: 80px; background-color: red; color: white; text-align: center;"  onclick="delete_pet('${dto.pet_idx}');">삭제하기</div>
</div>
</body>
</html>