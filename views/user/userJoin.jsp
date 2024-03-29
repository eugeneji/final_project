<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel='stylesheet'
	href='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css' />
<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="js/httpRequest.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://fengyuanchen.github.io/cropper/js/cropper.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://fengyuanchen.github.io/cropperjs/css/cropper.css">
<script>
	function searchAddress() {
		var q = document.getElementById('addr').value; //검색 내용
		//ajax 시작
		if (q) {
			$
					.ajax(
							{
								url : 'https://dapi.kakao.com/v2/local/search/address.json',
								headers : {
									'Authorization' : 'KakaoAK 3d2dbf77d9a9ba6a4c73493da5d7fc07'
								},
								type : 'GET',
								data : {
									'query' : q
								},
								success : function(data) {
									//호출 성공하면 작성할 내용
									if (data.documents.length != 0) { // 값이 있으면

										var result = "";
										for (var i = 0; i < data.documents.length; i++) {

											if (data.documents[i].address.region_3depth_h_name
													|| data.documents[i].address.region_3depth_name) {
												result += '<div onclick="showAddr(this)">'
														+ data.documents[i].address_name
														+ '<input type="hidden" name="x" value='+data.documents[i].x+'><input type="hidden" name="y" value='+data.documents[i].y+'></div>';

											}
										}
										document.getElementById('searchAddr').style.display = '';
										document.getElementById('searchAddr').innerHTML = result;
										/* "<a onclick='showAddr(this);'>"+data.documents[i].address_name+"</a><br>"; */
									}
								},
								error : function(request, status, error) {
									alert("code:" + request.status + "\n"
											+ "message:" + request.responseText
											+ "\n" + "error:" + error);
								}
							}).done(function(data) {
						console.log(data);
					});
		} else {
			document.getElementById('searchAddr').style.display = 'none';
		}
	}

	function showAddr(addr) {
		document.getElementById('addr').value = addr.innerText;
		document.getElementById('x').value = addr.firstChild.nextSibling.value;
		document.getElementById('y').value = addr.firstChild.nextSibling.nextSibling.value;
		document.getElementById('searchAddr').style.display = 'none';
	}

	function addrReset() {
		document.getElementById('addr').value = null;
		document.getElementById('searchAddr').style.display = 'none';
	}

	$(function() {
		$('#userPwd').keyup(function() {
			$('#chkNotice').html('');
		});

		$('#userPwdChk').keyup(function() {

			if ($('#userPwd').val() != $('#userPwdChk').val()) {
				$('#chkfont').html('<br>비밀번호 일치하지 않습니다!<br>');
				$('#chkfont').attr('color', '#FF0000');
				$("#joinbtn").prop("disabled", true);
			} else {
				$('#chkfont').html('<br>비밀번호 일치합니다!<br>');
				$('#chkfont').attr('color', '#0000FF');
				$("#joinbtn").prop("disabled", false);
			}

		});
	});
</script>
<script>
	var id = true;
	function show() {
		var user_email = document.userJoin.user_email.value;
		if (user_email == '') {
			var spanNode = document.all.idCheckMsg;
			spanNode.innerHTML = '<br>' + '아이디를 입력해주세요';
			spanNode.style.color = 'red';
			return;
		}
		var params = 'user_email=' + user_email;
		sendRequest('idCheck.do', params, showResult, 'GET');
	}
	function showResult() {
		if (XHR.readyState == 4) {
			if (XHR.status == 200) {
				var data = XHR.responseText;
				data = eval('(' + data + ')');
				var spanNode = document.all.idCheckMsg;
				spanNode.innerHTML = '<br>' + data.msg;
				spanNode.style.color = 'red';
				id = data.result;
			}
		}
	}
	function joinValidation() {
		if (id) {
			return false;
		} else {
			return true;
		}
	}

	//==========================================================장지웅 추가
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

	function register_upload() {
		var formData = new FormData(document
				.getElementById('userJoin_form_woo'));

		if (canvas != null) {
			canvas.toBlob(function(blob) {//해당 blob이 function 바깥으로 나가면 없어짐. 전역변수에 담아도 function 바깥으로 나가면 변수에 담아둔 값이 사라짐. 이유 모르겠음
				formData.append('blob', blob);
				$.ajax({
					url : 'userJoin.do',
					method : 'POST',
					data : formData,
					processData : false,
					contentType : false,
					success : function() {
						alert('회원가입 완료!');
						location.href = 'index.do';
					},
					error : function() {
						alert('회원가입 실패!');
						location.href = 'index.do';
					},
				});
			});
		} else {
			$.ajax({
				url : 'userJoin.do',
				method : 'POST',
				data : formData,
				processData : false,
				contentType : false,
				success : function() {
					alert('회원가입 완료!');
					location.href = 'index.do';
				},
				error : function() {
					alert('회원가입 실패!');
					location.href = 'index.do';
				},
			});
		}

	}
	function close_upload(){
		document.getElementById('bg_black').style.display = 'none';
		document.getElementById('upload_photo').style.display = 'none';
	}
	//==========================================================================================
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
</style>
</head>
<body>
<%@ include file="../header.jsp" %>
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
<div class='container' style="padding-top: 150px;">
<h2 style="text-align: center;">회 원 가 입</h2>
	<div>
	<div class="row">
	  <div class="col-12">
		<textarea cols="110" rows="10" readonly="readonly" class="form-control">제 1 조 (목적)
