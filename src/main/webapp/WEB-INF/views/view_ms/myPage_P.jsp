<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>전문가 마이페이지</title>
<link rel="stylesheet" href="../css/myPage.css">
<div class="header_continer"><%@ include file="../header_white.jsp"%></div>
<div class="menu_continer"><%@ include file="../menu_P.jsp" %></div>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript"><%@ include file="../kakao.jsp" %></script>
</head>

<body>
	<div class="container">
		<div class="content_container">
			<div class="content_hed">
				<h1>전문가 마이페이지</h1>
			</div>

			<div class="block_1">
				<div class="block_1_text" style="font-size: 32px;">나의 전문가리뷰</div>
				<hr />
				<div class="block_1_content_cardlist_body">
					<c:forEach var="Expert_Review" items="${Expert_Review}">
						<a href="/KH/pay/expertReviewPage?expert_review_num=${Expert_Review.expert_review_num }">
							<div class="block_1_content_cardlist_hed">
								<div class="block_1_content_cardlist_img">
									<img src="${Expert_Review.img_url }" class="cardlist_img_src">
								</div>
								<div class="block_1_content_cardlist_text">
									<div class="block_1_content_cardlist_body_img">
										<img alt=""
											src="<%=request.getContextPath()%>/images/main/구매대기중.png">
									</div>
									<div class="block_1_content_cardlist_text_1">${Expert_Review.model}</div>
									<div class="block_1_content_cardlist_text_2">${Expert_Review.car_num }&emsp;${Expert_Review.price }&emsp;${Expert_Review.color }</div>
									<div class="block_1_content_cardlist_text_3">작성자 :
										${Expert_Review.user_id}</div>
								</div>
							</div>
						</a>
					</c:forEach>
				</div>
			</div>
			<div class="block_2">
				<div class="block_2_text_2"  style="font-size: 32px;">관심목록</div>
				<hr />
				
				<div class="block_2_content_cardlist_body">
					<c:forEach var="Zzim" items="${Zzim}">
						<a href="/carInfo?sellNum=${Zzim.sell_num}&id=${Zzim.user_id}">
						
							<div class="block_2_content_cardlist_hed">
								<div class="block_2_content_cardlist_img">
									<img src="${Zzim.img_url }" class="cardlist_img_src_2">
								</div>
								<div class="block_2_content_cardlist_text">
									<div class="block_2_content_cardlist_body_img">
										<img alt=""
											src="<%=request.getContextPath()%>/images/main/구매완료.png">
									</div>
									<div class="block_2_content_cardlist_text_1">${Zzim.model }</div>
									<div class="block_2_content_cardlist_text_2">${Zzim.car_num}&emsp;${Zzim.price}&emsp;${Zzim.color}</div>
									<div class="block_2_content_cardlist_text_3">판매자 :
										${Zzim.car_user_id}</div>
								</div>
							</div>
						</a>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
	<!------------------------------------------ 푸터 -------------------------------------------->
	<%@ include file="../footer.jsp" %>
</body>
</html>