<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>구매자 마이페이지</title>
<link rel="stylesheet" href="../css/myPage.css">
<div class="header_continer"><%@ include file="../header_white.jsp"%></div>
<div class="menu_continer"><%@ include file="../menu_B.jsp"%></div>
<script type="text/javascript" src="../js/jquery.js"></script>
<%@ include file="../kakao.jsp"%>

</head>
<style>
	div.block_1_content_cardlist_body{
		width: 1380px;
		margin: 10px;
	}
	div.block_1{
		margin:10px;
	}
</style>
<body>
	<div class="container">
		<div class="content_container">
			<div class="content_hed">
				<h1 style="font-size: 40px;">구매자 마이페이지</h1>
			</div>

			<div class="block_1">
				<div class="block_1_text" style="font-size: 32px;">찜한차량</div>
				<hr />
				<div class="block_1_content_cardlist_body">
					<c:forEach var="Zzim" items="${Zzim}">
						<a href="/carInfo?sellNum=${Zzim.sell_num}&id=${Zzim.car_user_id}">
							<div class="block_1_content_cardlist_hed">
								<div class="block_1_content_cardlist_img">
									<img src="${Zzim.img_url }" class="cardlist_img_src">
								</div>
								<div class="block_1_content_cardlist_text">
									<div class="block_1_content_cardlist_body_img">
										<img alt=""
											src="<%=request.getContextPath()%>/images/main/구매대기중.png">
									</div>
									<div class="block_1_content_cardlist_text_1">${Zzim.model}</div>
									<div class="block_1_content_cardlist_text_2">${Zzim.car_num }&emsp;${Zzim.price }&emsp;${Zzim.color }</div>
									<div class="block_1_content_cardlist_text_3">판매자 :${Zzim.car_user_id}</div>
								</div>
							</div>
						</a>
					</c:forEach>
				</div>
			</div>
			<div class="block_2">
				<div class="block_2_text_2"  style="font-size: 32px;">구매내역</div>
				<hr />
				
				<div class="block_2_content_cardlist_body">
					<c:forEach var="Payment" items="${Payment}">
						<a href="/view_ms/buyListDetail?approval_num=${Payment.approval_num }">
						
							<div class="block_2_content_cardlist_hed">
								<div class="block_2_content_cardlist_img">
									<img src="${ Payment.img_url }" class="cardlist_img_src">
								</div>
								<div class="block_2_content_cardlist_text">
									<div class="block_2_content_cardlist_body_img">
										<img alt=""
											src="<%=request.getContextPath()%>/images/main/구매완료.png">
									</div>
									<div class="block_2_content_cardlist_text_1">${Payment.model }</div>
									<div class="block_2_content_cardlist_text_2">${Payment.car_num}&emsp;${Payment.price}&emsp;${Payment.color}</div>
									<div class="block_2_content_cardlist_text_3">판매자 :${Payment.car_user_id}</div>
								</div>
							</div>
						</a>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
	<!------------------------------------------ 푸터 -------------------------------------------->
	<%@ include file="../footer.jsp"%>
</body>
</html>