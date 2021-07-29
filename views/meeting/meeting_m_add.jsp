<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .map_wrap {position:relative;width:100%;height:350px;}
    .title {font-weight:bold;display:block;}
    .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
    #centerAddr {display:block;margin-top:2px;font-weight: normal;}
    .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
</style>

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript">
function showMap() {
	var contentDiv = document.getElementById('contentLayer');
	contentDiv.style.display='';
}

function searchAddress(){
	   var q = document.getElementById('addr').value; //검색 내용
	   //ajax 시작
	    if(q){
	      $.ajax({
	         url : 'https://dapi.kakao.com/v2/local/search/address.json',
	         headers : {'Authorization':'KakaoAK 3d2dbf77d9a9ba6a4c73493da5d7fc07'},
	         type: 'GET',
	         data : { 'query' : q },
	         success : function(data){
	            //호출 성공하면 작성할 내용
	               if(data.documents.length != 0 ){ // 값이 있으면
	                  
	                  var result="";
	                  for(var i=0;i<data.documents.length;i++){
	                     
	                     if(data.documents[i].address.region_3depth_h_name || data.documents[i].address.region_3depth_name){
	                        result += '<div onclick="showAddr(this)">' + data.documents[i].address_name + '<input type="hidden" name="x" value='+data.documents[i].x+'><input type="hidden" name="y" value='+data.documents[i].y+'></div>';
	                     
	                     }
	                  }
	                  document.getElementById('searchAddr').style.display = '';
	                  document.getElementById('searchAddr').innerHTML = result;
	                    /* "<a onclick='showAddr(this);'>"+data.documents[i].address_name+"</a><br>"; */
	            }
	         },
	         error:function(request,status,error){
	             alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	         }
	      }).done(function(data){console.log(data);});
	    }else{
	       document.getElementById('searchAddr').style.display = 'none';
	    }
	}

	function showAddr(addr){
	   document.getElementById('addr').value = addr.innerText;
	   document.getElementById('x').value = addr.firstChild.nextSibling.value;
	   document.getElementById('y').value = addr.firstChild.nextSibling.nextSibling.value;
	   document.getElementById('searchAddr').style.display = 'none';
	}

	function addrReset(){
	   document.getElementById('addr').value = null;
	   document.getElementById('searchAddr').style.display = 'none';
	}
</script>
</head>
<body>
<%@ include file="../header.jsp" %>
<div class='container' style="padding-top: 150px;">

<c:set var="dto" value="${dto}"></c:set>
<div class='card-deck mt-3'>
		<div class='card'>
		<form name="meeting_m_add" action="meeting_m_addContent.do" method="post" enctype="multipart/form-data">
            <div class='card-body'>
               <h5 class='card-title'>내모임</h5>
     <!--제목--><p class='card-text'>제목 : <input type="text" name="meeting_m_subject">
     			<input type="hidden" name="user_idx" value="${sessionScope.s_user.user_idx}">
     			</p>
     <!--인원--><p class='card-text'>인원 : 
              	 <select name="meeting_m_total">
             	 	<option value="1">1명</option>
             	 	<option value="2">2명</option>
             	 	<option value="3">3명</option>
             	 	<option value="4">4명</option>
             	 	<option value="5">5명</option>
             	 </select> 
               </p>
    <!--시간--><p class='card-text'>만남 시간 : 
	              <select name="m-hour">
	             	<option value="1">1시</option>
	             	<option value="2">2시</option>
	             	<option value="3">3시</option>
	           	 	<option value="4">4시</option>
	           	 </select> 
	           	 <select name="m-min">
	           	 	<option value="00">00분</option>
	           	 	<option value="30">30분</option>
	           	 </select> 
	           	 <span>&nbsp; 후</span>
               </p>
     <!--장소--><p class='card-text'>장소 : 
     <div class="row">
     <div class="col-md-6" style="display: inline-flex;"><input type="text" name="meeting_m_location" id="addr" placeholder="(ex 삼성동)동이름으로 주소를 찾아주세요." onkeyup="searchAddress();">
     <button type="button" onclick="addrReset();">X</button>
     <div id="searchAddr" style="position: absolute; background-color: white; border: 1px solid gray;"></div></div><br>
     <div class="col-md-6">
     			<input type="text" name="meeting_m_detail" placeholder="자세한 위치 정보를 적어주세요.">
     			<input type="hidden" name="meeting_m_x" id="x"><input type="hidden" name="meeting_m_y" id="y">
     			</div>
     </div>
     			</p>
       
	  <!--내용--><p class='card-text'>내용 : 
	  <div class="row">
	  <div class="col-12">
	  <input type="file" value="사진" name="upload" multiple="multiple">
	  </div>
	   <div class="col-12">
	  			<textarea class="form-control" name="meeting_m_content"></textarea> </p>
	   </div>
	   </div>
            </div>
            <div class='card-footer'>
		         <div class='row'>
		             <button type='submit' id='signUpBtn' class='btn btn-primary offset-3 col-6 mt-2'>등록</button>
		         </div>
            </div>
             </form>  
         </div>
      </div>

<%@ include file="../footer.jsp" %>
</div>
</body>
</html>