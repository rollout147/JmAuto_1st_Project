<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<meta charset="UTF-8">
<title>구매자마이페이지</title>
<link rel="stylesheet" href="../css/myPage.css">
<div class="header_continer"><%@ include file="../header_white.jsp"%></div>
<div class="menu_continer"><%@ include file="../menu_P.jsp" %></div>
<%@ include file="../kakao.jsp" %>
</head>
<style>
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



input[type="password"] {
	width: 70%; /* 입력 박스 너비 */
	padding: 10px; /* 입력 박스 안쪽 여백 */
	border: 1px solid #ccc; /* 테두리 색상 */
	border-radius: 5px; /* 둥근 모서리 */
	font-size: 16px; /* 폰트 크기 */
}

.button {
	width: 150px;
	height: 50px;
	background-color: #007bff; /* 버튼 배경색 */
	color: white; /* 버튼 텍스트 색상 */
	border: none; /* 테두리 없애기 */
	cursor: pointer; /* 커서 모양 변경 */
	font-size: 16px; /* 폰트 크기 */
	transition: background-color 0.3s; /* 효과 추가 */
}
.text-center{
	font-size: 40px;
	font-weight: bold;
	text-align: center;
	margin-top: 80px;
}
</style>
<script type="text/javascript">
	/* 비밀번호 체크로직 */
	function checkPwd() {
		alert('비밀번호 확인중입니다.');
		var input_pw = $('#input_pw').val(); // 여기서 비밀번호 값을 가져옴

		// ajax--> 세미 컨트롤러 (근데 컨트롤러로 이동해서 값을 받아온 후,  그 값을 토대로 뷰에 우리가 원하는 값을 반환하는 용도)
		$.ajax({
			type : 'GET',
			url : '/view_ms/pwChk', //이 경로의 컨트롤러로 감
			data : {
				'input_pw' : input_pw
			},
			dataType : "json",
			success : function(result) {
				if (result === 1) {
					window.location.href = "/view_ms/myPageEdit_P";
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
        <main class="content">
            <h1 class="text-center">회원정보수정</h1>
            
            <div class="block_1">
                <input type="hidden" name="user_id" value="${user_table.user_id}">
					<table>
					<tr>
						<td style="width: 200px;"><span style="font-size: 18px; font-weight: bold;">비밀번호 :</span></td>
						<td><input type="password" id="input_pw" name="user_pw" required="required"></td>
					</tr>
					</table>

                <img alt="" src="../images/main/다음_but.png" onclick="checkPwd()" class="button">
            </div>
            <!-- 비밀번호 검증 결과 메세지 -->
            <c:if test="${not empty errorMessage }">
                <p style="color: red;">${errorMessage}</p>
            </c:if>
        </main>
    </div>
	<!------------------------------------------------- 푸터 ------------------------------------------------->
	<%@ include file="../footer.jsp" %>
</body>
</html>