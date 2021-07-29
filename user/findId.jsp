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
#divButton{
margin-top:30px;
margin-left: 340px;
display: inline-block;
}
</style>
<script>
function Back(){
	window.history.back();
}
</script>
<body class="body">
<form action="findId_ok.do" method="POST">
<h1 align="center" style="margin-top: 5%">아이디 찾기</h1>
<table style="margin-left: 35%; margin-top: 10%">
<tr>
	<th>성함</th>
	<td><input type="text" name="user_name" class="form-control"></td>
</tr>
<tr>
	<th>전화번호</th>
	<td><input type="text" name="user_tel" class="form-control"></td>
</tr>
</table>
<div id="divButton">
<input type="submit" value="아이디 찾기" class="btn btn-primary">
<input type="button" value="뒤로가기" class="btn btn-primary" onclick="Back()">
</div>
</form>
</body>
</html>