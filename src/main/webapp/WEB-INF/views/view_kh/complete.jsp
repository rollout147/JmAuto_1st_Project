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
#completePayment{
	width: 1320px;
	height: 1080px;
	margin-left: 300px;
	background-image: url("<%=request.getContextPath()%>/images/main/kh_completePayment.png");
	background-repeat: no-repeat;
	background-size: 100%;
}
/*
table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
}
*/
#carInfo {
	position: absolute;
	top: 455px;
	left: 550px;
	overflow:hidden

}

#carInfoModel{
	height: 80px;
	text-align: left;
	font-size: 24px;
	font-weight: 900;
	overflow:hidden

}

.carInfoCellLeft{
	width: 350px;
	height: 80px;
	text-align: right;
	font-size: 24px;
	font-weight: 900;
	overflow:hidden;
}

.carInfoCellRight{
	width: 550px;
	height: 80px;
	text-align: right;
	font-size: 24px;
	font-weight: 900;
	overflow:hidden
}

</style>

<script type="text/javascript">
	$(function(){
		alert("차량을 구매해주셔서 감사합니다.");
		location.href="/view_ms/myPage_B";
	});
</script>

</head>
<body>
	<%-- 
	<header>
		<%@ include file="../header_white.jsp" %>
	</header>
 	--%>
 	
 	<div id="completePayment">
 		<div id="carInfo">
 			<table id="carInfoTable">
 				<tr>
 					<td id="carInfoModel" colspan="2">
 						${carDetail.brand }&nbsp;${carDetail.model }
 					</td>
 				</tr>
 				
 				<tr>
 					<td class="carInfoCellLeft">
 						${carDetail.car_num }
 					</td>
 					<td class="carInfoCellRight">
 						<c:set var="manu_date" value="${carDetail.manu_date }"/>
						${fn:substring(manu_date,0,2) } 년 / ${fn:substring(manu_date,2,4) } 월
 					</td>
 				</tr>
 				
 				<tr>
 					<td class="carInfoCellLeft">
 						<fmt:formatNumber 	value="${carDetail.mileage }" 	pattern="#,###,###"/> km
 					</td>
 					<td class="carInfoCellRight">
 						${carDetail.transmission }
 					</td>
 				</tr>
 				
 				<tr>
 					<td class="carInfoCellLeft">
 						${carDetail.accident }
 					</td>
 					<td class="carInfoCellRight">
 						${carDetail.accident }
 					</td>
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
			<h5>연료 : ${carDetail.accident }</h5>
			<h5>변속기 : ${carDetail.transmission }</h5>
			<h5>사고유무 : ${carDetail.accident }</h5>
			<h5>압류유무 : ${carDetail.repossession }</h5>
			<h5>차량가격 : ${carDetail.price * 11700} 원</h5>
			<h5>자동차등록증경로 : ${carDetail.sell_regi }</h5>
			<h5>자동차세완납증명서경로 : ${carDetail.sell_certi_tax }</h5>
			<h5>신분증사본 경로 : ${carDetail.sell_shinbun }</h5>
			<h5>판매자 아이디 : ${carDetail.user_id }</h5>
			<h5>판매여부 : ${carDetail.sale }</h5>
			<h5>등록일자 : ${carDetail.reg_date }</h5>
			<h5>삭제여부 : ${carDetail.del_state }</h5>
		 	--%>
		</div>
	</div>
</body>
</html>