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

/* 버튼 스타일 */
.buttondle button {
    background-color: #ff6600; /* 주황색 배경 */
    color: white; /* 텍스트 색상 */
    border: none; /* 테두리 제거 */
    padding: 12px 25px; /* 여백 */
    font-size: 16px; /* 글자 크기 */
    font-weight: 600; /* 글자 두께 */
    cursor: pointer; /* 마우스 커서 포인터 */
    text-align: center; /* 텍스트 가운데 정렬 */
    transition: background-color 0.3s ease, transform 0.3s ease, box-shadow 0.3s ease; /* 애니메이션 효과 */
    margin: 0 10px; /* 버튼 간 여백 */
    box-shadow: 0px 4px 6px rgba(255, 127, 0, 0.3); /* 버튼 그림자 */
}

.buttondle button:hover {
    background-color: #FF9E3D; /* 호버 시 색상 변경 */
    transform: translateY(-2px); /* 호버 시 살짝 위로 이동 */
    box-shadow: 0px 6px 8px rgba(255, 127, 0, 0.4); /* 호버 시 그림자 강조 */
}

.buttondle button:active {
    background-color: #FF5722; /* 클릭 시 색상 변경 */
    transform: translateY(0px); /* 클릭 시 버튼 원래 위치로 */
    box-shadow: 0px 3px 5px rgba(255, 127, 0, 0.3); /* 클릭 시 그림자 변경 */
}

/* 버튼 두 개 사이 여백 */
.buttondle {
    display: flex;
    justify-content: center;
    gap: 15px; /* 버튼 간 간격 */
    margin-top: 20px; /* 버튼 상단 여백 */
}
.contentbox{
	white-space: normal;
}
</style>
<script type="text/javascript">

	function deleteZzokzi(note_num){
		if(confirm('정말로 이 쪽지를 삭제하시겠습니까?')){
			$.ajax({
				url: '/myNoteDelete',
				type: 'POST',
				contentType: 'application/json',
				data: JSON.stringify([note_num]),
				success: function(response){
					alert('쪽지가 삭제되었습니다.');
					window.location.href='/view_ms/myNote';
				},
				error: function(xhr, status, error){
					alert('쪽지의 삭제여부가 변경되었습니다.');
				}
			});
		}
	}
</script>
</head>

<body>
	<div class="container">
		<main class="content">
		<h1 class="text-center"><a href="#">나의 쪽지함</a></h1><br><br>
		
		<div class="block">
				<table class ="border">
					<thead>
						<tr>
							<td>쪽지번호</td>
							<td>보낸사람</td>
							<td>받은사람</td>
							<td>날짜</td>
							<td>매물번호</td>
							<td>제목</td>										
							<td>내용</td>						
						</tr>
					</thead>
					<tbody>
							<tr>
								<td>${Note.note_num}</td>
								<td>${Note.note_sd}</td>
								<td>${Note.note_rd}</td>
								<td>${Note.note_date}</td>
								<td>${Note.sell_num}</td>
								<td>${Note.note_title}</td>				
								<td><div class ="contentbox" >${Note.note_content}</div></td>						
							</tr>	
					</tbody>
				</table>
			</div>
			<div class="buttondle">
			<button type="button" onclick="deleteZzokzi(${Note.note_num})">삭제</button>
			
			<c:if test="${user_id.equals(Note.note_rd) && !user_id.equals(Note.note_sd)}">

			<button value="note" onclick="window.open('/view_ms/go_noteDabjang_form?note_num=${Note.note_num}&note_sd=${Note.note_sd}&sell_num=${Note.sell_num}&note_title=${Note.note_title}', '_blank', 'width=600, height=600, left=260, top=100, scrollbars=yes'); return false;">답장하기</button>
			</c:if>
			</div>
		</main>
	</div>
	<!---------------------------------------------- 푸터 ------------------------------------>
	<%@ include file="../footer.jsp" %>
</body>
</html>