<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<meta charset="UTF-8">
<title>탈퇴페이지</title>
<link rel="stylesheet" href="../css/myPage.css">
<div class="header_continer"><%@ include file="../header_white.jsp"%></div>
<div class="menu_continer"><%@ include file="../menu_P.jsp" %></div>
<script type="text/javascript" src="/js/jquery.js"></script>
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
main.content {
	text-align: center; /* 텍스트 중앙 정렬 */
}

.block_1 {
	display: flex;
	flex-direction: column; /* 세로 방향으로 요소 배치 */
	align-items: center; /* 입력 박스와 버튼을 중앙 정렬 */
	margin: 100px auto; /* 수직 여백과 수평 중앙 정렬 */
	padding: 100px;
	background-color: white; /* 배경색 */
	border-radius: 10px; /* 둥근 모서리 */
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
	width: 1280px; /* 고정 폭 */
	padding-left: 0;
}

table {
	width: 100%; /* 테이블 너비 */
	margin-bottom: 20px; /* 테이블과 버튼 사이 여백 */
}

input {
	width: 70%; /* 입력 박스 너비 */
	padding: 10px; /* 입력 박스 안쪽 여백 */
	border: 1px solid #ccc; /* 테두리 색상 */
	border-radius: 5px; /* 둥근 모서리 */
	font-size: 16px; /* 폰트 크기 */
}
.button{
	display: flex; /* Flexbox 사용 */
	justify-content: center; /* 수평 중앙 정렬 */
	align-items: center; /* 수직 중앙 정렬 */
	margin-top: 20px; /* 위쪽 여백 */
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
.border th {
	font-size: 18px;
	font-weight: bold;
}

.text-center {
	font-size: 40px;
	font-weight: bold;
	text-align: center;
	margin-top: 80px;
}
</style>
<script type="text/javascript">

	/* 비밀번호 체크로직 */
 	function checkPwd() {
		alert('정말 탈퇴하시겠습니까?');
		var input_pw = $('#input_pw').val(); // 여기서 비밀번호 값을 가져옴
		
		$.ajax({
			type : 'GET',
			url : '/view_ms/pwChk', //이 경로의 컨트롤러로 감
			data : {'input_pw' : input_pw},
			dataType : "json",
			success : function(result) {
				if (result == 1) { //===3개면 type, 값까지 비교				
					return "/view_ms/talTwaeWan";
				} else {
					alert("비밀번호가 일치하지 않습니다.");
					window.location.reload();
				}
			},
			fail : function(error) {
				alert(JSON.stringify(error));
			}
		});
	
	} 

</script>

<body>
	<div class="container">
		<div>
			<h1 class="text-center">회원탈퇴</h1>
		</div>
		<main class="content">
			<form action="/view_ms/talTwaeWan_P" class="block" method="POST" onsubmit="return checkPwd()"> <!-- 여기는 비밀번호 체크 펑션인데(여기선 확인을하고) -->
				<p>
					<span style="color: gray; font-size: 16px;">회원 탈퇴 페이지 입니다. 정말 회원탈퇴를 하시겠습니까?</span> 				
				<br>	
				<br>
				<table class="border">
					<input type="hidden" name="user_id" value="${user_table.user_id}">
					<!--PK는 hidden으로 잡아주어야 함. -->
					<tr>
						<th>이름</th>
						<td><input type="text" id="user_id" name="user_id" value="${user.user_name }" required="required" /></td></tr>
					<tr>
						<th>아이디</th>
						<td><input type="text" id="user_id" name="user_id" value="${user.user_id }" required="required" /></td></tr>		
					<tr>
						<th>비밀번호 확인</th>
						<td><input type="password" id="input_pw" name="input_pw" required="required"></td></tr>
				
				</table>
						<!-- 버튼 컨테이너 -->
						<div class="button">
							<button type="reset" class="image-button" title="취소">
	               		 		<img alt="" src="../images/main/취소_but.png" class="button-image">
	            			</button>
	            			<button type="submit" class="image-button" onclick="handleSubmit()" style="border: none; background: none; padding: 0; cursor: pointer;">
	            		    <img alt="" src="../images/main/탈퇴하기_but.png" style="margin-left: 20px; width: 148px; height: 42.45px;">
	            		    </button>								
						</div>
				
					<!-- 지금 여기는 비밀번호 체크 컨트롤러(컨트로러 막으니까 페이지 이동이 안됌) -->			
					

			</form>
		</main>
</div>
	<!------------------------------------------------- 푸터 ------------------------------------------------->
	<%@ include file="../footer.jsp"%>
</body>
</html>