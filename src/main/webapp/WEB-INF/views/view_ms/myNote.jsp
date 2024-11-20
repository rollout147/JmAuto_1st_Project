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
<div class="menu_continer"><%@ include file="../menu_B.jsp" %></div>
<%@ include file="../kakao.jsp" %>
<script type="text/javascript" src="../js/jquery.js"></script>
<style>
.content {
	background-color: white;
	border-bottom: 10px;
	border-top: 10px;
	display: center;
	margin-top: 50px;
	padding-top: 50px;
	
}
.text-center{
	font-size: 40px;
	font-weight: bold;
	text-align: center;
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
h2{
	padding: 20px;
	font-weight: bold;
}
  .border td:nth-child(1) { width: 10%; } /* 선택 열 */
    .border td:nth-child(2) { width: 10%; } /* 쪽지번호 */
    .border td:nth-child(3) { width: 15%; } /* 보낸사람/받는사람 */
    .border td:nth-child(4) { width: 15%; } /* 작성날짜 */
    .border td:nth-child(5) { width: 30%; } /* 제목 */
    .border td:nth-child(6) { width: 20%; } /* 매물번호 */
</style>
<script type="text/javascript">

	/* 체크박스 함수 */
	function handleSubmit(){
		const checkboxes = document.querySelectorAll('input[type="checkbox"]:checked');
		//querySelectorAll이라는 메서드를 사용해 현재 문서에 체크된 :checked요소를 모두 선택해 결과를 nodeList로 반환
		const selectedPosts = Array.from(checkboxes).map(checkbox => (checkbox.value));
		//map 메서드를 사용해 checkbox.value를 호출해 체크박스 값을 수집				
		
		if(selectedPosts.length===0){
			alert('삭제할 게시물을 선택해주세요');
			return;
		}
		
		//서버에 삭제요청을 보낸다.
		$.ajax({
			url: '/myNoteDelete',
			type: 'POST',
			contentType: 'application/json',
			data: JSON.stringify(selectedPosts),
			success: function(response){
				alert('선택한 게시물이 삭제되었습니다.');
				location.reload();
			},
			error: function(xhr, status, error){
				alert('선택한 게시물의 삭제여부가 변경되었습니다.');
			}
		});
	}
	
</script>

</head>


<body>
	<div class="container">
		<main class="content">
		<h1 class="text-center">차량구매 문의내역</h1><br><br>
		   
		   
		   <!-- 받은 쪽지함 섹션 -->
		    <div class="block_1">
		    <hr/>
		        <h2>받은 쪽지함</h2>
		        <table class="border">
		            <thead>
		                <tr>
		                    <td>선택</td>
		                    <td>쪽지번호</td>
		                    <td>보낸사람</td>
		                    <td>작성날짜</td>
		                    <td>제목</td>	
		                    <td>매물번호</td>			     								    
		                </tr>
		            </thead>
		            <tbody>
		                <c:forEach var="Note" items="${Notes}">
		                    <tr>
		                        <td><input type="checkbox" name="receivedPost" value="${Note.note_num}"></td>								
		                        <td onclick="location.href='/view_ms/myNoteDetail?note_num=${Note.note_num}'" style="cursor: pointer;">${Note.note_num}</td>
		                        <td onclick="location.href='/view_ms/myNoteDetail?note_num=${Note.note_num}'" style="cursor: pointer;">${Note.note_sd}</td>
		                        <td onclick="location.href='/view_ms/myNoteDetail?note_num=${Note.note_num}'" style="cursor: pointer;">${Note.note_date}</td>
		                        <td onclick="location.href='/view_ms/myNoteDetail?note_num=${Note.note_num}'" style="cursor: pointer;">${Note.note_title}</td>	
		                        <td onclick="location.href='/view_ms/myNoteDetail?note_num=${Note.note_num}'" style="cursor: pointer;">${Note.sell_num}</td>	                        					
		                    </tr>					
		                </c:forEach>
		            </tbody>
		        </table>
		    </div>
		    
		    
		    <!-- 보낸 쪽지함 섹션 -->
		    <div class="block_1">
		        <h2>보낸 쪽지함</h2>
		        <table class="border">
		            <thead>
		                <tr>
		                    <td>선택</td>
		                    <td>쪽지번호</td>
		                    <td>받는사람</td>
		                    <td>작성날짜</td>
							<td>제목</td>                    
		                    <td>매물번호</td>			
		                    									    
		                </tr>
		            </thead>
		            <tbody>
		                <c:forEach var="Note" items="${SendNotes}">
		                    <tr>
		                        <td><input type="checkbox" name="sentPost" value="${Note.note_num}"></td>								
		                        <td onclick="location.href='/view_ms/myNoteDetail?note_num=${Note.note_num}'" style="cursor: pointer;">${Note.note_num}</td>
		                        <td onclick="location.href='/view_ms/myNoteDetail?note_num=${Note.note_num}'" style="cursor: pointer;">${Note.note_rd}</td>
		                        <td onclick="location.href='/view_ms/myNoteDetail?note_num=${Note.note_num}'" style="cursor: pointer;">${Note.note_date}</td>
		                        <td onclick="location.href='/view_ms/myNoteDetail?note_num=${Note.note_num}'" style="cursor: pointer;">${Note.note_title}</td>
		                        <td onclick="location.href='/view_ms/myNoteDetail?note_num=${Note.note_num}'" style="cursor: pointer;">${Note.sell_num}</td>		                        						
		                    </tr>					
		                </c:forEach>
		            </tbody>
		        </table>
		    </div>
		</main>
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
	<!---------------------------------------------- 푸터 ------------------------------------>
	<%@ include file="../footer.jsp" %>
</body>
</html>