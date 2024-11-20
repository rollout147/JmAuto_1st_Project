<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>구매자 마이페이지 -> 내가 구매한 전문가리뷰 상세페이지 혁님꺼 연결예정</title>
<link rel="stylesheet" href="../css/myPage.css">
<div class="header_continer"><%@ include file="../header_white.jsp"%></div>
<div class="menu_continer"><%@ include file="../menu_B.jsp" %></div>
<script type="text/javascript" src="../js/jquery.js"></script>
</head>


<script type="text/javascript">
	
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
	}
</script>

<body>
	
	<div class="container">
		<main class="content">
			<h1 class="text-center"><a href="#">내가 구매한 전문가리뷰->리뷰 페이지 연결 완료(/KH/pay/expertReviewPage)</a></h1><br><br>
			<div class="block">
				<table>
					<thead>
						<tr>
							<th>리뷰번호</th>
							<th>매물번호</th>
							<th>리뷰작성일</th>
							<th>리뷰내용</th>
							<th>전문가id</th>
						</tr>
					</thead>
					<tbody>
							<tr>
								<td>${Expert_Review.expert_review_num }</td>												
								<td>${Expert_Review.sell_num }</td>												
								<td>${Expert_Review.write_date}</td>												
								<td>${Expert_Review.content}</td>
								<td>${Expert_Review.user_id}</td>
							</tr>
					</tbody>
				</table>
			</div>
			<a href="view_jw/cs"><button type="button">문의하기</button></a>
		</main>
</div>

<!------------------------------------- 푸터 ----------------------------------------->
	<%@ include file="../footer.jsp" %>
</body>

</html>