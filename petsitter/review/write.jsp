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
<link rel="stylesheet" href="css/starability-all.min.css">
<style type="text/css">
.imgs_wrap{
	display: flex;
	flex-flow: row wrap;
	border: 2px solid white;
	height: 163px;
	border-radius:5px; 
}

.item img{ 
    object-fit: fill;
    width: 152px;
    height: 150px;
}
</style>
<script>
var form = $('form')[0];
var formData = new FormData(form);


$(function() {
	$("#reviewSubmit").click(function() {
		var form = $('form')[0];
		var formData = new FormData(form);
		$.ajax({
			url : 'reviewWrite.do',
			processData : false,
			contentType : false,
			data : formData,
			type : 'POST',
			success : function(result) {

				send(result.type, result.sitter_idx, result.message);
				location.href='index.do';
			}
		});
	});
})
</script>
<script>
	
	var sel_files = [];
	
	$(document).ready(function(){
		$("#input_imgs").on("change", handleImgFileSelect);
	});

	function fileUploadAction(){
		console.log("fileUploadAction");
		$("#input_imgs").trigger('click');
	}
	
	function handleImgFileSelect(e){
		
		sel_files = [];
		$(".imgs_wrap").empty();
		
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		var index = 0;
		filesArr.forEach(function(f){
			
			if(!f.type.match("image.*")){
				alert("이미지만 가능");
				return;
			}
			
			sel_files.push(f);
			
			var reader = new FileReader();
			reader.onload = function(e){
				var html = "<div class = 'item pr-2'>"+
						       "<a href = \"javascript:void(0);\" onclick = \"deleteImageAction("+index+")\" id = \"img_id_"+index+"\">" +
								   "<img src = \"" + e.target.result + "\" date-file = '" + f.name + "' class = 'selProductFile' title = 'Click to remove'>"+
							   "</a>";
						   "</div>"
				$(".imgs_wrap").append(html);
				index++;
				
			}
			reader.readAsDataURL(f);

		});
	}
	
	function deleteImageAction(index){
		
		console.log("index : " + index);
		sel_files.splice(index, 1);
		
		var img_id = "#img_id_" + index;
		$(img_id).remove();
		
		console.log(sel_files);
	}
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>
	<div class="container" style="padding-top: 150px;">
		<div class="row">
			<div class="col-md-12">
				<div class="page-header">
					<h3 style="font-family: 'Jua', sans-serif; font-size: 40px;" >후기 작성</h3>
				</div>
				<div class="pb-5"></div>
				<form action="reviewWrite.do" method="post" enctype="multipart/form-data">
					<fieldset class="starability-fade" style="margin: auto;"> 

		   				<input type="radio" id="rate5" name="star" value="1" />
		    			<label for="rate5" title="Amazing">1 stars</label>
		
					    <input type="radio" id="rate4" name="star" value="2" />
					    <label for="rate4" title="Very good">2 stars</label>
					
					    <input type="radio" id="rate3" name="star" value="3" />
					    <label for="rate3" title="Average">3 stars</label>
					
					    <input type="radio" id="rate2" name="star" value="4" />
					    <label for="rate2" title="Not good">4 stars</label>
					
					    <input type="radio" id="rate1" name="star" value="5" checked="checked"/>
					    <label for="rate1" title="Terrible">5 star</label>
					    
		  			</fieldset>
		  			
					<div class="pt-5"></div>
					
					<div class="imgs_wrap pt-2 pl-2 pb-2"></div>
					
					<input type="file" id="input_imgs" name = "uploads" multiple="multiple" style="display: none;">
					
					<div class="pt-5"></div>
						
					<textarea class="form-control font" rows="10" name="review_content" style="border-radius: 10px; font-size: 20px;"></textarea>
					
					<div class="text-center pt-5 pb-5">
						<span style="border-radius:12px; background-color: white; display:inline-block; height: 50px; margin-right: 30px;">
	       					<button type="button" class="btn btn-outline-warning font" style="border-radius:12px; width: 150px; height: 50px; font-size: 20px; " onclick="$('#input_imgs').click();">사진첨부</button>
	       				</span>
						<span style="border-radius:12px; background-color: white; display:inline-block; height: 50px; ">
	       					<button id="reviewSubmit" type="button" class="btn btn-outline-primary font" style="border-radius:12px; width: 150px; height: 50px; font-size: 20px">등록</button>
	       				</span>
					</div>
					<input type="hidden" name="book_idx" value="${param.book_idx }">
					<input type="hidden" name="to_idx" value="${param.sitter_idx }">
					<input type="hidden" name="user_idx" value="${sessionScope.s_user.user_idx}">
				</form>
			</div>
		</div>
	</div>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>