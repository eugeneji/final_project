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
margin-top: 10%;
margin-left: 30%;
background-color: Lightsteelblue;
}
form{
    width: 800px;
    height: 400px;
    border: 1px solid;
    background-color: white;
}
</style>
<body class="body">
<section>
<article>
<fieldset>
<form action="findPwd_ok.do">
<h1 style="margin-top: 5%; margin-left: 5%;">비밀번호 찾기</h1>
<table style="width: 600px; margin-top: 10%; margin-left: 10%;">
<tr>
	<th>가입한 이메일 아이디 </th><td><input type="text" name="user_email" class="form-control"></td>
	<td><input type="submit" value="가입한 아이디 확인하기" class="btn btn-primary"></td>
	</tr>
</table>
</form>
</fieldset>
</article>
</section>
</body>
</html>