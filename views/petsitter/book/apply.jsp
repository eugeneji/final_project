<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<style>
    #my_modal {
        display: none;
        height: 90%;
        overflow:scroll;
        padding: 20px 60px;
        background-color: #fefefe;
        border: 1px solid #888;
        border-radius: 3px;
    }

    #my_modal .modal_close_btn {
        position: absolute;
        top: 10px;
        right: 10px;
    }
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>
	
	<div class="container" style="padding-top: 150px;">
		<div class="row">
			
			<h3 class="titleFont ">예약 내역</h3>
			<c:forEach var="book" items="${bookList}">
	            <div class="card-body col-sm-12 font mb-5 p-0" style="box-shadow: rgba(0, 0, 0, 0.05) 0px 2px 20px;">
	       			<div class="col-sm-6 p-1">
	       				<img src="${pageContext.request.contextPath}/user/${book.user_idx}/profile.png" style="width: 200px; height: 100px; float: left; margin-right: 10px;">
	       				<div>${book.book_writedate} ${book.book_accept ne '2' ? book.book_accept eq '1' ? '<label style="color:blue;">수락 됨</label>' :  '<label style="color:red;">거절 됨</label>' : '<label style="color:yellow;">대기중</label>'}</div>
	       				<div>${book.user_name}</div>
	       				<div>${book.book_price += '원'}</div>
	       			</div>     	
	       			<div class="text-right col-sm-6 mt-5" >
						<span
							style="border-radius: 12px; background-color: white; display: inline-block; height: 50px; margin-left: 20px;">
							<button type="button" class="btn btn-outline-warning font"
								style="border-radius: 12px; width: 100px; height: 50px; font-size: 20px"
								onclick="joinRoom('${book.user_idx }','user')">1:1채팅</button>
							<button type="button" class="btn btn-outline-warning font"
								style="border-radius: 12px; width: 100px; height: 50px; font-size: 20px"
								onclick="showAjax('bookDetail.do?book_idx=${book.book_idx}','${book.user_name}','${book.user_addr}','${book.user_idx }');">예약상세</button>
						</span>
					</div>
	            </div>
	       
			</c:forEach>
			
			<div id="my_modal" >
	    		<a class="modal_close_btn">닫기</a>
	    		
			</div>
		</div>
	</div>
		
<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
<script>
function modal(id, html) {
    var zIndex = 9999;
    var modal = $('#' + id);
    $("#my_modal").html('<a class="modal_close_btn">닫기</a>');
    // 모달 div 뒤에 희끄무레한 레이어
    var bg = $('<div>')
        .css({
            position: 'fixed',
            zIndex: zIndex,
            left: '0px',
            top: '0px',
            width: '100%',
            height: '100%',
            overflow: 'auto',
            // 레이어 색갈은 여기서 바꾸면 됨
            backgroundColor: 'rgba(0,0,0,0.4)'
        })
        .appendTo('body');

    modal
        .css({
            position: 'fixed',
            boxShadow: '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',

            // 시꺼먼 레이어 보다 한칸 위에 보이기
            zIndex: zIndex + 1,

            // div center 정렬
            top: '50%',
            left: '50%',
            transform: 'translate(-50%, -50%)',
            msTransform: 'translate(-50%, -50%)',
            webkitTransform: 'translate(-50%, -50%)'
        })
        .show()
        // 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
        .find('.modal_close_btn')
        .on('click', function() {
            bg.remove();
            modal.hide();
        });
    
    modal.append(html);
}

