<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
	@font-face {
    font-family: 'Pretendard-Regular';
    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
    font-weight: 400;
    font-style: normal;
	}
	
	body {
		font-family: 'Pretendard-Regular';
	    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
	    font-weight: 400;
	    font-style: normal;
	}
</style>

<!-- CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

</head>
<body>
	<div class="listTop">
    	<c:if test="${total > 0 }">
    		<h1>매물 수 : ${total}</h1><br>
    	</c:if>
    </div>
	<!-- 검색 결과 리스트로 출력 -->
            <div class="list">
            	<c:if test="${total > 0 }">
					<c:forEach var="car" items="${valueList}">
						<div class="card">
							<img src="image/" class="card-img-top" alt="...">
								<div class="card-body">
					                <h4 class="card-title">${car.model}</h4>
					                <hr width="150px" color="#ededed" align="left" size="2px"/>
					                <h2 id="card-text">${car.price }만원</h2>
					            </div>
						</div>
					</c:forEach>
				<!-- 검색결과 값이 없는 경우 -->			
				</c:if>
				<c:if test="${total == 0 }">
					<div id="result0">
						<h1>
							검색결과 값이 없습니다
						</h1>
					</div>
					
				</c:if>
				
				<%-- 페이징 --%>
				<%-- 디테일 서치 >> test="${not empty model_name} --%>
				<%-- 키워드 서치 test="${not empty keyword}" --%>
				<!-- otherwise >> 국내, 해외, 친환경 -->
				<div class="listBottom">
            		<c:if test="${total > 0 }">
            			<div class="page">
            				<c:if test="${page.startPage > page.pageBlock }">
								<a href="/view_sh/page?url=${url}&currentPage=${page.startPage-page.pageBlock }&total=${total}&keyword=${keyword}">[이전]</a>
							</c:if>
							
							<c:forEach var="i" begin="${page.startPage }" end="${page.endPage }">
								<a href="/view_sh/page?url=${url}&currentPage=${i }&total=${total}&brand=${brand}">[${i}]</a>
							</c:forEach>
							
							<c:if test="${page.endPage < page.totalPage}">
								<a href="/view_sh/page?url=${url}&currentPage=${page.startPage+page.pageBlock }&total=${total}">[다음]</a>
							</c:if>
							
						</div>
            		</c:if>
            	</div>
				
			</div> 
	
</body>
<%@ include file="../footer.jsp" %>
</html>