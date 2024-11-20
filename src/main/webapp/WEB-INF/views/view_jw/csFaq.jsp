<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<link href="/css/csFaq.css" rel="stylesheet" type="text/css"/>
<meta charset="UTF-8">
<title>자주 묻는 질문</title>
</head>
<body>
	<!-- 사이드바 -->
	<div class="header_continer"><%@ include file="../header_white.jsp"%></div>
	<div class="menu_continer"><%@ include file="../view_mh/menu_CS.jsp" %></div>
	<%@ include file="../kakao.jsp" %>
	
	<!-- 민원 메인 내용 -->
	<div class="faq">
			
		<div class="csContainer">
			<h1>자주 묻는 질문</h1>
			<span class="faqMent">고객님의 궁금증을 해결해드립니다</span>
			
			<!-- 상단 메뉴바 -->
			<div class="faqTopMenu">
				<a href="csFaq?faqCls=5100"
				<c:if test="${param.faqCls == null || param.faqCls == '5100'}">class="active"</c:if>>
				전체</a>
				<a href="csFaq?faqCls=5200"
				<c:if test="${param.faqCls == '5200'}">class="active"</c:if>>
				구매가이드</a>
				<a href="csFaq?faqCls=5300"
				<c:if test="${param.faqCls == '5300'}">class="active"</c:if>>
				회원정보관리</a>
				<a href="csFaq?faqCls=5400"
				<c:if test="${param.faqCls == '5400'}">class="active"</c:if>>
				전문가</a>
				<a href="csFaq?faqCls=5500"
				<c:if test="${param.faqCls == '5500'}">class="active"</c:if>>
				배송</a>
				<a href="csFaq?faqCls=5600"
				<c:if test="${param.faqCls == '5600'}">class="active"</c:if>>
				내차팔기</a>
				<a href="csFaq?faqCls=5700"
				<c:if test="${param.faqCls == '5700'}">class="active"</c:if>>
				기타</a> 
			</div>

		 	<div class="faqList">	 	
		 		<div class="faqItem">
			 		<table class="faqTable">
				        <tbody>
							<c:forEach var="faq" items="${ listFaq }">
				               <c:choose>
				               		<c:when test="${selectCls==null }">
				               			<tr><td>
					               			<details>
										  		<summary>
												  	<span class="Q">Q.</span>
												  	${faq.faq_title}
											  	</summary>
											  	<div class="content">
											 		<span class="A">A.</span>
											 		<span class="answer">
														${faq.faq_content}<p>
											 		</span>
											 	</div>	
											</details>
										</td></tr>
				               		</c:when>
				               		
				               		<c:when test="${selectCls==5100}">
				               			<tr><td>
											<details>
										  		<summary>
											  		<span class="Q">Q.</span>
											  		${faq.faq_title}
											  	</summary>
											  	<div class="content">
											  		<span class="A">A.</span>
											 		<span class="answer">
														${faq.faq_content}<p>
											 		</span>
											 	</div>
											</details>
										</td></tr>
									</c:when>
				               		<c:when test="${selectCls == faq.faq_cls}">
										<tr><td>
											<details>
										  		<summary>
											  		<span class="Q">Q.</span>
											  		${faq.faq_title}
											  	</summary>
											  	<div class="content">
												  	<span class="A">A.</span>
											 		<span class="answer">
														${faq.faq_content}<p>
											 		</span>
											 	</div>
											</details>
										</td></tr>
									</c:when>
								</c:choose>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			
		</div>
		
	</div>	
	<%@ include file="../footer.jsp" %>
</body>
</html>