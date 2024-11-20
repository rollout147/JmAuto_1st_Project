
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>판매자 마이페이지</title>
<link rel="stylesheet" href="../css/myPage.css">
<div class="header_continer"><%@ include file="../header_white.jsp"%></div>
<div class="menu_continer"><%@ include file="../menu_S.jsp"%></div>
<script type="text/javascript" src="../js/jquery.js"></script>
<%@ include file="../kakao.jsp"%>
</head>
<body>
	<div class="container">
		<div class="content_container">
			<div class="content_hed">
				<h1>판매자 마이페이지</h1>
			</div>

			<div class="block_1">
				<div class="block_1_text">판매중인 차량</div>
				<hr />
				<div class="block_1_content_cardlist_body">
					<c:forEach var="Car_General_Info" items="${Car_General_Info}">
						<a href="/carInfo?sellNum=${Car_General_Info.sell_num}&id=${Car_General_Info.user_id}">
							<div class="block_1_content_cardlist_hed">
								<div class="block_1_content_cardlist_img">
									<img src="${Car_General_Info.img_url }" class="cardlist_img_src">
								</div>
								<div class="block_1_content_cardlist_text">
									<div class="block_1_content_cardlist_body_img">
										<img alt=""
											src="<%=request.getContextPath()%>/images/main/구매대기중.png">
									</div>
									<div class="block_1_content_cardlist_text_1">${Car_General_Info.model}</div>
									<div class="block_1_content_cardlist_text_2">${Car_General_Info.car_num }&emsp;${Car_General_Info.price }&emsp;${Car_General_Info.color }</div>
									<div class="block_1_content_cardlist_text_3">판매자 :
										${Car_General_Info.user_id}</div>
								</div>
							</div>
						</a>
					</c:forEach>
				</div>
			</div>
			<div class="block_2">
				<div class="block_2_text_2">판매완료 차량</div>
				<hr />
				
				<div class="block_2_content_cardlist_body">
					<c:forEach var="sellWan" items="${sellWan}">
						<a href="/view_ms/sellWanDetail?sell_num=${sellWan.sell_num }">
						
							<div class="block_2_content_cardlist_hed">
								<div class="block_2_content_cardlist_img">
									<img src="${sellWan.img_url }" class="cardlist_img_src_2">
								</div>
								<div class="block_2_content_cardlist_text">
									<div class="block_2_content_cardlist_body_img">
										<img alt=""
											src="<%=request.getContextPath()%>/images/main/구매완료.png">
									</div>
									<div class="block_2_content_cardlist_text_1">${sellWan.model }</div>
									<div class="block_2_content_cardlist_text_2">${sellWan.car_num}&emsp;${sellWan.price}&emsp;${sellWan.color}</div>
									<div class="block_2_content_cardlist_text_3">판매자 : ${sellWan.user_id}</div>
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