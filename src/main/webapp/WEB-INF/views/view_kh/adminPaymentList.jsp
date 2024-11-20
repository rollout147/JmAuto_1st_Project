<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<!DOCTYPE html>
<html>
<head>
<link href="<%=request.getContextPath()%>/css/adminList.css" rel="stylesheet">
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
	function sendRefundPassword(tid) {
		alert("환불비밀번호를 발송하였습니다!");
		var url = "/KH/pay/sendRefundPassword?tid=" + tid;		
		window.open(url, "_blank", 'width=410,height=410,location=no,status=no,scrollbars=no,top=100,left=300');
	}
	
/* 	
	$(function(){
		$('#autoComplete').autocomplete({
			source : function(request, response) {
			//source: keyword 입력 시 반환될 목록
			var search 		= $("select[name=search]").val();
			var itemReturn 	= "item." + search; 
				$.ajax({
						url : "/KH/pay/ajax.autocomplete",
						type : "POST",
						dataType: "JSON",
						data : {
								value: request.term,		//controller로 전달할 key
								search: search				//
						},	
		         		success : function(data){ 	// 성공
		             		response(
		             				$.map(data.resultList, function(item) {
		                     			return {
		                    	     			label : item.USER_ID,    		// 목록에 표시되는 값
		                           				value : item.USER_ID, 		// 선택 시 input창에 표시되는 값
		                     					};
		                 					})
		             				);										    //response
		         				},
		         			error : function(){ //실패
		             						alert("오류가 발생했습니다.");
		         							}
		     		
						});
				},
				focus : function(event, ui) { // 방향키로 자동완성단어 선택 가능하게 만들어줌	
											return false;
				},
				minLength: 2, 					// 최소 글자수
				autoFocus : true, 				// true == 첫 번째 항목에 자동으로 초점이 맞춰짐
				delay: 100,						//autocomplete 딜레이 시간(ms)
				select : function(evt, ui) {	// 아이템 선택시 실행 ui.item 이 선택된 항목을 나타내는 객체, lavel/value
											console.log(ui.item.label);
		 									}
		})
	});
 */	
</script>
</head>
<body>

	<header>
		<div class="header_continer"><%@ include file="../header.jsp" %></div>
	   	<div class="menu_continer"><%@ include file="../manager_menu.jsp" %></div>
	</header>
	
	<nav class="nav__cont">
		<img alt="logo" src="<%=request.getContextPath()%>/images/main/로고_icon_2.png" class="nav__cont_logo">
	  <ul class="nav">
	    <li class="nav__items3">
		  <img alt="icon" src="<%=request.getContextPath()%>/images/main/회원관리_icon.png" class="nav_items_img3">
	      <a href="/view_ms/buyList" class="nav_items_text3">회원</a>
	      <div class="mon_nav_items">
	      	<a>회원관리</a>
	      	<a>가입요청관리</a>
	      </div>
	    </li>
	      
	    <li class="nav__items3">
	      <img alt="icon" src="<%=request.getContextPath()%>/images/main/차량관리_icon.png" class="nav_items_img3">
	     <a href="" class="nav_items_text3">차량</a>
	     <div class="mon_nav_items">
	      	<a>차량관리</a>
	      	<a href="/KH/pay/expertReviewListCon">전문가 리뷰 관리</a>
	      	<a href="/KH/pay/paymentListCon">환불</a>
	      </div>
	    </li>
	      
	    <li class="nav__items3">
	      <img alt="icon" src="<%=request.getContextPath()%>/images/main/CS관리_icon.png" class="nav_items_img3">
	      <a href="/manager/CS/faq" class="nav_items_text3">CS</a>
	      <div class="mon_nav_items">
	      	<a href="/manager/CS/faq">자주 묻는 질문(FAQ)</a>
	      	<a href="/manager/CS/gogi">공지사항 및 약관</a>
	      	<a>문의내역</a>
	      </div>
	    </li>
	  </ul>
	</nav>
	
	<div id="tableTitle"><h1>관리자 환불승인</h1></div>
	<div id="fullbody">
	
		<div id="searchDiv">
			<form action="/KH/pay/paymentListCon">
				<select name="search">
					<option value="user_id">회원아이디</option>
					<option value="approval_num">승인번호</option>
					<option value="sell_num">매물번호</option>
					<option value="expert_review_num">전문가리뷰번호</option>
					<option value="buy_type">결제구분(1:차량/2:리뷰)</option>
					<option value="">전체검색</option>
				</select>
				<input	type="text"			name="keyword"	id="autoComplete" 	placeholder="keyword" />
				<input	type="hidden"		name="admin_id"	value="${admin_id }" />
				<button type="submit"		id="searchButton">SEARCH</button>
				
			</form>
		</div>
		
		<div id="listDiv">
	
			<c:set var="num" value="${page.total - page.start + 1 }"></c:set>
			
			<table id=listTable">
				<tr>
					<th class="listCell" style="width: 50px;">구분</th>
					<th class="listCell" style="width: 200px;">승인번호</th>
					<th class="listCell" style="width: 100px;">결제일시</th>
					<th class="listCell" style="width: 150px;">차량매물번호</th>
					<th class="listCell" style="width: 150px;">전문가리뷰번호</th>
					<th class="listCell" style="width: 120px;">구매자ID</th>
					<th class="listCell" style="width: 150px;">결제금액</th>
					<th class="listCell" style="width: 200px;">취소승인번호발송</th>
	
				</tr>
				
			<c:forEach	var="paymentList"	items="${paymentList}"	varStatus="status" >
				<tr>
					<td class="listCell">${num}</td>						
					<td class="listCell">${paymentList.approval_num}</td>
					<td class="listCell">${paymentList.approval_date}</td>
					<td class="listCell">${paymentList.sell_num}</td>
					<td class="listCell">${paymentList.expert_review_num}</td>
					<td class="listCell">${paymentList.user_id}</td>
					<td class="listCell">
						<fmt:formatNumber 	value="${paymentList.total_price}" 	pattern="#,###,###,###"/> 원
					</td>
					<td class="listCell">
						<button onclick="sendRefundPassword('${paymentList.approval_num}')" >
							환불비밀번호발송
						</button>
					</td>				
				</tr>
			<c:set		var="num"				value="${num - 1 }" />
			</c:forEach>
			</table>
		
		</div>
		
		<div id="pagingDiv">
			<div id="paging">
				<c:if test="${page.startPage > page.pageBlock }">
					<a href="/KH/pay/paymentListCon?currentPage=${page.startPage - page.pageBlock }&admin_id=${admin_id}&search=${originalPaymentList.search}&keyword=${originalPaymentList.keyword}">[Previous]</a>
				</c:if>
				
				<c:forEach var="i" begin="${page.startPage }" end="${page.endPage}">
					<a href="/KH/pay/paymentListCon?currentPage=${i }&admin_id=${admin_id}&search=${originalPaymentList.search}&keyword=${originalPaymentList.keyword}">[${i }]</a>
				</c:forEach>
				
				<c:if test="${page.startPage < page.pageBlock }">
					<a href="/KH/pay/paymentListCon?currentPage=${page.startPage + page.pageBlock }&admin_id=${admin_id}&search=${originalPaymentList.search}&keyword=${originalPaymentList.keyword}">[Next]</a>
				</c:if>
			</div>
		</div>
	
	</div>
	
</body>
</html>