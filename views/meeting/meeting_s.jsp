<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi">	
<meta name="format-detection" content="telephone=no">
<script type="text/javascript" src="/morepet/js/httpRequest.js"></script>
<script type="text/javascript">
function show_dto(meeting_s_idx) {
	location.href="meeting_s_dto.do?meeting_s_idx="+meeting_s_idx;
}
function show(meeting_s_idx) {
	var params = 'meeting_s_idx='+meeting_s_idx;
	sendRequest('meeting_s_content.do',params,showResult,'GET');
}

function showResult() {
	if(XHR.readyState==4){
		if(XHR.status==200){
			var data = XHR.responseText;
			data = eval('('+data+')');
			/*스크립트 시간값 구하기*/
			let today = new Date(); 
			
			var contentDiv = document.getElementById('contentLayer');
			contentDiv.style.display='';
			document.getElementById('idxTd').innerHTML = data.dto.meeting_s_idx;
			
			document.getElementById('nicknameTd').innerHTML = data.dto.user_nickname;
			document.getElementById('writedateTd').innerHTML = data.dto.meeting_s_writedate;
			document.getElementById('imgTd').innerHTML = data.dto.user_img;
			document.getElementById('contentTd').innerHTML = data.dto.meeting_s_content;
			
			
			document.getElementById('j_button').innerHTML = 
				'<input type="button" value="닫기" onclick="divClose()">'
				
				var node = document.getElementById('j_button');
				var s_user = ${sessionScope.s_user.user_idx};
				
				if(s_user == data.dto.user_idx){
					
					var div= document.createElement('div');
					div.innerHTML=
				'<input type="button" value="삭제" onclick="showDel('+data.dto.meeting_s_idx+')">'+
				'<div id="meetingUpdate"><input type="button" value="수정" onclick="showUpdate('+data.dto.meeting_s_idx+')"></div>'
					node.appendChild(div);
				}
			
		}
	}
}

function divClose() {
	var contentDiv = document.getElementById('contentLayer');
	contentDiv.style.display='none';
}
function showDel(meeting_s_idx) {
	if(confirm('정말 삭제하시겠습니까?')){
		location.href='meeting_s_contentDel.do?meeting_s_idx='+meeting_s_idx;
			/* alert("삭제되었습니다."); */
	    }else {
	        
	    }
	}
function showUpdate(meeting_s_idx) {
	var data = XHR.responseText;
	data = eval('('+data+')');
	
	var contentDiv = document.getElementById('contentLayer');
	contentDiv.style.display='';
	
	document.getElementById('contentTd').innerHTML = 
		'<input type="text" id="meeting_s_content" name="meeting_s_content" value="'+data.dto.meeting_s_content+'">'
	
	document.getElementById('imgTd').innerHTML = 
		'<input type="file" id="meeting_s_img" name="meeting_s_img" value="'+data.dto.meeting_s_img+'">'	
	
	document.getElementById('meetingUpdate').innerHTML = 
		'<input type="button" value="수정!" onclick="updatePop('+meeting_s_idx+')">'
}

/* console.log(comm); */
function updatePop(meeting_s_idx) {
	console.log(meeting_s_idx);
	var comm= document.getElementById('meeting_s_content').value;
	console.log(comm);
	var img= document.getElementById('meeting_s_img').value;
	console.log(img);
	
	location.href='meeting_s_update.do?meeting_s_content='+comm+'&meeting_s_idx='+meeting_s_idx+'&meeting_s_img?='+img;
}
function dec() {
	location.reload();
}

/* function timeBefore(meeting_s_writedate){

	var contentDiv = document.getElementById('contentLayer');
	contentDiv.style.display='';
	
    //현재시간을 가져옴
    var now = new Date(); 
    console.log(now);
    
    //글쓴 시간 
    var writeDay = meeting_s_writedate;
 	//또는 파라미터로 시간을 넘겨받아서 계산할 수도 있음..
    
    
 	var minus;
    //현재 년도랑 글쓴시간의 년도 비교 
    if(now.getFullYear() > writeDay.getFullYear()){
        minus= now.getFullYear()-writeDay.getFullYear();
        //두개의 차이를 구해서 표시
        document.getElementsById("sub")[0].innerHTML = minus+"년 전";
        console.log(minus+"년 전");
    }else if(now.getMonth() > writeDay.getMonth()){
    //년도가 같을 경우 달을 비교해서 출력
        minus= now.getMonth()-writeDay.getMonth();
        document.getElementsById("sub")[0].innerHTML = minus+"달 전";
        console.log(minus+"달 전");
    }else if(now.getDate() > writeDay.getDate()){
   	//같은 달일 경우 일을 계산
        minus= now.getDate()-writeDay.getDate();
        document.getElementsById("sub")[0].innerHTML = minus+"일 전";
        console.log(minus+"일 전");
    }else if(now.getDate() == writeDay.getDate()){
    //당일인 경우에는 
        var nowTime = now.getTime();
        var writeTime = writeDay.getTime();
        if(nowTime>writeTime){
        //시간을 비교
            sec =parseInt(nowTime - writeTime) / 1000;
            day  = parseInt(sec/60/60/24);
            sec = (sec - (day * 60 * 60 * 24));
            hour = parseInt(sec/60/60);
            sec = (sec - (hour*60*60));
            min = parseInt(sec/60);
            sec = parseInt(sec-(min*60));
            if(hour>0){
            //몇시간전인지
                document.getElementsById("sub")[0].innerHTML = hour+"시간 전";
                console.log(hour+"시간 전");
            }else if(min>0){
            //몇분전인지
                document.getElementsById("sub")[0].innerHTML = min+"분 전";
                console.log(min+"분 전");
            }else if(sec>0){
            //몇초전인지 계산
                document.getElementsById("sub")[0].innerHTML = sec+"초 전";
                console.log(sec+"초 전");
            }
        }
    }
}
 */
