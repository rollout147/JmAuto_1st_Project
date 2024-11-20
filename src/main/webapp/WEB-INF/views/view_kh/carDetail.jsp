<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style type="text/css">
a:hover {
	text-decoration: underline;
	border: 2px solid Blue;
}

</style>
</head>
	<body>
	
		<h1>매물정보</h1>

			<h5>매물번호 : ${carDetail.sell_num }</h5>
			<h5>차종 : ${carDetail.car_type }</h5>
			<h5>제조사 : ${carDetail.brand }</h5>
			<h5>모델 : ${carDetail.model }</h5>
			<h5>차량번호 : ${carDetail.car_num }</h5>
			<h5>제조일 : ${carDetail.manu_date }</h5>
			<h5>주행거리 : ${carDetail.mileage }</h5>
			<h5>색상 : ${carDetail.color }</h5>
			<h5>연료 : ${carDetail.fuel }</h5>
			<h5>변속기 : ${carDetail.transmission }</h5>
			<h5>사고유무 : ${carDetail.accident }</h5>
			<h5>압류유무 : ${carDetail.repossession }</h5>
			<h5>차량가격 : ${carDetail.price * 10000} 원</h5>
			<h5>자동차등록증경로 : ${carDetail.sell_regi }</h5>
			<h5>자동차세완납증명서경로 : ${carDetail.sell_certi_tax }</h5>
			<h5>신분증사본 경로 : ${carDetail.sell_shinbun }</h5>
			<h5>판매자 아이디 : ${carDetail.user_id }</h5>
			<h5>판매여부 : ${carDetail.sale }</h5>
			<h5>등록일자 : ${carDetail.reg_date }</h5>
			<h5>삭제여부 : ${carDetail.del_state }</h5>
			
		<h1>
			<a href="/KH/pay/goPay?sell_num=${carDetail.sell_num }">
				구매하기
			</a>
		</h1>
		
		<h2>ExperReviewList</h2>
			<c:forEach var="expertReviewList" items="${expertReviewList }">
	 			<a onclick="window.open('/KH/pay/expertReviewPage?expert_review_num=${expertReviewList.expert_review_num }', '전문가리뷰보기', 'width=700,height=1000,location=no,status=no,scrollbars=yes,top=300,left=300')">
				${expertReviewList.expert_review_num }
				</a>
				<br>
			</c:forEach>

	</body>
</html>