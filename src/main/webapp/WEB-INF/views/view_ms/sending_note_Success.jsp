<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header_white.jsp" %>
<%@ include file="../kakao.jsp" %>
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

	<c:if test="${successYN =='1'}">
    	<script type="text/javascript">
    		alert("쪽지 전송에 성공하였습니다");
    		  		
    		// 팝업창을 닫음
    		window.close();
    	</script>
  	</c:if>
	
	
</body>
</html>