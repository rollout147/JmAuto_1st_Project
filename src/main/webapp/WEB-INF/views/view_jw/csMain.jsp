<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="/css/csMain.css" rel="stylesheet" type="text/css"/>
<meta charset="UTF-8">
<title>고객센터</title>
</head>
<body>

	<div class="header_continer"><%@ include file="../header_white.jsp"%></div>
	<%@ include file="../kakao.jsp" %>

	<!-- 메인내용 -->
	<div class="csHeadline">
		<h1>고객지원</h1>
      	<span class="csMent">안녕하세요. JM 고객센터입니다. 무엇을 도와드릴까요?</span>
      	
      	<div class="csCenter">
        	<span class="csChoice">궁금하신 사항을 선택해주세요</span>

	        <div class="csContainer">
	          
	        	<div class="csBox">
		          	<!-- 자주묻는질문 -->
		          	<a href="../view_jw/csFaq" class="faqButton"></a>

					<!-- 신고·문의·민원=> 로그인한 회원은 팝업창, 안 한 회원은 새 창-->
					<c:choose>
		    			
		    			<c:when test="${not empty sessionScope.user}">
		    				<a href="#" onclick="window.open('/view_jw/csQna', '_blank', 'width=600, height=800'); return false;" 
							class="qnaButton"></a>
		    			</c:when>
		    			
		    			<c:otherwise>
		    				<a href="../view_jw/csNotLogin" class="qnaButton"></a>
		    			</c:otherwise>	
		    		</c:choose>
						
					<!-- 공지사항 -->	
		         	<a href="../view_jw/csNotice" class="noticeButton"></a>
		         	
		         	
		         	<!-- 고객후기 -->
		           	<a href="../view_jw/csReview" class="reviewButton"></a>
				</div>
			</div>	
		</div>	
		
	</div>		

	
	<%@ include file="../footer.jsp" %>
</body>
</html>