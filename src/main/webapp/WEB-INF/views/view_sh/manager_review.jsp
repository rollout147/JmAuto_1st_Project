<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<div class="header_continer"><%@ include file="../header.jsp" %></div>
<%-- <div class="header_continer"><%@ include file="manager_header_CS.jsp" %></div> --%>
<div class="menu_continer"><%@ include file="../manager_menu.jsp" %></div>

<style type="text/css">

	@font-face {
	    font-family: 'Pretendard-Regular';
	    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
	    font-weight: 400;
	    font-style: normal;
	}
	
	body {
	    margin: 0;
	    padding: 0;
	    box-sizing: border-box;
	    font-family: 'Pretendard-Regular'; /* 폰트만 지정 */
	    font-weight: 400;
	    font-style: normal;
	}

	
	.header_continer {
	    position: relative; /* No fixed position, it will scroll naturally */
	    width: 100%;
	    top: 0;
	    z-index: 1001; /* Still higher than the menu */
	}
	
	.menu_continer {
	    position: fixed;
	    top: 0; /* Stays fixed at the top */
	    z-index: 1000; /* Lower than the header */
	    height: 100vh; /* Full viewport height */
	}
	
	.manager_container {
		display: grid;
		grid-template-columns: minmax(auto, 1320px);
		justify-content: center;
		max-width: 100%;
		margin: 0px auto;
		background-color: #f7f7f7;
		height: auto;
	}
	
	.manager_menu {
		background: #fdfdfd;
		box-shadow: 0 0 10px 5px rgb(0,0,0,0.06);
		width: 100%;
		max-width: 200px;
		height: auto;
		margin: 40px 0 20px;
	}
	
	.manager_header {
		display: flex;
		margin: 20px 0;
		justify-content: space-between;
		align-items: center;
	}
	
	.manager_header_h1{
		font-size: 20px;
		font-weight: 550;
	}
	
	.manager_header_gene {
		display: flex;
		background-color: #ff4714;
		color: #fdfdfd;
		width: 100%;
		max-width: 100px;
		height: 35px;
		position: relative;
		align-items: center;
		justify-content: center;
		box-shadow: 0 0 10px 5px rgb(0,0,0,0.06);
	}
	

	.manager_CS_list {
		background-color: #fdfdfd;
		box-shadow: 0 0 10px 5px rgb(0,0,0,0.06);
		height: auto;
		margin: 0 0 40px;
		text-align: center;
	}
	
	.trList1{
		/* display: flex;
		text-align: center;
		width: 1320px; */
		height: 40px; 
		margin: 20px 0;
		font-size: 16px;
	}
	
	.manager_CS_table {
		display: flex;
		justify-content: center;
		border-collapse: collapse;
	}
	
	.trList2{
		font-size: 14px;
		border-top: 0.4px solid #e2e8ee;
		padding: 20px 0;
		cursor: pointer;
		height: 40px; 
		font-size: 14px;
	}
	
	.manager_CS_table th {
		color: #999999;
		font-weight: 800;
	}
	
	.td-1{
		width: 180px;  
		text-align: center;
	}
	
	.td-2{
		width: 280px; 
		text-align: center;
		
	}
	
	.td-3{
		width: 280px; 
		text-align: center;
		
	}
	
	.td-4{
		width: 160px; 
		text-align: center;
	}
	
	.td-5{
		width: 160px; 
		text-align: center;
	}
	
	.td-6{
		width: 160px; 
		text-align: center;
		display: flex; 
		justify-content: center;
		padding: 20px 0;
	}
	
	.car_del_state_back1 {
		background-color: #ff4714;
		height: 25px;
		width: 60px;
		display: flex;
		justify-content: center;
	}
	
	.car_del_state1{
		font-size: 12px;
		color: #fdfdfd;
		align-items: center;
		margin: 4px
	}
	
	
	/* 삭제시 */
	.car_del_state_back2 {
		background-color: #5B4A80;
		height: 25px;
		width: 60px;
		display: flex;
		justify-content: center;
	}
	
	.car_del_state2{
		font-size: 12px;
		color: #fdfdfd;
		align-items: center;
		margin: 4px
	}
	
	
	.but_images {
		width: 100%;
		max-width: 21px;
		height: auto;
		cursor: pointer;
	}
	
	.but_background{
		background: none;
		border: none;
	}
	
	.listBottom {
		display: flex;
		justify-content: center;
	}
	
	#page{
		text-align: center;
	}
	
	.keyword {
		width: 600px;
		border: none;
		padding: 20px;
		box-shadow: 0 0 10px 5px rgb(0,0,0,0.02);
	}
	
	.manager_Qna_header_search {
		display: flex;
		position: relative;
	}
	
	.manager_Qna_header_search_but{
		position: absolute;
		right: 15px;
		bottom: 10px;
		border: none;
		width: 50px;
		height: 30px;
		box-shadow: 0 0 10px 5px rgb(0,0,0,0.01);
		cursor: pointer;
	}
	
	.manager_header_h1 button {
		border: none;
		background-color: #ff4714;
		color: white;
	
	}
	
	.manager_pagination_current {
	    background-color: #ff4714;
	    color: #fdfdfd; /* 텍스트 색상 */
	    padding: 5px 10px; /* 패딩 추가 */
	    border-radius: 5px; /* 둥근 모서리 */
	    font-weight: bold; /* 글씨 두껍게 */
	}
	
	.manager_pagination {
		font-size: 16px;
		display: flex;
		justify-content: center;
		align-items: center;
		margin: 0 0 80px;
	}
	
	.manager_pagination_a {
		color: #323232;
		margin: 0 5px;
	}
	
	.manager_pagination_a_next {
		color: #ff4714;
		text-decoration: underline;
		text-underline-position:under;
		font-weight: 700;
		margin: 0 5px;
	}
	
	.manager_pagination_a_back {
		color: #ff4714;
		text-decoration: underline;
		text-underline-position:under;
		font-weight: 700;
		margin: 0 5px;
	}

