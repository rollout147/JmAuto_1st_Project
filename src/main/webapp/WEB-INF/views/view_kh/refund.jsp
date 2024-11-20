<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>
#btn-kakao {
	background-color: #FF4714;
	color: #FDFDFD;
	font-weight: 800;
	border: none;
	border-radius: 12px;
	padding: 10px 20px;
	cursor: pointer;
}
</style>

</head>
<body>
	<%@ include file="../header_white.jsp" %>

	<hr>

		<h5>구매자 : ${paymentDetail.user_id }</h5>
		<h5>승인번호 : ${paymentDetail.approval_num }</h5>
		<h5>승인일자 : ${paymentDetail.approval_date }</h5>
		<h5>매물번호 : ${paymentDetail.sell_num }</h5>
		<h5>전문가평가번호 : ${paymentDetail.expert_review_num }</h5>
		<h5>가격 : ${paymentDetail.price * 10000} 원</h5>
		<h5>세금 : ${paymentDetail.tax * 10000} 원</h5>
		<h5>대행수수료 : ${paymentDetail.fee * 10000} 원</h5>
		<h5>결제금액 : ${paymentDetail.total_price * 10000} 원</h5>
		<h5>판매수수료 : ${paymentDetail.buz_fee * 10000} 원</h5>
		<h5>판매자입금금액 : ${paymentDetail.buz_money * 10000} 원</h5>
		<h5>업체명 : ${paymentDetail.receiver_name }</h5>
		<h5>전화번호 : ${paymentDetail.receiver_tel }</h5>
		<h5>구매자우편번호 : ${paymentDetail.receiver_zipcode }</h5>
		<h5>구매자주소1 : ${paymentDetail.receiver_addr1 }</h5>
		<h5>구매자주소2 : ${paymentDetail.receiver_addr2 }</h5>
		<h5>보험증명파일이름 : ${paymentDetail.insure_img_name }</h5>
		<h5>보험증명파일경로 : ${paymentDetail.insure_img_url }</h5>
		<h5>배송일자 : ${paymentDetail.delivery_date }</h5>
		<h5>결제구분 : ${paymentDetail.buy_type }</h5>

	<hr>
	<hr>


	<button id="btn-kakao"
			onclick="location.href='/order/pay/refundPayment?approval_num=${paymentDetail.approval_num }'">
			                  
		KakaoPay<br>환불요청 
		<i class="fa-solid fa-comment"></i>
	</button>

</body>
</html>

