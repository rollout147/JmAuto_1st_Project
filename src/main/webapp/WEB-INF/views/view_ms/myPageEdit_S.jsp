<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<meta charset="UTF-8">
<title>구매자 마이페이지</title>
<link rel="stylesheet" href="../css/myPage.css">
<script type="text/javascript" src="../js/jquery.js"></script>
<div class="header_continer"><%@ include file="../header_white.jsp"%></div>
<div class="menu_continer"><%@ include file="../menu_S.jsp" %></div>

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
#userUpdate {
  background: none;         /* 버튼 배경 없애기 */
  border: none;             /* 버튼 테두리 없애기 */
  padding: 0;               /* 버튼 패딩 없애기 */
  cursor: pointer;          /* 클릭 가능한 커서로 변경 */
}

#userUpdate img {
  display: block;           /* 이미지가 버튼 안에 꽉 차게 함 */
  width: 148px;              /* 버튼 크기에 맞게 이미지 크기 조절 */
  height: 42.44px;            /* 이미지 비율 유지 */
  padding: 20px;
}
</style>
<script type="text/javascript">
	function chk(){
	const user_pw1 = document.getElementById('user_pw1').value;
    const user_pw2 = document.getElementById('user_pw2').value;
		
    if(user_pw1 == user_pw2){		
			return true;	
		}else{
			alert('두 비밀번호가 일치하지 않습니다.');
			return false;
		}
	}

</script>

<body>
	<div class="container">
	<div>
				<h1 class="text-center">회원정보수정</h1>
			</div>
		<main class="content">
			
			<form action="/myPageEdit_S" class="block" method="POST" onsubmit="return chk()">
				
				<table class="border">
					<input type="hidden" name="user_id" value="${user.user_id}">
					<tr>
						<th>이름</th>
						<td><input type="text" id="user_name" name="user_name" value="${user.user_name}"
					 required="required" /></td>
					</tr>
					<tr>
						<th>비밀번호 변경</th>
						<td><input type="password" id="user_pw1" name="user_pw1"
						placeholder="변경할 비밀번호" required="required" /></td>
					</tr>
					<tr>
						<th>비밀번호 확인</th>
						<td><input type="password" id="user_pw2" name="user_pw2"
						 placeholder="비밀번호 확인" required="required" /></td>
					</tr>
					<tr>
						<th>연락처</th>
						<!-- 아하 text박스 안에 기본정보들을 뿌려주려면 user_table을 뭐라고 저장해놨는지 저장한 이름에 .user_id를 붙어야 하는구나! -->
						<td><input type="text" id="user_tel" name="user_tel" 
						value="${user.user_tel}" required="required"></td>
					</tr>
					<tr>
						<th>우편번호</th>
						<td><input type="text" id="user_zipcode" name="user_zipcode"
							value="${user.user_zipcode}" required="required"></td>
					</tr>
					<tr>
						<th>주소</th>
						<td><input type="text" id="user_addr1" name="user_addr1"
							value="${user.user_addr1}" required="required"></td>
					</tr>
					<tr>
						<th>상세주소</th>
						<td><input type="text" id="user_addr2" name="user_addr2"
							value="${user.user_addr2}" required="required"></td>
					</tr>
				</table>				
					<tr>
						<td>
						<!-- 버튼 컨테이너 -->
						<div class="button">
							<button type="submit" id="userUpdate">
								<img alt="" src="../images/main/수정_but.png">
							</button>
							<button type="reset" class="image-button" title="취소">
                <img alt="" src="../images/main/취소_but.png" class="button-image">
            </button>
						</div>
					</tr>
			</form>
			<div style="text-align: left; text-decoration: underline; padding-bottom: 100px;">
				<a href="/view_ms/talTwae_S?user_name=${user_name}&user_id=${user_id}"><span style="color:gray; font-size: 14px; margin-left: 20px;">회원 탈퇴하기</span></a>
			
			</div>
		</main>
</div>
	<!-- 푸터 -->
	<%@ include file="../footer.jsp" %>
</body>

</html>
myPageEdit_S.jsp
7KB