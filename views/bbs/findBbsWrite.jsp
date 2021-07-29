<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel='stylesheet' href='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css' />
<script type="text/javascript">
function Back(){
	window.history.back();
}
</script>
<style>
textarea {
	resize: none;
}

#bbs_subject {
	width: 715px;
}
</style>
<body>
	<h1 align="center">강아지&고양이를 찾습니다</h1>
	<form action="findBbsWrite.do" method="post">
		<input type="hidden" name="bbs_nickname" value="${sessionScope.s_user.user_nickname}">
		<input type="hidden" name="bbs_category" value="4">		
		<table style="margin-left: auto; margin-right: auto;" method="post">
			<tr>
				<th>애완동물 종류</th>
				<td>
				<select name="bbs_type">
					<option value="">선택</option>
					<option value="1">강아지</option>
					<option value="2">고양이</option>
				</select>
				</td>
				<th>애완동물 품종</th>
				<td><input type="text" name="bbs_kind" class="form-control"></td>
			</tr>
			<tr>
				<th>애완동물 이름</th>
				<td><input type="text" name="bbs_name" class="form-control"></td>
				<th>애완동물 성별</th>
				<td>수컷<input type="radio" name="bbs_sex" value="1">
				암컷<input type="radio" name="bbs_sex" value="2">
				</td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td colspan="1">${sessionScope.s_user.user_nickname}</td>
				<th>비밀번호</th>
				<td><input type="text" name="bbs_pwd" class="form-control"></td>
			</tr>
			<tr>
				<th>애완동물 이미지</th>
				<td><input type="text" name="bbs_img" class="form-control"></td>
				<th>현황</th>
				<td>
				<select name="bbs_find">
					<option value="찾는중">찾는중</option>
					<option value="찾음">찾음</option>
				</select>
				</td>
			</tr>
		</table>
		<table style="margin-left: auto; margin-right: auto;">
			<tr>
				<td colspan="3"><input type="text" name="bbs_subject" style="width: 100%"
					id="bbs_subject" class="form-control"></td>
			</tr>
			<tr>
				<td colspan="4"><textarea name="bbs_content" cols="100"
						rows="50" id="text" class="form-control"></textarea></td>
			</tr>
			<tr>
				<td align="right"><input type="submit" value="작성완료" class="btn btn-primary"> <input
					type="button" value="뒤로가기" class="btn btn-primary" onclick="Back();"></td>
			</tr>
		</table>
	</form>
</body>
</html>
