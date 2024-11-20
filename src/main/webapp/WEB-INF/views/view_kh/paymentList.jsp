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
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style type="text/css">
table, td, th {
	border: 2px solid #939393;
	text-align: right;
	padding: 15px 10px;
	border-collapse: collapse;
}
</style>
<script type="text/javascript">
	function sendRefundPassword(tid) {
		alert("환불비밀번호를 발송하였습니다!");
		var url = "/KH/pay/sendRefundPassword?tid=" + tid;		
		window.open(url, "_blank", 'width=550,height=550,location=no,status=no,scrollbars=no,top=100,left=300');
		window.close();
	}

</script>
</head>
	<body>
	<div id="paymentListTable">
	<form>
		<table>
			<tr>
				<th>구분</th>
				<th>승인번호</th>
				<th>결제일시</th>
				<th>차량매물번호</th>
				<th>전문가리뷰번호</th>
				<th>결제금액</th>
				<th>취소승인번호발송</th>

			</tr>
			
		<c:forEach	var="paymentList"	items="${paymentList}"	varStatus="status" >
		<c:set		var="num"				value="${num+1 }" />
			<tr>
				<td>${num}</td>						
				<td>${paymentList.approval_num}</td>
				<td>${paymentList.approval_date}</td>
				<td>${paymentList.sell_num}</td>
				<td>${paymentList.expert_review_num}</td>
				<td>
					<fmt:formatNumber 	value="${paymentList.total_price}" 	pattern="#,###,###,###"/> 원
				</td>
				<td><button onclick="sendRefundPassword('${paymentList.approval_num}')" >환불비밀번호발송</button> </td>				
			</tr>
		</c:forEach>
	
		</table>
	</form>
	</div>
	</body>
</html>