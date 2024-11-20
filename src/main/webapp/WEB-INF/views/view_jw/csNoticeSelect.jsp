<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<link href="/css/csNoticeSelect.css" rel="stylesheet" type="text/css"/>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 사이드바 -->
	<div class="header_continer"><%@ include file="../header_white.jsp"%></div>
	<div class="menu_continer"><%@ include file="../view_mh/menu_CS.jsp" %></div>
	<%@ include file="../kakao.jsp" %>
	
	<!-- 공지사항 상세내용 -->
	<div class="notice">
		<span class="noticeCls">
			<c:choose>
				<c:when test="${ notice_table.notice_cls == '6100' }">
                    <span>공지사항</span>
                </c:when>
				<c:when test="${ notice_table.notice_cls == '6200' }">
                    <span>이용약관</span>
                </c:when>
                <c:otherwise>
                    <span>이벤트</span>
                </c:otherwise>
			</c:choose>
		</span>
		<div class="noticeDetail">
			
			<div class="noticeTitle">
				${ notice_table.notice_title }
			</div>
			<div class="noticeDate">
				<fmt:formatDate type="date" value="${ notice_table.notice_date }" pattern="YYYY/MM/dd"/>
			</div>
			<div class="noticeContent">
				${ notice_table.notice_content }
			</div>
		</div>
	</div>
	
<%@ include file="../footer.jsp" %>
</body>
</html>