</style>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).on('#deleteBtn', function() {
    var REVIEW_NUM = $(this).data('REVIEW_NUM');
    reviewDeactive(REVIEW_NUM);  // 이 함수가 호출될 때 sellNum을 넘깁니다.
});

function reviewDeactive(REVIEW_NUM) {
    //alert("EXPERT_REVIEW_NUM >> " + REVIEW_NUM); // alert에 판매자 리뷰 번호를 올바르게 출력
    if (confirm('정말 해당리뷰를 삭제처리 하시겠습니까?')) { // confirm 함수에 메시지를 전달
	    $.ajax({
	        url : '${pageContext.request.contextPath}/reviewDeactive',
	        type : 'GET',
	        dataType : 'json',
	        data : {
	            'reviewNum' : REVIEW_NUM
	        }, // userId로 데이터 전송
	        success : function(response) {
	            alert("전문가리뷰가 성공적으로 비활성화 처리되었습니다.");
	            location.reload(); // 페이지 새로고침
	        },
	        error : function(error) {
	            console.error("비활성화 중 오류 발생", error);
	            alert("비활성화 중 오류가 발생했습니다.");
	        }
	    });
    } else {
        alert('삭제가 취소되었습니다.');
    }
}

function reviewActive(REVIEW_NUM) {
    //alert("EXPERT_REVIEW_NUM >> " + REVIEW_NUM); // alert에 판매자 리뷰 번호를 올바르게 출력
    if (confirm('정말 삭제된 리뷰를 활성화 처리 하시겠습니까?')) { // confirm 함수에 메시지를 전달
	    $.ajax({
	        url : '${pageContext.request.contextPath}/reviewActive',
	        type : 'GET',
	        dataType : 'json',
	        data : {
	            'reviewNum' : REVIEW_NUM
	        }, // userId로 데이터 전송
	        success : function(response) {
	            alert("전문가리뷰가 성공적으로 활성화 처리 되었습니다.");
	            location.reload(); // 페이지 새로고침
	        },
	        error : function(error) {
	            console.error("활성화 중 오류 발생", error);
	            alert("활성화 중 오류가 발생했습니다.");
	        }
	    });
    } else {
        alert('활성화가 취소되었습니다.');
    }
}
</script>


