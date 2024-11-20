<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>구매자 - 내가 쓴 후기</title>
<link rel="stylesheet" href="../css/myPage.css">
<div class="header_continer"><%@ include file="../header_white.jsp"%></div>
<div class="menu_continer"><%@ include file="../menu_P.jsp" %></div>
<%@ include file="../kakao.jsp" %>
<script type="text/javascript" src="../js/jquery.js"></script>
<style type="text/css">
.content{
	background-color:#fdfdfd;
	width: 1380px;
	box-shadow: 0 0 10px 5px rgb(0,0,0,0.06);
	margin: 0 0 80px;
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
.button{
	display: flex; /* Flexbox 사용 */
	justify-content: center; /* 수평 중앙 정렬 */
	align-items: center; /* 수직 중앙 정렬 */
	width: 100%; /* 전체 너비 사용 */
}
.image-button {
    background: none; /* 기본 배경 제거 */
    border: none; /* 기본 테두리 제거 */
    padding: 0; /* 기본 패딩 제거 */
    cursor: pointer; /* 커서 모양 변경 */
    width: 148px; 
    height: 42.45px;;

}
.button-image {
    width: 148px; 
    height: 42.45px;; 
}
/* 버튼이 클릭되었을 때의 스타일 (선택 사항) */
.image-button:focus {
    outline: none; /* 포커스 아웃라인 제거 */
}
#userUpdate {
  background: none;         /* 버튼 배경 없애기 */
  border: none;             /* 버튼 테두리 없애기 */        
  cursor: pointer;          /* 클릭 가능한 커서로 변경 */
}

#userUpdate img {
  display: block;           /* 이미지가 버튼 안에 꽉 차게 함 */
  width: 45px;              /* 버튼 크기에 맞게 이미지 크기 조절 */
  height: auto;            /* 이미지 비율 유지 */
}
</style>
</head>



<script type="text/javascript">
	/* 체크박스 함수 */
		function handleSubmit(){
			const checkboxes = document.querySelectorAll('input[type="checkbox"]:checked');
			//querySelectorAll이라는 메서드를 사용해 현재 문서에 체크된 :checked요소를 모두 선택해 결과를 nodeList로 반환
			const selectedPosts = Array.from(checkboxes).map(checkbox => (checkbox.value));
			//map 메서드를 사용해 checkbox.value를 호출해 체크박스 값을 수집				이거는 string이니까 형변환X
			if(selectedPosts.length===0){
				alert('삭제할 게시물을 선택해주세요');
				return;
			}
			//서버에 삭제요청을 보낸다.
			$.ajax({
				url: '/myHoogiDelete',
				type: 'POST',
				contentType: 'application/json',
				data: JSON.stringify(selectedPosts),
				success: function(response){
					alert('선택한 게시물이 삭제되었습니다.');
					location.reload();
				},
				error: function(xhr, status, error){
					alert('삭제실패:' + xhr.statusText);
				}
			});
		}
</script>


<body>
	<div class="container">
		<main class="content">
			<h1 class="text-center" style="font-size: 32px; font-weight:700;  text-align: center;">나의 전문가리뷰</h1><br><br>
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
								<td onclick="location.href='/KH/pay/expertReviewPage?expert_review_num=${Expert_Review.expert_review_num}'" style="cursor: pointer;">
								${Expert_Review.expert_review_num}</td>
								
								<td onclick="location.href='/KH/pay/expertReviewPage?expert_review_num=${Expert_Review.expert_review_num}'" style="cursor: pointer;">
										<c:choose>
											<c:when test="${fn:length(Expert_Review.content) > 10}">
           								 		${fn:substring(Expert_Review.content, 0, 10)}...
        									</c:when>
        								
											<c:otherwise> 
												${Expert_Review.content}
	        								</c:otherwise>
										</c:choose>
								</td>
								<td onclick="location.href='/KH/pay/expertReviewPage?expert_review_num=${Expert_Review.expert_review_num}'" style="cursor: pointer;">
									<div class="rating">
									<c:set var="starCount" value="${Expert_Review.score/20}" />
										<c:forEach var="i" begin="1" end="5">
											<span
												class="${i <= starCount ? 'star filled' : 'star'}">&#9733;</span>
										</c:forEach>
									</div>
								</td>
								<td onclick="location.href='/KH/pay/expertReviewPage?expert_review_num=${Expert_Review.expert_review_num}'" style="cursor: pointer;">
   									 <fmt:formatDate value="${Expert_Review.write_date}" pattern="yyyy-MM-dd" />
								</td>
								<td onclick="location.href='/KH/pay/expertReviewPage?expert_review_num=${Expert_Review.expert_review_num}'" style="cursor: pointer;">
								${Expert_Review.price}원</td>
								<td><img alt="" src="../images/main/답변완료.png"> </td>
								<td class="button" style="padding-left: 0;">
									<a href="/KH/pay/modifyExpertReview?expert_review_num=${Expert_Review.expert_review_num}" >
									<button type="submit" id="userUpdate"><img alt="" src="../images/main/수정이.png"></button></a>
								</td>
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