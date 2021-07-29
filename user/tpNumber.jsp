<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel='stylesheet' href='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css' />
<style>
.body{
width:500px;
background-color: Lightsteelblue;
}
form{
    width: 800px;
    height: 400px;
    border: 1px solid;
    background-color: white;
    margin-top: 10%;
	margin-left: 35%;
}
</style>
<script>
window.alert('고객님의 이메일로 임시번호를 전송 하였습니다.');
function tpNumber() {
	var Key=document.getElementById('Key').value;
	var num=document.getElementById('number').value;
	var user_idx=document.getElementById('user_idx').value;
	if(num!=Key){
		window.alert('임시번호가 다릅니다!');
		location.href="index.do";
	}else{
		location.href="pwdUpdateForm.do?user_idx="+user_idx;
	}
}
</script>
<body>
<form>
<section>
<article>
<fieldset style="margin-left: 10%; margin-top: 10%;">
<legend>비밀번호 찾기</legend>
<table>
<tr>
	<th>임시비밀번호 :</th><td><input type="text" id="number" class="form-control"></td><td><input type="button" value="임시 비밀번호 입력" class="btn btn-primary" onclick="tpNumber()"></td>
</tr>
</table>
</fieldset>
<input type="hidden" id="Key" value="${num}">
<input type="hidden" id="user_idx" value="${user_idx}">
</article>
</section>
</form>
</body>
</html>