<title>Insert title here</title>
</head>


		
<body> 
   <!-- 검색 결과 리스트로 출력 -->
   
    <div class="manager_container">
			
		<form action="/getReviewListSearch">
		   <div class="manager_header">
				<div class="manager_header_h1">
					등록된 전체 전문가 리뷰 수 : ${total}
				</div>
				
				<div class="manager_Qna_header_search">
				   <input class="keyword" name="keyword" placeholder="검색어 입력">
				   <button class="manager_Qna_header_search_but" type="submit">검색</button>
				</div>
			</div>
		</form>
   
   <div class="list">
		
	<div class="manager_CS_list">
    	
    	<table class="manager_CS_table">
	    	<tr class="trList1">
				<th class="td-1"><label>작성자</label></th>
				<th class="td-2"><label>리뷰번호</label></th>
				<th class="td-3"><label>매물번호</label></th>
				<th class="td-4"><label>작성일</label></th>
				<th class="td-5"><label>작업</label></th>
				<th class="td-6"><label>삭제여부</label></th>
			</tr>
		
	
	   	<div class="value"  id="value">
	   	<c:if test="${total > 0 }">
		<c:forEach var="review" items="${reviewlist}">
		
		
		<tr class="trList2">
			
			<td class="td-1">
				${review.user_id }
			</td>
			
			<td class="td-2">
				${review.expert_review_num }
			</td>
			
			<td class="td-3">
				${review.sell_num}
			</td>
			
			<td class="td-4">
				${review.formatted_write_date }
			</td>
			
			<td id="manager_faq_td_but" class="td-5">
				<button type="button" id="deleteBtn" class="but_background" 
					onclick="reviewActive('${review.expert_review_num }')">
					<img alt="노출_icon" 
						src="<%=request.getContextPath()%>/images/main/노출_icon.png" class="but_images">
				</button>
				
				<button type="button" id="deleteBtn" class="but_background" 
					onclick="reviewDeactive('${review.expert_review_num }')">
					<img alt="삭제_icon" 
						src="<%=request.getContextPath()%>/images/main/삭제_icon.png" class="but_images">
				</button>
			</td>
			
			
			<td class="td-6">
				<c:choose>
					<c:when test="${review.del_state == 0 }">
						<div class="car_del_state_back1"><div class="car_del_state1">정  상</div></div>
					</c:when>
					<c:when test="${review.del_state == 1 }">
						<div class="car_del_state_back2"><div class="car_del_state2">삭  제</div></div>
					</c:when>
				</c:choose>
			</td>
		</tr>
			
		
	</c:forEach>
	</c:if>
	
	</table>
	
	<!-- 검색결과 값이 없는 경우 -->			
	<c:if test="${total == 0 }">
	<div id="result0">
		<h1>
			등록된 전문가리뷰가 없습니다
		</h1>
	</div>
	</c:if>
</div>




</div>

	<div class="manager_pagination">
	    <!-- 이전 페이지로 이동 -->
	    <c:if test="${page.startPage > page.pageBlock}">
	        <a id="page" class="manager_pagination_a_back" href="${pageContext.request.contextPath}/getReviewListSearch?currentPage=${page.startPage-page.pageBlock}&total=${total}&keyword=${keyword}">&nbsp; 이전 &nbsp;</a>
	    </c:if>
	
	    <!-- 페이징 번호 표시 -->
	    <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
	    	<c:choose>
	    		<c:when test="${i == page.currentPage}">
		        	<span class="manager_pagination_current">${i}</span>
		        </c:when>
	        	<c:otherwise>
	        		<a id="page" class="manager_pagination_a" href="${pageContext.request.contextPath}/getReviewListSearch?currentPage=${i}&total=${total}&keyword=${keyword}">&nbsp; ${i} &nbsp;</a>
	    		</c:otherwise>
	    	</c:choose>
	    </c:forEach>
	
	    <!-- 다음 페이지로 이동 -->
	    <c:if test="${page.endPage < page.totalPage}">
	        <a id="page" class="manager_pagination_a_next" href="${pageContext.request.contextPath}/getReviewListSearch?currentPage=${page.startPage+page.pageBlock}&total=${total}&keyword=${keyword}">&nbsp; 다음 &nbsp;</a>
	    </c:if>
	</div>


</div> 

</div>
</body>
	
</html>