1. 본 약관은 ㈜Morepet 사이트가 제공하는 모든 서비스(이하 "서비스")의 이용조건 및 절차, 이용자와  ㈜Morepet 사이트의 권리, 의무, 책임사항과 기타 필요한 사항을 규정함을 목적으로 합니다.
제 2 조 (약관의 효력과 변경)
1.  ㈜Morepet 사이트는 귀하가 본 약관 내용에 동의하는 경우  ㈜Morepet 사이트의 서비스 제공 행위 및 귀하의 서비스 사용 행위에 본 약관이 우선적으로 적용됩니다.
2.  ㈜Morepet 사이트는 본 약관을 사전 고지 없이 변경할 수 있고 변경된 약관은  ㈜Morepet 사이트 내에 공지하거나 e-mail을 통해 회원에게 공지하며, 공지와 동시에 그 효력이 발생됩니다.
이용자가 변경된 약관에 동의하지 않는 경우, 이용자는 본인의 회원등록을 취소 (회원탈락)할 수 있으며 계속 사용의 경우는 약관 변경에 대한 동의로 간주 됩니다.
제 3 조 (약관 외 준칙)
1. 본 약관에 명시되지 않은 사항은 전기통신기본법, 전기통신사업법, 정보통신윤리위원회심의규정, 정보통신 윤리강령, 프로그램보호법 및 기타 관련 법령의 규정에 의합니다.
제 4 조 (용어의 정의)
본 약관에서 사용하는 용어의 정의는 다음과 같습니다.