</script>
</head>
<!-- <body onload="timeBefore()"> -->
<body>
<%@ include file="../header.jsp" %>
<div class='container' style="padding-top: 150px;">
	<div class='reviewBar'>
         <hr>
         <div class='reviewBarFont'><a href="meeting_s_write.do">글쓰기 </a></div>
         <hr>
     </div>
     
     
<!-- 리스트 출력 부분 -->
<c:if test="${empty list}">
	 <a href='' id='list'>
      <div id='sitter' class='mt-3 row'>
      	<div class='row line pt-0 mt-0'>
        	<p class='col-5 m-0 p-0'>게시글이 없습니다.</p>
       	</div>
      </div>
      </a>
</c:if>

<c:set var="dec" value="${list_d}"></c:set>
<c:forEach var="arr" items="${list}">
	<c:url var="contentUrl" value="meeting_d_list.do">
		<c:param name="meeting_s_idx">${arr.meeting_s_idx}</c:param>
	</c:url>
	
      <a href="#" onclick="show(${arr.meeting_s_idx})" id='list'>
      <div id='sitter' class='mt-3 row' onload="show_dto(${arr.meeting_s_idx})">
         <div id='sitterImg' class='col-4 form-group'>
            <div class='text-center mt-2 mr-0 ml-3 myImg'>유저 이미지</div>
         </div>
         
         <div id='sitterInfo' class='col-8 form-group'>
            <div class='row line mt-3 pb-0 mb-0'>
            
               <p class='col-3 mr-0 pr-0 sitterFont'><b>${arr.user_nickname}</b></p>
           <!-- 시간 조건문 -->
               <p class='col-5 m-0 p-0'>
               		<c:choose>
               			<c:when test="${arr.day > 0}">
               				<span id="sub">${arr.day} 일 전</span>
               			</c:when>
               			<c:when test="${arr.hour > 0}">
               				<span id="sub">${arr.hour} 시간 전</span>
               			</c:when>
               			<c:when test="${arr.minute > 0}">
               				<span id="sub">${arr.minute} 분 전</span>
               			</c:when>
               			<c:otherwise>
               				<span id="sub">방금 전</span>
               			</c:otherwise>
               		</c:choose>
               </p>   
               
            </div><br>
            <div class='row line pt-0 mt-0'>
               <p class='col-5 m-0 p-0'>${arr.meeting_s_content}</p>
               <p class='col-3 font'>
               <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-star-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                 <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.283.95l-3.523 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                 
               </svg><small>댓글: ${contentUrl}</small>&nbsp;<small>좋아요</small></p>
            </div>
         </div>
      </div>
      </a>
      
      <!-- content 보기 --> 
	<div id="contentLayer" style="width: 600px; height: 500px; z-index:1;
	border: 2px solid gray; position: absolute; top: 100px; left: 50px; background-color: white; display: none">
	<form name="dec" action="meeting_d_add.do">
		<table border="1" width="400" cellspacing="0">
			<tr>
				<th>게시물 번호</th>
				<td id="idxTd">--</td>
				<th>작성시간</th>
				<td id="timeTd">--</td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td id="nicknameTd">--</td>
				<th>작성날짜</th>
				<td id="writedateTd">--</td>
			</tr>
			<tr>
				<th>이미지</th>
				<td id="imgTd" colspan="3"></td>
			</tr>
			<tr height="150">
				<td id="contentTd" colspan="4"></td>
			</tr>
			<tr>
				<td colspan="4" id="j_button"></td>
			</tr>
			<c:choose>
				<c:when test="${empty list_d}">
					<td>-</td>
				</c:when>
				<c:otherwise>
					<td><a href="">댓글()</a></td>
				</c:otherwise>
			</c:choose>
			<tr>
				<th colspan="3">
					<input type="hidden" name="user_idx" value="${sessionScope.s_user.user_idx}">
					<input type="text" name="meeting_d_content">
				</th>
				<td><input type="submit" value="등록" onclick="dec()"></td>
			</tr>
		</table>
		</form>
	</div>

</c:forEach>

<!-- 페이징 부분 -->  
	<div class='d-flex justify-content-center mt-3'>
		<ul class='pagination'>
			<li class='page-item'>${pageStr}</li>
		</ul>
	</div>
     
<%@ include file="../footer.jsp" %>
</div>
</body>
</html>