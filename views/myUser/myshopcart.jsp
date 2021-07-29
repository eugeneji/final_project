<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.my_ul{border: 1px solid gray;}
	.my_ul >li {border: 1px solid gray;}
	#my_one{ display: none;}
	#my_two{display: none;}
</style>
<script src='https://code.jquery.com/jquery-3.5.1.min.js'></script>
<script type="text/javascript">
function open(one) {
	if(document.getElementById(one).style.display=='none'){
		
		document.getElementById(one).style.display='block';
	}else{
		document.getElementById(one).style.display='none';
	}
}
</script>
</head>
<body>
<%@ include file="../header.jsp" %>
<div class='container' style="padding-top: 150px;">
	<div class="row">
		<div class="col-xs-6 col-md-4">
			 <div class="mypage">
		        <h2>My Menu</h2>
		              <ul class="my_ul">
		                <li><a href="javascript:open('my_one')" style="color:#495057;">내정보</a>
		                	<ul id="my_one">
		                		<li>&nbsp;&nbsp;<a href="myInformation.do" style="color:#495057;">내 정보</a></li>
		                		<li>&nbsp;&nbsp;<a href="" style="color:#495057;">내 반려동물</a></li>
		                		<li>&nbsp;&nbsp;<a href="" style="color:#495057;">탈퇴</a></li>
		                	</ul>
		                </li>
						<li><a href="javascript:open('my_two')" style="color:#495057;">내가쓴글</a>
							<ul id="my_two">
								<li>&nbsp;&nbsp;<a href="" style="color:#495057;">내가쓴글</a></li>
								<li>&nbsp;&nbsp;<a href="" style="color:#495057;">내가쓴글댓글</a></li>
							</ul>
						</li>
		                <li><a href="" style="color:#495057;">장바구니</a></li>
		                <li><a href="" style="color:#495057;">wish리스트</a></li>
		                <li><a href="" style="color:#495057;">구매내역</a></li>
		              </ul>
		    </div>
	    </div>
	    <div class="col-xs-12 col-sm-6 col-md-8">
	    	<div style="padding-top: 48px;">
	    		<div class="card">
				  <div class="card-header">
				    #
				  </div>
				  <div class="card-body">
				    <blockquote class="blockquote mb-0">
				      <p>A well-known quote, contained in a blockquote element.</p>
				      <footer class="blockquote-footer">Someone famous in <cite title="Source Title">Source Title</cite></footer>
				    </blockquote>
				  </div>
				</div>
	    	</div>
		</div>
    </div>
</div>

<%@ include file="../footer.jsp" %>
</body>
</html>