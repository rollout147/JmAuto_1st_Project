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
		<main class="content">
			<h1 class="text-center">
				<a href="#">내가 작성한 전문가리뷰 -> 완성되면 페이지 연결완료(/KH/pay/expertReviewPage)</a>
			</h1>
			<br>
			<br>
			<div class="block">		
				<table>
					<thead>
						<tr>
							<th>리뷰번호</th>
							<th>매물번호</th>
							<th>리뷰작성일</th>
							<th>리뷰내용</th>
							<th>작성자</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="Expert_Review" items="${Expert_Review}">
							<tr>
								<td>${Expert_Review.expert_review_num }</td>
								<td>${Expert_Review.sell_num }</td>
								<td>${Expert_Review.write_date}</td>
								<td>${Expert_Review.content}</td>
								<td>${Expert_Review.user_id}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<button type="submit" class="submit" 
			onclick="window.open('/view_jw/csQna','_blank', 'width=600, height=800'); return false;">
				문의하기</button>
		</main>
</div>
	<!------------------------------------- 푸터 ----------------------------------------->
	<%@ include file="../footer.jsp" %>
</body>

</html>