1. 이용자 : 본 약관에 따라  ㈜Morepet 사이트가 제공하는 서비스를 받는 자.
2. 가입 :  ㈜Morepet 사이트가 제공하는 신청서 양식에 해당 정보를 기입하고, 본 약관에 동의하여 서비스 이용계약을 완료시키는 행위.
3. 회원 :  ㈜Morepet 사이트에 개인 정보를 제공하여 회원 등록을 한 자로서  ㈜Morepet 사이트가 제공하는 서비스를 이용할 수 있는 자.
4. 비밀번호 : 이용자와 회원ID가 일치하는지를 확인하고 통신상의 자신의 비밀보호를 위하여 이용자 자신이 선정한 문자와 숫자의 조합.
5. 탈퇴 : 회원이 이용계약을 종료시키는 행위.
제 2 장 서비스 제공 및 이용
제 5 조 (이용계약의 성립)
1. 이용계약은 신청자가 온라인으로  ㈜Morepet 사이트에서 제공하는 소정의 가입신청 양식에서 요구하는 사항을 기록하여 가입을 완료하는 것으로 성립됩니다.
2.  ㈜Morepet 사이트는 다음 각 호에 해당하는 이용계약에 대하여는 가입을 취소할 수 있습니다.
① 다른 사람의 명의를 사용하여 신청하였을 때
② 이용계약 신청서의 내용을 허위로 기재하였거나 신청하였을 때
③ 다른 사람의  ㈜Morepet 사이트 서비스 이용을 방해하거나 그 정보를 도용하는 등의 행위를 하였을 때
④  ㈜Morepet 사이트를 이용하여 법령과 본 약관이 금지하는 행위를 하는 경우
⑤ 기타  ㈜Morepet 사이트가 정한 이용신청요건이 미비 되었을 때
제 6 조 (회원정보 사용에 대한 동의)
1. 회원의 개인정보는 공공기관의 개인정보보호에 관한 법률에 의해 보호됩니다.
2.  ㈜Morepet 사이트의 회원 정보는 다음과 같이 사용, 관리, 보호됩니다.
① 개인정보의 사용 :  ㈜Morepet 사이트는 서비스 제공과 관련해서 수집된 회원의 신상정보를 본인의 승낙 없이 제3자에게 누설, 배포하지 않습니다.
단, 전기통신기본법 등 법률의 규정에 의해 국가기관의 요구가 있는 경우, 범죄에 대한 수사상의 목적이 있거나 정보통신윤리 위원회의 요청이 있는 경우 또는 기타 관계법령에서 정한 절차에 따른 요청이 있는 경우, 귀하가  ㈜Morepet 사이트에 제공한 개인정보를 스스로 공개한 경우에는 그러하지 않습니다.
② 개인정보의 관리 : 귀하는 개인정보의 보호 및 관리를 위하여 서비스의 개인정보관리에서 수시로 귀하의 개인정보를 수정/삭제할 수 있습니다.
③ 개인정보의 보호 : 귀하의 개인정보는 오직 귀하만이 열람/수정/삭제 할 수 있으며, 이는 전적으로 귀하의 ID와 비밀번호에 의해 관리되고 있습니다.
따라서 타인에게 본인의 ID와 비밀번호를 알려주어서는 안되며, 작업 종료 시에는 반드시 로그아웃 해 주시기 바랍니다.
3. 회원이 본 약관에 따라 이용신청을 하는 것은,  ㈜Morepet 사이트가 신청서에 기재된 회원정보를 수집, 이용하는 것에 동의하는 것으로 간주됩니다.
제 7 조 (사용자의 정보 보안)
1. 가입 신청자가  ㈜Morepet 사이트 서비스 가입 절차를 완료하는 순간부터 귀하는 입력한 정보의 비밀을 유지할 책임이 있으며, 회원의 ID와 비밀번호를 사용하여 발생하는 모든 결과에 대한 책임은 회원 본인에게 있습니다.
2. ID와 비밀번호에 관한 모든 관리의 책임은 회원에게 있으며, 회원의 ID나 비밀번호가 부정하게 사용 되었다는 사실을 발견한 경우에는 즉시  ㈜Morepet 사이트에 신고하여야 합니다. 신고를 하지 않음으로 인한 모든 책임은 회원 본인에게 있습니다. 종료하지 아니함으로써 제3자가 귀하에 관한 정보를 이용하게 되는 등의 결과로 인해 발생하는 손해 및 손실에 대하여  ㈜Morepet 사이트는 책임을 부담하지 아니합니다.
제 8 조 (서비스의 중지)
1.  ㈜Morepet 사이트는 이용자가 본 약관의 내용에 위배되는 행동을 한 경우, 임의로 서비스 사용을 제한 및 중지할 수 있습니다.
제 9 조 (서비스의 변경 및 해지)
1.  ㈜Morepet 사이트는 귀하가 서비스를 이용하여 기대하는 손익이나 서비스를 통하여 얻은 자료로 인한 손해에 관하여 책임을 지지 않으며, 회원이 본 서비스에 게재한 정보, 자료, 사실의 신뢰도, 정확성 등 내용에 관하여는 책임을 지지 않습니다. 의한 손해에 대하여 책임을 부담하지 아니합니다.
제 10 조 (게시물의 저작권)
1. 귀하가 게시한 게시물의 내용에 대한 권리는 귀하에게 있습니다.
2.  ㈜Morepet 사이트는 게시된 내용을 사전 통지 없이 편집, 이동할 수 있는 권리를 보유하며, 게시판운영 원칙에 따라 사전 통지 없이 삭제할 수 있습니다.
3. 귀하의 게시물이 타인의 저작권을 침해함으로써 발생하는 민, 형사상의 책임은 전적으로 귀하가 부담하여야 합니다.
제 3 장 의무 및 책임
제 11 조 ( ㈜Morepet 사이트의 의무)
1.  ㈜Morepet 사이트는 회원의 개인 신상 정보를 본인의 승낙없이 타인에게 누설, 배포하지 않습니다. 다만, 전기통신관련법령 등 관계법령에 의하여 관계 국가기관 등의 요구가 있는 경우에는 그러하지 아니합니다.
제 12 조 (회원의 의무)
1. 회원 가입 시에 요구되는 정보는 정확하게 기입하여야 합니다. 또한 이미 제공된 귀하에 대한 정보가 정확한 정보가 되도록 유지, 갱신하여야 하며, 회원은 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 안됩니다.
2. 회원은  ㈜Morepet 사이트의 사전 승낙 없이 서비스를 이용하여 어떠한 영리행위도 할 수 없습니다.
제 4 장 기타
제 13 조 (양도금지)
1. 회원이 서비스의 이용권한, 기타 이용계약 상 지위를 타인에게 양도, 증여할 수 없습니다.
제 14 조 (손해배상)
1.  ㈜Morepet 사이트는 무료로 제공되는 서비스와 관련하여 회원에게 어떠한 손해가 발생하더라도  ㈜Morepet 사이트가 고의로 행한 범죄행위를 제외하고 이에 대하여 책임을 부담하지 아니합니다.
제 15 조 (면책조항)
1.  ㈜Morepet 사이트는 회원이나 제3자에 의해 표출된 의견을 승인하거나 반대하거나 수정하지 않습니다.  ㈜Morepet 사이트는 어떠한 경우라도 회원이 서비스에 담긴 정보에 의존해 얻은 이득이나 입은 손해에 대해 책임이 없습니다. 금전적 거래등과 관련하여 어떠한 책임도 부담하지 아니하고, 회원이 서비스의 이용과 관련하여 기대하는 이익에 관하여 책임을 부담하지 않습니다.
제 16 조 (재판관할)
1.  ㈜Morepet 사이트와 이용자 간에 발생한 서비스 이용에 관한 분쟁에 대하여는 대한민국 법을 적용하며, 본 분쟁으로 인한 소는 대한민국의 법원에 제기합니다.</textarea>
	</div>
	</div>
	</div>
	<div id="joinWrap">
		<section class="col-8" style=" max-width: 600px; margin: 0px auto; margin-top: 70px; margin-bottom: 70px;">
				<form id="userJoin_form_woo" name="userJoin" action="userJoin.do"
					method="post" onsubmit="return joinValidation();">
					<table>
						<tr id="img_form" style="display: none;">
							<td style="display: block; margin: 0px auto;">
								<div id="pet_photo_form" style="width: 200px; height: 200px;  border-radius: 100%; margin: 0px auto; overflow: hidden; border-style: solid; border-width: 1px;">
									<img id="pet_photo" src="${pageContext.request.contextPath}/images/plus_icon.png" style="width:200px; height: 200px;"> 
								</div>
							</td>
						</tr>
						<tr>
							<td style="text-align: right;">
								<input type="button" value="프로필 업로드" onclick="showImageUpload();">
							</td>
						</tr>
						<tr>
							<td>아이디:<input type="email" name="user_email"
								onkeyup="show()" required="required" placeholder="아이디">
								<span id="idCheckMsg"></span></td>
						</tr>
						<tr>
							<td>비밀번호:<input type="password" id="userPwd"
								placeholder="비밀번호"></td>
						</tr>
						<tr>
							<td>비밀번호 확인:<input type="password" name="user_pwd"
								id="userPwdChk" placeholder="비밀번호 확인"> <font
								id="chkfont" size="3"></font></td>
						</tr>
						<tr>
							<td>이름:<input type="text" name="user_name" placeholder="이름"></td>
						</tr>
						<tr>
							<td>닉네임:<input type="text" name="user_nickname"
								placeholder="닉네임"></td>
						</tr>
						<tr>
							<td>성별: 남<input type="radio" value="1" name="user_sex">
								여<input type="radio" value="2" name="user_sex"></td>
						</tr>
						<tr>
							<td>주소: <input type="text" name="user_addr" id="addr"
								placeholder="동이름을 검색(예: 논현동)" onkeyup="searchAddress();" >
							<button onclick="addrReset();">X</button>
								<div id="searchAddr"
									style="position: absolute; background-color: white; border: 1px solid gray;"></div>
								<div>
									상세주소:<input type="text" name="user_addr_detail">
								</div> <input type="hidden" name="user_x" id="x"> <input
								type="hidden" name="user_y" id="y">
							<td>
						</tr>
						<tr>
							<td>전화번호:<input type="text" name="user_tel"
								placeholder="전화번호"></td>
						</tr>
						<tr>
							<td style="padding-top: 30px;">
								<div style="cursor: pointer; width: 80%; height: 40px; line-height: 40px; margin: 0px auto; background-color: #94b8ff; text-align: center;" onclick="register_upload();">가입하기</div>
							</td>
						</tr>
					</table>
				</form>
				
				
				
				
				<!-- 지웅사진고쳐놔줘 -->
				<%-- 
				<h3>사진 등록</h3>
			<article>
				<div id="pet_photo_form"
					style="width: 200px; height: 200px; border-radius: 100%; margin: 0px auto; overflow: hidden; border-style: solid; border-width: 1px;"
					onclick="showImageUpload();">
					<img id="pet_photo"
						src="${pageContext.request.contextPath}/images/plus_icon.png"
						style="width: 200px; height: 200px;">
				</div>
				<div id="upload_photo">
					<div class="photo_box">
						<div class="upload_btn">
							<div class="upload">
								<input type="file" name="pet_photo_file"
									accept="image/jpeg, image/png" capture="camera" id="photoBtn"><label
									for="photoBtn">사진  첨부하기</label>
							</div>
							<a href="javascript:void(0);" id="resetPhoto">재등록</a>
						</div>
						<div class="photo_them">
							<div class="them_img">
								<img id="image" src="">
							</div>
						</div>
						<a href="javascript:void(0);" id="complete">업로드</a>
					</div>
				</div>
			</article> --%>
			
			
			
		</section>
	</div>
</div>
<%@ include file="../footer.jsp" %>
</body>
</html>