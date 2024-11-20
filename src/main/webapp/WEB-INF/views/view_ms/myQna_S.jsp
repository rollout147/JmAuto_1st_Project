<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>구매자 마이페이지</title>
<link rel="stylesheet" href="../css/myPage.css">
<div class="header_continer"><%@ include file="../header_white.jsp"%></div>
<div class="menu_continer"><%@ include file="../menu_S.jsp" %></div>
<%@ include file="../kakao.jsp" %>
<script type="text/javascript" src="../js/jquery.js"></script>
<style type="text/css">
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
.button{
	display: flex; /* Flexbox 사용 */
	justify-content: center; /* 수평 중앙 정렬 */
	align-items: center; /* 수직 중앙 정렬 */
	margin-top: 20px; /* 위쪽 여백 */
	width: 100%; /* 전체 너비 사용 */
}
</style>
</head>

<script type="text/javascript">

	/* 체크박스 함수 */
	function handleSubmit(){
		const checkboxes = document.querySelectorAll('input[type="checkbox"]:checked');
		//querySelectorAll이라는 메서드를 사용해 현재 문서에 체크된 :checked요소를 모두 선택해 결과를 nodeList로 반환
		const selectedPosts = Array.from(checkboxes).map(checkbox => parseInt(checkbox.value));
		//map 메서드를 사용해 checkbox.value를 호출해 체크박스 값을 수집				형변환도 해주어야함....
		
		if(selectedPosts.length===0){
			alert('삭제할 게시물을 선택해주세요');
			return;
		}
		
		//서버에 삭제요청을 보낸다.
		$.ajax({
			url: '/myQnaDelete',
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
		<div class="content_container">
			<div class="content_hed">
				<h1>고객센터 문의내역</h1>
			</div>
			
			<div class="block_1">	
				<hr />
				
				<table class="border">
					<thead>
						<tr>
							<td>선택</td>
							<td>작성일자</td>
							<td>작성제목</td>
							<td>작성내용</td>
							<td>답변여부</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="Qna" items="${Qna}">
							<tr>
								<td><input type="checkbox" name="post1"
									value="${Qna.qna_num}"></td>
								<!-- 제목을 일부만 보여주기 -->
								<td
									onclick="location.href='/view_ms/myQnaDetail_S?qna_num=${Qna.qna_num}'"
									style="cursor: pointer;">${fn:substring(Qna.qna_date, 0, 10)}
									<!-- 날짜는 처음 10자만 -->
								</td>
								<td
									onclick="location.href='/view_ms/myQnaDetail_S?qna_num=${Qna.qna_num}'"
									style="cursor: pointer;">${fn:substring(Qna.qna_title, 0, 20)}...
									<!-- 제목을 처음 20자만 보여주기 -->
								</td>
								<td
									onclick="location.href='/view_ms/myQnaDetail_S?qna_num=${Qna.qna_num}'"
									style="cursor: pointer;">${fn:substring(Qna.qna_content, 0, 50)}...
									<!-- 내용은 처음 50자만 보여주기 -->
								</td>
								<td
									onclick="location.href='/view_ms/myQnaDetail_S?qna_num=${Qna.qna_num}'"
									style="cursor: pointer;"><c:if test="${QNA_USEYN}">
										<a href="/view_ms/myQnaDetail_S?qna_num=${Qna.qna_num}"> <img
											alt="" src="../images/main/답변완료.png">
										</a>
									</c:if> <c:if test="${!QNA_USEYN}">
										<a href="/view_ms/myQnaDetail_S?qna_num=${Qna.qna_num}"> <img
											alt="" src="../images/main/답변대기중.png">
										</a>
									</c:if></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			
			</div>
			<!-- 버튼 컨테이너 -->
			<div class="button">
				<img alt="" src="../images/main/삭제_but.png" onclick="handleSubmit()"
					style="cursor: pointer; margin-right: 20px;">
				<button type="submit" class="submit"
					style="background: none; border: none; cursor: pointer;"
					onclick="window.open('/view_jw/csQna','_blank', 'width=600, height=800'); return false;">
					<img alt="" src="../images/main/문의하기.png"
						style="width: 150px; height: auto;">
				</button>
			</div>
	</div>
	<!---------------------------------------------- 푸터 ------------------------------------>
	<%@ include file="../footer.jsp" %>
</body>
</html>