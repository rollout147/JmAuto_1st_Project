<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="stylesheet" href="../css/myPage.css">
<div class="header_continer"><%@ include file="../header_white.jsp"%></div>
<div class="menu_continer"><%@ include file="../menu_B.jsp" %></div>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript"><%@ include file="../kakao.jsp" %></script>

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
	padding-bottom: 200px;
}

.block{
	display: center;
	text-decoration: underline;
	padding: 100px;
	font-size: 18px;
}
.button{
	display: flex; /* Flexbox 사용 */
	justify-content: center; /* 수평 중앙 정렬 */
	align-items: center; /* 수직 중앙 정렬 */
	margin-top: 20px; /* 위쪽 여백 */
	width: 100%; /* 전체 너비 사용 */
}

main.content {
	text-align: center; /* 텍스트 중앙 정렬 */
}



.text-center {
	font-size: 40px;
	font-weight: bold;
	text-align: center;
	margin-top: 80px;
}
</style>
<body>
	
	<div class="container">
		<div>
			<h1 class="text-center">회원탈퇴</h1>
		</div>
		<main class="content">

			<div class="block">회원 탈퇴가 완료되었습니다.</div>
		</main>
</div>
<!------------------------------------------- 푸터 -------------------------------------------->
	<%@ include file="../footer.jsp" %>
</body>
</html>