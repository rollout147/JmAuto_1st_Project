<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="/css/csNotLogin.css" rel="stylesheet" type="text/css"/>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 사이드바 -->
	<div class="header_continer"><%@ include file="../header_white.jsp"%></div>
	<div class="menu_continer"><%@ include file="../view_mh/menu_CS.jsp" %></div>
	<%@ include file="../kakao.jsp" %>

	<!-- 로그인 안내 내용 -->
	<div class="pleaseLogin">
		<h1>신고·문의·민원</h1>
		<span class="guideMent">로그인 후에 등록하시면 더욱 편리한 서비스를 이용할 수 있습니다</span>
		
		<span class="choiceButton">
			<a href="../view_jm/login">로그인하기</a>
			<a href="../view_jw/csMain">돌아가기</a>
		</span>
	</div>
	
	<%@ include file="../footer.jsp" %>
</body>
</html>