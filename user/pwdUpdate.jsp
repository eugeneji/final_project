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
<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
$(function(){
    $('#userPwd').keyup(function(){
      $('#chkNotice').html('');
    });

    $('#userPwdChk').keyup(function(){

        if($('#userPwd').val() != $('#userPwdChk').val()){
          $('#chkfont').html('<br>비밀번호 일치하지 않음<br>');
          $('#chkfont').attr('color', '#FF0000');
          $("#updatebtn").prop("disabled", true);
        } else{
          $('#chkfont').html('<br>비밀번호 일치함<br>');
          $('#chkfont').attr('color', '#0000FF');
          $("#updatebtn").prop("disabled", false);
        }

    });
});
</script>
<body>
	<form action="pwdUpdate.do">
		<h1 style="margin-left: 10%; margin-top: 5%;">비밀번호 변경</h1>
		<input type="hidden" name='user_idx' value="${user_idx}">
		<table style="margin-left: 10%;">
			<tr>
				<td><label>변경할 비밀번호 입력:</label><input type="text" id="userPwd" class="form-control" placeholder="비밀번호" /></td>
			</tr>
			<tr>
				<td><label>변경할 비밀번호 재입력:</label><input type="text" name="user_pwd" id="userPwdChk" class="form-control"
					placeholder="비밀번호 확인"><input type="submit" value="비밀번호 변경" id="updatebtn" class="btn btn-primary">
					<font id="chkfont" size="2"></font></td>
			</tr>
		</table>
	</form>
</body>
</html>