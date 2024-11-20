<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="../js/jquery.js"></script>

<title>마이페이지</title>
<%@ include file="../kakao.jsp" %>
<link rel="stylesheet" href="../css/myPage.css">
<div class="header_continer"><%@ include file="../header_white.jsp"%></div>
<div class="menu_continer"><%@ include file="../menu_B.jsp" %></div>
</head>
<style>
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
	padding-bottom: 40px;
}
.container{
	display:center;
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
.buttondle {
    display: flex;
    justify-content: center; /* 수평 중앙 정렬 */
    margin-top: 10px; /* 버튼과 테이블 사이 간격 */
}

</style>
<script type="text/javascript">
	/* 
	/* 체크박스 함수 */
	function handleSubmit(){
		const checkboxes = document.querySelectorAll('input[type="checkbox"]:checked');
		//querySelectorAll이라는 메서드를 사용해 현재 문서에 체크된 :checked요소를 모두 선택해 결과를 nodeList로 반환
		const selectedPosts = Array.from(checkboxes).map(checkbox => checkbox.value);
		//map 메서드를 사용해 checkbox.value를 호출해 체크박스 값을 수집
		//alert('' + selectedPosts.join(', '));
		//선택한 게시물에 id를 서버로 전송하는 등의 작업을 수행할 수 있다.
		if(selectedPosts.length===0){
			alert('삭제할 게시물을 선택해주세요');
			return;
		}
		
		//서버에 삭제요청을 보낸다.
		fetch('/myQnaDelete', {
			method:'POST',
			headers:{
				'Content-Type': 'application/selectedPosts'})
		}).then(response => {
			if(reponse.ok){
				alert('선택한 게시물이 삭제되었습니다.');
				location.reload();
			}else{
				alert('삭제 실패 :'+response.statusText);
			}
		}).catch(error =>{
			console.error('Error:', error);
			alert('오류가 발생했습니다');
		});
	} */
</script>

<body>
	<div class="container">
		<div class="content_container">
			<div class="content_hed">
				<h1>구매목록</h1>
			</div>
			
			<div class="block_1">	
				<hr />
				
				<table class="border">
					<thead>
						<tr>
							<td></td>
							<td>계약번호</td>
							<td>구매일자</td>
							<td>모델명</td>
							<td>차량번호</td>
							<td>구매금액</td>
							<td>진행상태</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="Payment" items="${Payment}">
							<tr>
								<td></td>				
								<td><a href="/view_ms/buyListDetail?approval_num=${Payment.approval_num}">${Payment.approval_num}</a></td>
								<td>${Payment.approval_date}</td>
								<td>${Payment.model}</td>
								<td>${Payment.car_num }</td>
								<td>${Payment.price }</td>
								<td>
								<c:if test="${reviewExists}">
									<a href="/view_ms/hoogiList?approval_num=${Payment.approval_num}">
									<img alt="" src="../images/main/구매완료.png">
									</a>
								</c:if>
								
								<c:if test="${!reviewExists}">
									<a href="/view_ms/hoogi?approval_num=${Payment.approval_num}">
									<img alt="" src="../images/main/구매완료.png">
									</a>
								</c:if>
								</td>
							</tr>					
						</c:forEach>
					</tbody>
				</table>
			</div>
			<!-- <div class="buttondle">
		<button type="button"  style= "background:none; border: none;">
		<img src="../images/main/삭제_but.png" alt="삭제하기" onclick="handleSubmit()" class="delete">
		</button></div> -->
		</div>
</div>
	<!------------------------------------------- 푸터 ----------------------------------------->
	<%@ include file="../footer.jsp" %>
</body>
</html>