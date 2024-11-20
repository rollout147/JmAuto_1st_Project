<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="/css/csReview.css" rel="stylesheet" type="text/css"/>
<meta charset="UTF-8">
<title>고객후기</title>

<script type="text/javascript">
	function reviewDetail(approval_num, user_id, sell_num) {

		var url = "/csReviewDetail?approval_num=" + approval_num
					+ "&user_id=" + user_id
					+ "&sell_num=" + sell_num;
		
		window.open(url, "_blank", 'width=650,height=800,location=no,status=no,scrollbars=no,top=100,left=300');
	}
</script>

</head>
<body>
	<!-- 사이드바 -->
	<div class="header_continer"><%@ include file="../header_white.jsp"%></div>
	<div class="menu_continer"><%@ include file="../view_mh/menu_CS.jsp" %></div>
	<%@ include file="../kakao.jsp" %>
	
	<!-- 후기 메인 내용 -->
	<div class="review">
		<div class="reviewContainer">
			<h1>고객후기</h1>
			<span class="reviewMent">이용자들의 생생한 후기를 체험하세요</span>

			<form action="view_jw/csReviewDetail" method="get">
			    
				<div class="reviewContent">
					<c:forEach var="review" items="${ reviewListInfo }">
							
						<div class="reviewList">
							<a href="#" onclick="reviewDetail('${review.approval_num}', '${review.user_id}', '${review.sell_num}'); return false;">
								<img alt="" src="${ review.img_url }" class="rev_img">
								<div class="reviewdetail">
									
									<div class="rev_evaluetion">
										<c:choose>
											<c:when test="${review.evaluation == 5}">
												<img alt="별5점" src="../images/main/star_5.png" class="star_img">
											</c:when>
											<c:when test="${review.evaluation == 4}">
												<img alt="별4점" src="../images/main/star_4.png" class="star_img">
											</c:when>
											<c:when test="${review.evaluation == 3}">
												<img alt="별3점" src="../images/main/star_3.png" class="star_img">
											</c:when>
											<c:when test="${review.evaluation == 2}">
												<img alt="별2점" src="../images/main/star_2.png" class="star_img">
											</c:when>
											<c:otherwise>
												<img alt="별1점" src="../images/main/star_1.png" class="star_img">
											</c:otherwise>
										</c:choose>
									</div>
									
									<div class="title">${review.review_title}</div>
									<div class="info">
										${review.manu_date_char }&emsp;&emsp;
										${review.mileage }km&emsp;&emsp;
										${review.fuel}
									</div>
									<div class="content">${review.review_content}</div>
									<div class="date">${review.review_date}</div>
									
								</div>
							</a>
						</div>
						
					</c:forEach>
				</div>
			
				<!-- 페이지작업 -->
				<div class="reviewPage">
					<c:set var="num" value="${page.total-page.start+1 }"></c:set>
					<c:if test="${page.startPage > 1 }">
						<a href="csReview?currentPage=${page.startPage-page.pageBlock }">[이전]</a>	
					</c:if>
					
					<c:forEach var="i" begin="${page.startPage }" end="${page.endPage }">
						 <c:choose>
				            <c:when test="${i == page.currentPage}">
				                <a href="csReview?currentPage=${i}" class="currentPage">[${i}]</a>
				            </c:when>
				            <c:otherwise>
				                <a href="csReview?currentPage=${i}">[${i}]</a>
				            </c:otherwise>
				        </c:choose>
					</c:forEach>
					
					<c:if test="${page.endPage < page.totalPage }">
						<a href="csReview?currentPage=${page.startPage+page.pageBlock }">[다음]</a>
					</c:if>
				</div>
				
			</form>
		</div>
	
	</div>
	
	<%@ include file="../footer.jsp" %>  

</body>
</html>