function showAjax(goUrl,name,addr,idx){
	
	$.ajax({
		url : goUrl,
		success : function(result) {
			
			var test = 
				'<h3 class="titleFont mt-3">예약 세부사항</h3>'+
				'<div class="card col-sm-12 font" style="border-radius: 15px; box-shadow: rgba(0, 0, 0, 0.05) 0px 2px 20px;">'+
					'<div class="col-sm-12 mt-3">'+
						'<div class="col-sm-12 p-0">'+
							'<div class="col-sm-7 pt-5" style="float: left;">'+
								'<p>'+name+' 회원님</p>'+
								'<p>'+addr+'</p>'+
							'</div>'+
								'<img src="${pageContext.request.contextPath}/user/'+idx+'/profile.png" style="width: 200px; margin-top:10px; height: 100px; border-radius: 5px; float: left;">'+
						'</div>'+
					'</div>'+
					'<div class="col-sm-12 mt-5">'+
						'<p>예약하신 날짜 </p>'+	
						'<div class="col-sm-6 pt-1 mb-5">'+
							'<div class="input-group"  style="background-color: white;">'+
								'<span class="input-group-addon" style="width: 50px; font-size: 23px;">'+
									'<i class="fa fa-calendar bigger-110"></i>'+
								'</span>'+
								'<input class="form-control" readonly="readonly" style="text-align: center; font-size: 15px; height: 40px;" value="'+result.book.book_from+'">'+
							'</div>'+
						'</div>'+
						'<div class="col-sm-6 pt-1 mb-5">'+
						'<div class="input-group"  style="background-color: white;">'+
							'<span class="input-group-addon" style="width: 50px; font-size: 23px;">'+
								'<i class="fa fa-calendar bigger-110"></i>'+
							'</span>'+
							'<input class="form-control" readonly="readonly" style="text-align: center; font-size: 15px; height: 40px;" value="'+result.book.book_to+'">'+
						'</div>'+
					'</div>'+
					'</div>'+
					'<div class="col-sm-12 mt-3">'+
						'<div class="col-sm-12 ">'+
							'<p>맡기신 반려동물<p>';
			for(i=0;i<result.pet.length;i++){							
				test += '<div class="col-sm-6 mb-3 p-1" style="border: 1px solid gray;">'+
							'<img src="${pageContext.request.contextPath}/pet/'+result.pet[i].pet_idx+'/profile.png" style="width: 80px; height: 80px; float: left;">'+
							'<div class="col-6" style="float: left;">'+
								'<p>'+result.pet[i].pet_name+'</p>'+
								'<p>';
				var weight = result.pet[i].pet_weight;
				
				if(weight < 7){
					test+='소형/';
				}else if(weight >=15){
					test+='대형/';
				}else{
					test+='중형/';
				}	
				
				if(result.pet[i].pet_sex == 'male'){
					test+='남';
				}else{
					test+='여';	
				}

			    test +='</p>'+
					'</div>'+
					'</div>';
			}
			test +=	'</div>'+
					'<div class=" col-sm-12 mt-3" style="height: 300px;">'+
						'<p>요청사항</p>'+
							'<textarea style="height: 200px;">'+result.book.book_req+'</textarea>'+
						'</div>'+
					'</div>'+
					'<div class="text-center  col-sm-12 mt-3" style="height: 300px;">'+
					'<p  style="float:left">최종 결제 금액<br>'+
					result.book.book_price+'</p>'+
						'<span'+
						'style="border-radius: 12px; background-color: white; display: inline-block; height: 50px; margin-left: 20px;">'+
						'<button type="button" class="btn btn-outline-primary font"'+
							'style="border-radius: 12px; width: 100px; height: 50px; font-size: 20px"'+
							'onclick="accept(1,'+idx+','+result.book.book_idx+','+result.book.book_price+')">수락</button>'+
					'</span>'+
					'<span'+
					'style="border-radius: 12px; background-color: white; display: inline-block; height: 50px; margin-left: 20px;">'+
					'<button type="button" class="btn btn-outline-warning font"'+
						'style="border-radius: 12px; width: 100px; height: 50px; font-size: 20px"'+
						'onclick="accept(0,'+idx+','+result.book.book_idx+','+result.book.book_price+')">거절</button>'+
				'</span>'+
					'</div>'+
				'</div>'+
				'</div>';
			modal('my_modal',test); 
			
			
		}
	});
	
}

function accept(i,idx,book,price){

	if (i == 1){
		$.ajax({
	        url: "payment.do?user_idx="+idx+"&book_idx="+book+"&price="+price,
	        method: "post", 
	        success : function(result) {
	        	alert(result)
	        	if(result === "paid"){
	        		alert("결제 성공");
	        	}else{
	        		alert("결제 실패");
	        	}
			}
	    });
		send('alarm',idx,'<a href="bookList.do">예약이 수락 되었습니다.</a>');
	}else{
		
		send('alarm',idx,'<a href="bookList.do">예약이 거절 되었습니다.</a>');
	}
	
	$.ajax({
        url: "bookUpdate.do?book_idx="+book+"&book_accept="+i,
        method: "post", 
        success : function(result) {
			$("#modal_close_btn").click();
			location.reload();
		}
    });       	
	
}	

</script>
</html>