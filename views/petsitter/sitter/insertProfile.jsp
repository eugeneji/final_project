<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src='https://code.jquery.com/jquery-3.5.1.min.js'></script>
<style>
.newImg img {
	display: inline-block;
    width: 100%;
    height: 100%;
    overflow: hidden;
    object-fit: cover;
}

.img-box{
	width: 100%;
	height: 85%;
}
</style>
<script> 
function setThumbnail(event,parent) {
	$("#image_"+parent).html('');
	var image = event.target.file;
	var reader = new FileReader(); 
	
	reader.onload = function(event) {
		var img = document.createElement("img"); 
		img.setAttribute("src", event.target.result); 
		document.querySelector("div#image_"+parent).prepend(img);
	}; 
	reader.readAsDataURL(event.target.files[0]);
}
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>
	

	<div class='container' style="padding-top: 150px;">
		<h3 style="font-family: 'Jua', sans-serif; font-size: 40px;" >시터 프로필 작성</h3>
		<form id="insertProfile" name = "insertProfile" action="insertProfile.do" method="post" enctype="multipart/form-data"  style="border-radius: 10px; box-shadow: rgba(0, 0, 0, 0.05) 0px 2px 20px;">
			<div class = "sitterInbox row form-inline justify-content-center ml-1">
				<div class="newImg mt-1 ml-1 mr-1" style="background-color: white;">
					<div class="img-box" id="image_1"></div>
					<input name="uploads" type="file" accept="image/*" onchange="setThumbnail(event,1);" required="required">
				</div>
				<div class="newImg mt-1 ml-1 mr-1" style="background-color: white;">
					<div class="img-box" id="image_2"></div>
					<input name="uploads" type="file" accept="image/*" onchange="setThumbnail(event,2);">
				</div>			 
			</div>
			<div class = "sitterInbox row form-inline justify-content-center ml-1">
				<div class="newImg mt-1 ml-1 mr-1" style="background-color: white;">
					<div class="img-box" id="image_3"></div>
					<input name="uploads" type="file" accept="image/*" onchange="setThumbnail(event,3);">
				</div>
				<div class="newImg mt-1 ml-1 mr-1" style="background-color: white;">
					<div class="img-box" id="image_4"></div>
					<input name="uploads" type="file" accept="image/*" onchange="setThumbnail(event,4);">
				</div> 	
			</div>
			<input type="text" class="form-control col-12 mt-3 font color" style="font-size: 16px; height: 40px;" name="subject" placeholder="제목을 입력하세요" required>
			<textarea class = "form-control mt-3 col-12 font color" name="content" rows="10" cols="" placeholder="소개를 입력하세요" required></textarea>

			<div class="col-sm-12 pt-3">
				<div class="card">
					<div class="card-header card-header-primary font">
						<h4 class="card-title"><i class="fas fa-square"></i> 이용 요금</h4>
						<p class="card-catagory"></p>
					</div>
					<div class="card-body font">
						<div class="table-responsive">
							<table class="table">
								<thead>
									<tr>
										<td></td>
										<td style="text-align: center;">데이 케어</td>
										<td style="text-align: center;">1박 케어</td>
									</tr>
								</thead>
								<tbody>
									<tr style="line-height: 32px;">
										<td>소형</td>
										<td><input type="number" name="ss" class="form-control"  min="0" max="100000" step="1000" placeholder="취급 안할시 0 입력" required></td>
										<td><input type="number" name="sl" class="form-control"  min="0" max="100000" step="1000" placeholder="취급 안할시 0 입력" required></td>
									</tr>
									<tr>
										<td>중형</td>
										<td><input type="number" name="ms" class="form-control" min="0" max="100000" step="1000" placeholder="취급 안할시 0 입력" required></td>
										<td><input type="number" name="ml" class="form-control" min="0" max="100000" step="1000" placeholder="취급 안할시 0 입력" required></td>
									</tr>
									<tr>
										<td>대형</td>
										<td><input type="number" name="ls" class="form-control" min="0" max="100000" step="1000" placeholder="취급 안할시 0 입력" required></td>
										<td><input type="number" name="ll" class="form-control" min="0" max="100000" step="1000" placeholder="취급 안할시 0 입력" required></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<input type="hidden" name="user_idx" value="${sessionScope.s_user.user_idx }">
			<div class="form-group row justify-content-end mt-4">
				<input id = "profileSubmit" class="btn btn-outline-primary mr-2 font" type="submit" value="등록">
				<input class="btn btn-outline-danger font"  type="reset" value="다시작성">
			</div>
		</form>
	</div>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>