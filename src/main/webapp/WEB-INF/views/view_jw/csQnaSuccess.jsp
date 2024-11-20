<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="/css/csQnaSuccess.css" rel="stylesheet" type="text/css"/>
<meta charset="UTF-8">
<title>QnA Success</title>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" >
</script>
</head>
<body>
	<!-- 사이드바 -->
	<div class="header_continer"><%@ include file="../header_white.jsp"%></div>
	<div class="menu_continer"><%@ include file="../view_mh/menu_CS.jsp" %></div>
	<%@ include file="../kakao.jsp" %>
	
	<c:if test="${successYN =='1'}">
    	<script type="text/javascript">
    		alert("민원이 접수되었습니다");
    		// 부모창이 새로운 페이지로 이동
    		window.opener.location.href = '/view_jw/csQnaSuccess';
    		
    		// 팝업창을 닫음
    		window.close();
    	</script>
  	</c:if>
	
	
		
	<!-- 문의 완료 -->
	<div class="successContainer">
		<h1>신고·문의·민원</h1>
		<img src="../images/main/체크_icon.png">
		<span class="successMent">민원이 정상적으로 접수되었습니다.</span>
		<span class="sorry">
			불편을 끼쳐드려 대단히 죄송합니다.<br>
			빠른 처리를 위해 최선을 다하겠습니다.
		</span>
		<span class="successButton">
			<a href="../view_ms/myQna">나의문의내역</a>
			<a href="../view_jw/csMain">고객센터로 돌아가기</a>
		</span>
	 	</div>
	</div>
<%@ include file="../footer.jsp" %>   
</body>
</html>