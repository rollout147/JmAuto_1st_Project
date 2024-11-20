<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>구매자 마이페이지</title>
<%@ include file="../kakao.jsp" %>
<link rel="stylesheet" href="../css/myPage.css">
<div class="header_continer">
<%@ include file="../header_white.jsp"%>
</div>
<div class="menu_continer"><%@ include file="../menu_B.jsp" %></div>

<script type="text/javascript" src="../js/jquery.js"></script>
</head>
<style>
body {
	background-color: #fdfdfd;
}

.container {
	max-width: 1200px;
	padding: 20px;
}

h1 {
	text-align: center;
	color: #333;
}

.block {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	padding: 20px;
	background-color: white;
	border-radius: 8px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.left-block, .right-block {
	width: 48%;
}

table {
	width: 100%;
	border: none;
}

th, td {
	padding: 10px;
	text-align: right;
	border:none;
}

.chu-img {
	width: 100%; 
	height: auto; 
}
.mu{
	height: 30px;
	width: 120px;
	text-align: right;
}
button{
	height: 30px;
	width: 100px;
	background-color: #e95a21;
	border-style: none;
	color: white;
}

</style>
<body>
	<div class="container">
		<main class="content">
			<h1 class="text-center" style="font-size: 32px; font-weight: 700;">구매 상세내역</h1><br><br>
			<div class="block">
				<div class ="left-block">
					<table class="gumae" style="padding-top: 50px;">
					<div style="padding-left: 50px; padding-top: 40px;"><span style="font-size:20px; font-weight: bold ">상세 구매 내역</span></div>
						<tr><th>계약번호 : <td>${Payment.approval_num}</td></th></tr>
						<tr><th>계약완료일 : <td>${Payment.approval_date}</td></th>						
						<tr><th>모델명 : <td>${Payment.model}</td></th></tr>
						<tr><th>외장색상 : <td>${Payment.color}</td></th></tr>			
						<tr><th>결제금액 : <td>${Payment.price}</td></th></tr>
						<tr><th>판매자 : <td>${Payment.receiver_name}</td></th></tr>
						<tr><th>진행상황 : <td style="color:red">차량구매 완료</td></th></tr>	
						<tr><th style="color: gray; font-size: 14px; text-decoration: underline; margin-top: 20px;">
        					<a href="#" onclick="window.open('/view_jw/csQna?mode=refund&qna_cls=환불','_blank', 'width=600, height=800'); return false;">
                            환불 신청하기</a></th></tr>
					</table>
				</div>
		
				<div class="right-block" >
					<table class="gumaeCar" >						
						<tr><td class="">
							<c:if test="${reviewExists && hoogiya.del_state == 0}">
								<a href="/view_ms/reviewDetail?approval_num=${Payment.approval_num}">
									<button type="button">후기보기</button>
								</a>
							</c:if>
							<c:if test="${!reviewExists}">
								<a href="/view_ms/hoogi?approval_num=${Payment.approval_num}">
									<button type="button">후기작성</button>
								</a>
							</c:if>
							<c:if test="${reviewExists && hoogiya.del_state == 1}">
									<button type="button">후기만료</button>
							</c:if>
						</td></tr>			
						<tr><td style="color:red; ">${Payment.approval_date} 차량구매 완료</td></tr>					
						<tr>
                    		<td><img alt="chuCarimg" src="${Payment.img_url }" class="chu-img"></td>
            			</tr>
        				
        				<tr><td style="display: flex; justify-content: flex-end;">
        				<a href="" onclick="window.open('/view_jw/csQna','_blank', 'width=600, height=800'); return false;">
							<span style="color: #e95a21;" >문의하기 ></span></a></td>
							</tr>	
					</table>
				</div>
			</div>				
		</main>
</div>
	<!--------------------------------------- 푸터 --------------------------------------->
	<%@ include file="../footer.jsp" %>
</body>
</html>