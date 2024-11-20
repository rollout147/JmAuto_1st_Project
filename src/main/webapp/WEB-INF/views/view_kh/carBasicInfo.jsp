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
table {
	border: 2px solid #d3d3d3;
}

.left {
	width: 150px;
	height: 50px;
	font-size: 20px;
	font-weight: 900;
	color: #FF4714;
	padding-left: 10px;
	text-align: left;
}

.right {
	width: 350px;
	height: 50px;
	font-size: 20px;
	font-weight: 700;
	color: #323232;
	padding-left: 10px;
	text-align: left;

}

</style>

</head>
	<body>
			<h2>차량기본정보</h2>
			
			<table>
				<tr>
					<th class="left">제조사</th>
					<td class="right">${carDetail.brand }</td>
				</tr>
				<tr>
					<th class="left">모델</th>
					<td class="right">${carDetail.model }</td>
				</tr>
				<tr>
					<th class="left">차량번호</th>
					<td class="right">${carDetail.car_num }</td>
				</tr>
				<tr>
					<th class="left">제조일</th>
					<td class="right">
						<c:set var="manu_date" value="${carDetail.manu_date }"/>
						${fn:substring(manu_date,0,2) } 년 / ${fn:substring(manu_date,2,4) } 월	
					</td>
				</tr>
				<tr>
					<th class="left">연료</th>
					<td class="right">${carDetail.fuel }</td>
				</tr>
				<tr>
					<th class="left">변속기</th>
					<td class="right">${carDetail.transmission }</td>
				</tr>
				<tr>
					<th class="left">사고유무</th>
					<td class="right">${carDetail.accident }</td>
				</tr>
				<tr>
					<th class="left">압류유무</th>
					<td class="right">${carDetail.repossession }</td>
				</tr>
				<tr>
					<th class="left">차량가격</th>
					<td class="right">${carDetail.price * 10000 } 원</td>
				</tr>
			</table>
			
			<%-- 			
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
			<h5>차량가격 : ${carDetail.price * 10000 } 원</h5>
			<h5>자동차등록증경로 : ${carDetail.sell_regi }</h5>
			<h5>자동차세완납증명서경로 : ${carDetail.sell_certi_tax }</h5>
			<h5>신분증사본 경로 : ${carDetail.sell_shinbun }</h5>
			<h5>판매자 아이디 : ${carDetail.user_id }</h5>
			<h5>판매여부 : ${carDetail.sale }</h5>
			<h5>등록일자 : ${carDetail.reg_date }</h5>
			<h5>삭제여부 : ${carDetail.del_state }</h5>
 			--%>
	</body>
</html>