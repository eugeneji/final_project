<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
	위탁 펫시터는 반려동물을 위탁 받아 펫시터님의 집에서 케어/산책 해주는 서비스 입니다.<br>

펫플래닛과 함께라면 국내 최고의 펫시터가 될 수 있습니다 :)<br>
반려동물을 향한 따뜻한 마음을 가진 분과 함께하고 싶습니다.<br>
그 외의 다른 전문적인 부분은 국내최고 반려동물 전문가들과 함께 도와드리겠습니다.<br>
<br>
< 지원 전 확인 사항 ><br>
<br>
1. 지원 자격 요건<br>
 *** 반려견을 키워본 경험이 있으신 분 (혹은 유치원, 카페 등에서 근무한 경험)<br>
 *** 현재 서울시, 경기도, 인천 거주자 모집중 <br>
 - 27세 이상 (95년 출생자 이상)<br>
 - 책임 의식을 가지고 열심히 하실 분 (근무 가능일 수가 한달 15일 이상)<br>
<br>
2. 우대사항<br>
- 반려동물 5년이상 키워본 경험<br>
- 위탁 또는 방문 펫시터 유경험자 (개인 / 타업체) <br>
- 반려동물 관련 자격증 소지자, 관련학과 전공<br>
<br>
3. 펫시터 활동 절차<br>
  * 4단계 검증 : 1차 (서류심사) > 2차 (대면 면접) > 3차 (안전성 검증) > 4차 (오프라인교육)<br>
     1) 1차 서류심사 : 서류심사 합격 여부는 합격자에 한해서 개별 연락드립니다.<br>
     2) 2차 대면면접 : 서류합격자에 한 해 오프라인 면접이 진행됩니다.<br>
     3) 3차 안전성 검증 : 지원자님의 댁에 방문하여, 펫시팅 환경 검증이 이루어 집니다.<br>
     4) 오프라인교육 : 3차까지 완료된 지원자는 오프라인 교육 이수 후에 펫시팅 활동이 가능합니다.<br>
<br>

</div>

	<form action="sitterReq.do" name="sitterReq" method="post">
		<div>
			지원자 성명<br> ex)홍길동<br> <input type="text" name="name"
				value="${sessionScope.name}" required="required">
		</div>

		<div>
			성별<br> <input type="radio" name="sex" value="남자"
				<c:if test="${sessionScope.sex == '남자'}">checked="checked"</c:if>>
			<input type="radio" name="sex" value="여자"
				<c:if test="${sessionScope.sex == '여자'}">checked="checked"</c:if>>
		</div>
		<div>
			생년월일<br> 날짜 <input type="date" name="birth"
				value="${sessionScope.birth }" required="required">
		</div>
		<div>
			연락처(핸드폰 번호)<br> 합격 여부를 알려드리기 위해 핸드폰 연락처가 필요합니다<br> <input
				type="tel" name="tel" value="${sessionScope.tel}" required="required">
		</div>
		<div>
			이메일 주소<br> <input type="email" name="email"
				value="${sessionScope.email }" required="required">
		</div>
		<div>
			거주지 주소<br> <input type="text" name="addr"
				value="${sessionScope.arrt }" required="required">
		</div>
		<div>
			계좌번호<br> 은행<input type="text" name="bank"> 계좌번호<input
				type="text" name="account" placeholder="-제외하고 숫자만 입력하세요" required="required">
		</div>
		<div>
		소개글<br>
		<textarea rows="15" cols="55" name="content"></textarea>
		</div>
		<div>
			<input type="submit" name="제출">  
		</div>
	</form>

</body>
</html>