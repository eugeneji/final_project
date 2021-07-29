<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel='stylesheet' href='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css' />
<link href="css/bbs/findbbs.css" rel="stylesheet"/>
<script type="text/javascript" src="js/httpRequest.js"></script>
<script src="https://code.jquery.com/jquery-1.11.2.min.js"></script>
</head>
<style>
.comment_writer{
display:inline-block;
width:20%;
}
.comment_content{
display:inline-block;
width:60%;
}
.comment_date{
display:inline-block;
width:20%;
}
.comment_date2{
display:inline-block;
width:10%;
}
</style>
<script>
function find(bbs_idx) {
	var params='bbs_idx='+bbs_idx;
	sendRequest('findBbsContent.do',params,showResult,'GET');
	
}
function showResult() {
	if(XHR.readyState==4){
		if(XHR.status==200){
			var data=XHR.responseText;
			data=eval('('+data+')');
			var contentDiv=document.getElementById('findContent');
			contentDiv.style.display='';
			document.getElementById('idxTd').innerHTML=data.dto.bbs_idx;
			document.getElementById('typeTd').innerHTML=data.dto.bbs_type;
			document.getElementById('kindTd').innerHTML=data.dto.bbs_kind;
			document.getElementById('nameTd').innerHTML=data.dto.bbs_name;
			document.getElementById('sexTd').innerHTML=data.dto.bbs_sex==1?"수컷":"암컷";
			document.getElementById('writedateTd').innerHTML=data.dto.bbs_writedate;
			document.getElementById('readnumTd').innerHTML=data.dto.bbs_readnum;
			document.getElementById('findTd').innerHTML=data.dto.bbs_find;
			document.getElementById('subjectTd').innerHTML=data.dto.bbs_subject;
			document.getElementById('contentTd').innerHTML=data.dto.bbs_content;
			document.getElementById('editbutton').onclick=function(){location.href='findBbsEdit.do?bbs_idx='+data.dto.bbs_idx};
			if(data.dto.bbs_nickname=='${sessionScope.s_user.user_nickname}'){
				document.getElementById('editDiv').style.display='';
				document.getElementById('deletebutton').setAttribute("onclick",'boardDelete('+data.dto.bbs_idx+')');
			}
$("#comment_bbs_idx").val(data.dto.bbs_idx);
			
			$(data.commentList).each(function(){
				$("#comment_list").append("<div>");
				$("#comment_list").append("<div class='comment_writer'>"+this.comment_writer+"</div>");
				$("#comment_list").append("<div class='comment_content'>"+this.comment_content+"</div>");
				$("#comment_list").append("<div class='comment_date'>"+ this.comment_writedate+"</div>");
				$("#comment_list").append("</div>");
			});
		}
	}
}
function divClose() {
	var findDiv=document.getElementById('findContent');
	findDiv.style.display='none';
	document.getElementById('editDiv').style.display='none';
	$("#comment_list").empty();	
}
function boardDelete(idx){
	$.ajax({
	    type : 'GET',
	    url : 'findBbsDel.do',
	    data : {bbs_idx:idx},
	    success : function() {
	           location.reload();
	    },
	    error : function(e) {
	    	console.log('실패');
	    }

	});
	
}
function show(cp){
	location.href='findBbsList.do?cp='+cp;
	
}
function comment_add(){
	if('${sessionScope.s_user.user_nickname}'==''){
		window.alert('로그인 후 이용 바랍니다!');
		return;
	}
	$.ajax({
		url:'reportReBbsWrite.do', 
		type:'post', 
		data:$('#test').serialize(),
		success:function(data) {
			window.alert(data.msg);
			$('#comment_content').val('');
			$("#comment_list").append("<div>");
			$("#comment_list").append("<div class='comment_writer'>"+data.newComment.comment_writer+"</div>");
			$("#comment_list").append("<div class='comment_content'>"+data.newComment.comment_content+"</div>");
			$("#comment_list").append("<div class='comment_date'>"+ data.newComment.comment_writedate+"</div>");
			$("#comment_list").append("</div>");
		}
	});
}
</script>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>

	<div class="container" style="padding-top:150px;">
		<h1>
  유기동물
  <small class="text-muted">강아지&고양이를 찾습니다</small>
