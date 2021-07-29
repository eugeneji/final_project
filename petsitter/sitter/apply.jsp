<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>

#preview img{
	width: 300px;
	height: 200px;
}

</style>
<script>
var form = $('form')[0];
var formData = new FormData(form);

$(function() {
	$("#applySubmit").click(function() {
		var form = $('form')[0];
		var formData = new FormData(form);
		$.ajax({
			url : 'sitterApply.do',
			processData : false,
			contentType : false,
			data : formData,
			type : 'POST',
			success : function(result) {
					//['alarm','누구한테 보낼건지 idx, 메세지내용']
				send(result.type, 2, result.message);
				location.href='index.do';
			}
		});
	});
})
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>

<div class='container font' style="padding-top: 150px; ">
	<h2 style="text-align: center;">시터  신청</h2>
		<div class="row">
  			<div class="col-12">
				<textarea cols="110" rows="10" readonly="readonly" class="form-control">
	위탁 펫시터는 반려동물을 위탁 받아 펫시터님의 집에서 케어/산책 해주는 서비스 입니다.

펫플래닛과 함께라면 국내 최고의 펫시터가 될 수 있습니다 :)
반려동물을 향한 따뜻한 마음을 가진 분과 함께하고 싶습니다.
그 외의 다른 전문적인 부분은 국내최고 반려동물 전문가들과 함께 도와드리겠습니다.

<지원 전 확인 사항>
					

1. 지원 자격 요건
 *** 반려견을 키워본 경험이 있으신 분 (혹은 유치원, 카페 등에서 근무한 경험)
 *** 현재 서울시, 경기도, 인천 거주자 모집중 
 - 27세 이상 (95년 출생자 이상)
 - 책임 의식을 가지고 열심히 하실 분 (근무 가능일 수가 한달 15일 이상)

2. 우대사항
- 반려동물 5년이상 키워본 경험
- 위탁 또는 방문 펫시터 유경험자 (개인 / 타업체) 
- 반려동물 관련 자격증 소지자, 관련학과 전공

3. 펫시터 활동 절차
  * 4단계 검증 : 1차 (서류심사) > 2차 (대면 면접) > 3차 (안전성 검증) > 4차 (오프라인교육)
     1) 1차 서류심사 : 서류심사 합격 여부는 합격자에 한해서 개별 연락드립니다.
     2) 2차 대면면접 : 서류합격자에 한 해 오프라인 면접이 진행됩니다.
     3) 3차 안전성 검증 : 지원자님의 댁에 방문하여, 펫시팅 환경 검증이 이루어 집니다.
     4) 오프라인교육 : 3차까지 완료된 지원자는 오프라인 교육 이수 후에 펫시팅 활동이 가능합니다.</textarea>
			</div>
	</div>
	<div id="joinWrap">
		<section class="col-8" style=" max-width: 600px; margin: 0px auto; margin-top: 70px; margin-bottom: 70px;">
				<form id="userJoin_form_woo" name="apply" action="sitterApply.do" method="post" enctype="multipart/form-data">

					<div>
						<input type="hidden" name="user_idx" value="${sessionScope.s_user.user_idx}">
						지원자 성명 <br>
						<input type="text" name="user_name" value = "${sessionScope.s_user.user_name }" placeholder="ex) 홍길동">
					</div>
					<div>
						성별<br>
						<input type="radio" name="sex" value="1" <c:if test="${ sessionScope.s_user.user_sex eq 1}">checked="checked"</c:if>>남성
						<input type="radio" name="sex" value="2" <c:if test="${ sessionScope.s_user.user_sex eq 2}">checked="checked"</c:if>>여성
					</div>
					<div>
						연락처<br>
						<input type="tel" name="user_tel" value="${sessionScope.s_user.user_tel }">
					</div>
					<div>
						거주지 주소<br>
						<input type="text" name="user_addr" value="${sessionScope.s_user.user_addr }" placeholder="ex)서울시 강남구 논현동">
					</div>
					<div>
						자격증<br>
						<div id='preview'>
				        <!-- 미리보기 공간 -->
				    	</div>
						<input type='file' id='upload' name='upload'/>
					</div>
					<div>
						계좌번호<br>
						<input type="text" name="account">
					</div>
					<div>
						자기소개<br>
						<textarea style="height: 100px;" name="introduce"></textarea>
					</div>
					<div class="mt-5" id="applySubmit" style="cursor: pointer; width: 80%; height: 40px; line-height: 40px; margin: 0px auto; background-color: #94b8ff; text-align: center;"
						onclick="register_upload();">제출</div>
				</form>			
		</section>
	</div>
</div>


<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
<script>
var upload = document.querySelector('#upload');
var reader = new FileReader();

reader.onload = (function () {
	
    this.image = document.createElement('img');
    var vm = this;
    
    return function (e) {

        vm.image.src = e.target.result
    }
})()

upload.addEventListener('change',function (e) {
	
    var get_file = e.target.files;

    if(get_file){
        reader.readAsDataURL(get_file[0]);
    }
	
    preview.appendChild(image);
})
</script>
</html>