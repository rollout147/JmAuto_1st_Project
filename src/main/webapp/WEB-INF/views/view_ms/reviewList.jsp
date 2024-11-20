<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>구매자 - 내가 쓴 후기</title>
<link rel="stylesheet" href="../css/myPage.css">
<div class="header_continer"><%@ include file="../header_white.jsp"%></div>
<div class="menu_continer"><%@ include file="../menu_B.jsp" %></div>
<%@ include file="../kakao.jsp" %>
<script type="text/javascript" src="../js/jquery.js"></script>
<style type="text/css">

.content{
	background-color:#f1f1f1;
	width: 1380px;
}
.block{
	background-color: white;
	width: 1240px;
}
.content {
	background-color: white;
	border-bottom: 10px;
	border-top: 10px;
	display: center;
	margin-top: 50px;
	padding-top: 50px;
	
}

.border {
	border-bottom: 10px;
	border-top: 10px;
	width: 1280px;
	padding-left: 50px;
	display: center;
	padding-top: 40px;
	padding-bottom: 100px;
	font-size: 16px;
	
}
.container{
	display:center;
	background-color: #fdfdfd;
}

tbody tr {
	background-image: url('../images/note.png'); /* 노트 이미지 경로 */
	background-size: cover; /* 이미지 크기 조정 */
	background-repeat: no-repeat;
	background-position: center;
	height: 50px; /* 행 높이 조정 */
}

tbody tr:last-child {
	background-image: none; /* 마지막 행은 이미지 제거 */
}
tbody td,
thead td{
	padding: 10px;
}

tbody tr {
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.10); /* 아래쪽으로 그림자 효과 */
	margin-bottom: 10px; /* 간격 조정 */
}
.block{
	display: center;
}
.rating {
    font-size: 24px; /* 별 크기 조절 */
}

.star {
    color: gray; /* 기본 색상 */
    margin-right: 2px; /* 간격 조정 */
}

.star.filled {
    color: gold; /* 채워진 별 색상 */
}
</style>
</head>


<body>
	<div class="container">
		<main class="content">
			<h1 class="text-center" style="font-size: 32px; font-weight:700; text-align: center;">구매한 전문가리뷰</h1><br><br>
			<div class="block">
				<table class="border">
					<thead>
						<tr>
							<td></td>
							<td>리뷰번호</td>
							<td>리뷰내용</td>
							<td>리뷰평점</td>
							<td>작성일자</td>
							<td>가격</td>
							<td>진행상태</td>
						</tr>
					</thead>
					<tbody>	
						<c:forEach var ="Expert_Review" items="${Expert_Review}">
						
							<tr>
								<td></td>
								<td><a href="/KH/pay/expertReviewPage?expert_review_num=${Expert_Review.expert_review_num}">${Expert_Review.expert_review_num}</td>
								<td><a href="/KH/pay/expertReviewPage?expert_review_num=${Expert_Review.expert_review_num}"><c:choose>
										<c:when test="${fn:length(Expert_Review.content) > 10}">
           								 	${fn:substring(Expert_Review.content, 0, 10)}...
        								</c:when>
										<c:otherwise> 
										${Expert_Review.content}
	        							</c:otherwise>
									</c:choose>
								</td>
								<td><a href="/KH/pay/expertReviewPage?expert_review_num=${Expert_Review.expert_review_num}">
									<div class="rating">
									<c:set var="starCount" value="${Expert_Review.score/20}" />
										<c:forEach var="i" begin="1" end="5">
											<span
												class="${i <= starCount ? 'star filled' : 'star'}">&#9733;</span>
										</c:forEach>
									</div>
								</td>
								<td>${Expert_Review.write_date}</td>
								<td>${Expert_Review.total_price}원</td>
								<td><a href="/KH/pay/expertReviewPage?expert_review_num=${Expert_Review.expert_review_num}"><img alt="" src="../images/main/구매완료.png"></td>
							</tr>
						</c:forEach>	
					</tbody>
				</table>
			</div>
						
		</main>
		<!-- <img src="../images/main/삭제_but.png" alt="삭제하기" onclick="handleSubmit()" style="cursor: pointer;"> -->
</div>
	<!--------------------------------------- 푸터 --------------------------------------->
	<%@ include file="../footer.jsp" %>
</body>
</html>