</h1>
	<table class="table" aling="center" style="margin-left: auto; margin-right: auto;">
		<thead>
			<tr>
				<th scope="col">글 번호</th>
				<th scope="col">글 제목</th>
				<th scope="col">애완 종류</th>
				<th scope="col">애완 품종</th>
				<th scope="col">이름</th>
				<th scope="col">성별</th>
				<th scope="col">작성 날짜</th>
				<th scope="col">조회수</th>
				<th scope="col">현황</th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<td align="center" colspan="8">${pageStr}</td>
				<td><a href="findBbsWrite.do">글쓰기</a></td>
			</tr>
		</tfoot>
		<tbody>
			<c:if test="${empty list}">
				<tr>
					<td colspan="1" align="center">등록된 게시물이 없습니다.</td>
				</tr>
			</c:if>
			<c:forEach var="dto" items="${list}">
				<tr>
					<td>${dto.bbs_idx}</td>
					<c:url var="findUrl" value="findBbsContent.do">
						<c:param name="bbs_idx">${dto.bbs_idx}</c:param>
					</c:url>
					<td><a href="javascript:find(${dto.bbs_idx})">${dto.bbs_subject}</a></td>
					<td>${dto.bbs_type==1?"강아지":"고양이"}</td>
					<td>${dto.bbs_kind}</td>
					<td>${dto.bbs_name}</td>
					<td>${dto.bbs_sex==1?"수컷":"암컷"}</td>
					<td>${dto.bbs_writedate}</td>
					<td>${dto.bbs_readnum}</td>
					<td>${dto.bbs_find}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div id="findContent"
		align="center"
		style="overflow:scroll; width: 800px; height: 350px;  border: 2px solid gray; position: absolute; top: 200px; left: 30%; background-color: white; display: none;">
		<table  class="table" border="1" width="800" height="350" cellspacing="0" aling="center">
			<tr>
				<th class="table-primary">글 번호</th>
				<th class="table-primary">애완 종류</th>
				<th class="table-primary">애완 품종</th>
				<th class="table-primary">이름</th>
				<th class="table-primary">성별</th>
				<th class="table-primary">작성 날짜</th>
				<th class="table-primary">조회수</th>
				<th class="table-primary">현황</th>
			</tr>
			<tr>
			<td id="idxTd" align="center"></td>
				<td id="typeTd" align="center"></td>
				<td id="kindTd" align="center"></td>
				<td id="nameTd" align="center"></td>
				<td id="sexTd" align="center"></td>	
				<td id="writedateTd" align="center"></td>
				<td id="readnumTd" align="center"></td>
				<td id="findTd" align="center"></td>
			</tr>
			<tr>
				<th class="table-primary">글 제목</th>
				<td colspan="14" id="subjectTd"></td>
			</tr>
			<tr height="150">
			<th class="table-primary">내 용</th>
				<td colspan="14" id="contentTd">--</td>
			</tr>
			</table>
		<hr>
		<div id="comment">
			<div>
				<div class="comment_writer"  style="font: bold 1.0em/0.5em impact;">작성자</div>
				<div class="comment_content"  style="font: bold 1.0em/0.5em impact;">댓글</div>
				<div class="comment_date2"  style="font: bold 1.0em/0.5em impact;">작성일</div>
			</div>
			<div id="comment_list"></div>
			<form id="test">
			<input id="comment_bbs_idx" type="hidden" name="bbs_idx">
				<div>
					<input type="text" id="comment_content" name="comment_content" style="width:715px;">
					<input type="button" onclick="comment_add();" value="등록" class="btn btn-xl btn-secondary">
				</div>
			</form>
		</div>
		<hr>
		<div align="right">
			<span id='editDiv' style="display: none;" align="left">
				<input type="button" class="btn btn-outline-success " id="editbutton" value="수정">
				<input type="button" class="btn btn-outline-danger" id="deletebutton"  value="삭제">
			</span>
			<span id="closeButton">
				<input type="button" class="btn btn-outline-primary" value="닫기" onclick="divClose();">
			</span>
		</div>
	</div>
	</div>
	<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>