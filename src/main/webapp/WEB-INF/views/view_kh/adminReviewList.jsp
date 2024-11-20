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
	function change(delState, expertReviewNum) {
		var url = "/KH/pay/changeReviewDelState?del_state=" + delState + "&expert_review_num=" + expertReviewNum;
		if(delState == 0) {
			alert("전문가 리뷰를 삭제합니다.");	
		}else{
			alert("삭제한 전문가 리뷰를 복원합니다.");
		}
		window.open(url, "_blank", 'width=410,height=410,location=no,status=no,scrollbars=no,top=100,left=300');
	}

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
	
	
	
	<div id="fullbody">
	
		<div id="searchDiv">
			<form action="/KH/pay/expertReviewListCon">
				<select name="search">
					<option value="user_id=">회원아이디</option>
					<option value="expert_review_num=">전문가리뷰번호</option>
					<option value="sell_num=">매물번호</option>
					<option value="1=1">전체검색</option>
				</select>
				<input	type="text"			name="keyword"	placeholder="keyword" />
				<input	type="hidden"		name="admin_id"	value="${admin_id }" />
				<button type="submit"		id="searchButton">SEARCH</button>
				
				<span id="loginId">LoginID: ${admin_id }</span>
			</form>
		</div>
		
		<div id="tableTitle">전문가리뷰 관리</div>
		
		<div id="listDiv">
	
			<c:set var="num" value="${page.total - page.start + 1 }"></c:set>
			
			<table id="listTable">
				<tr>
					<th class="listCell" style="width: 50px;">구분</th>
					<th class="listCell" style="width: 250px;">전문가리뷰번호</th>
					<th class="listCell" style="width: 250px;">차량매물번호</th>
					<th class="listCell" style="width: 200px;">작성일자</th>
					<th class="listCell" style="width: 220px;">작성자ID</th>
					<th class="listCell" style="width: 150px;">관리자기능</th>
	
				</tr>
				
			<c:forEach	var="exReviewList"	items="${exReviewList}"	varStatus="status" >
				<c:set	var="delState"	value="${exReviewList.del_state}"/>
				<tr>	
					<td class="listCell">${num}</td>						
					<td class="listCell">${exReviewList.expert_review_num}</td>
					<td class="listCell">${exReviewList.sell_num}</td>
					<td class="listCell">${exReviewList.write_date}</td>
					<td class="listCell">${exReviewList.user_id}</td>
					<td class="listCell">
						<c:if test="${delState eq '0'}">
							<button	id="delButton" 	onclick="change(${exReviewList.del_state}, ${exReviewList.expert_review_num})">삭제</button>
						</c:if>
						<c:if test="${delState eq '1'}">
							<button	id="recButton"	onclick="change(${exReviewList.del_state}, ${exReviewList.expert_review_num})">복구</button>
						</c:if>
					</td>				
				</tr>
			<c:set		var="num"				value="${num - 1 }" />
			</c:forEach>
			</table>
		
		</div>
		
		<div id="pagingDiv">
			<div id="paging">
				<c:if test="${page.startPage > page.pageBlock }">
					<a href="/KH/pay/expertReviewListCon?currentPage=${page.startPage - page.pageBlock }&admin_id=${admin_id}&search=${originalExpList.search}&keyword=${originalExpList.keyword}">[Previous]</a>
				</c:if>
				
				<c:forEach var="i" begin="${page.startPage }" end="${page.endPage}">
					<a href="/KH/pay/expertReviewListCon?currentPage=${i }&admin_id=${admin_id}&search=${originalExpList.search}&keyword=${originalExpList.keyword}">[${i }]</a>
				</c:forEach>
				
				<c:if test="${page.startPage < page.pageBlock }">
					<a href="/KH/pay/expertReviewListCon?currentPage=${page.startPage + page.pageBlock }&admin_id=${admin_id}&search=${originalExpList.search}&keyword=${originalExpList.keyword}">[Next]</a>
				</c:if>
			</div>
		</div>
	
	</div>
	
</body>
</html>