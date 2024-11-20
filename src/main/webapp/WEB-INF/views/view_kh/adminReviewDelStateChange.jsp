<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script>	
	function requestButton() {
		location.href="/KH/pay/requestRefundPayment?tid=" + $("#tid").val();
		window.close();	
		window.opener.location.reload(true);
	}

</script>
<style type="text/css">
/*
div {
	border: 1px solid black;
}
*/

body {
	text-align: center;
	align-items: center; 		/* 수평 중앙 정렬 */
	margin: 0;
	padding: 0;
	background-color: #fafafa;
	font-family: Pretendard;
}


#reviewDetailDiv{
	position: absolute;
	width: 400px;
	top: 70px;
}

.listCellLeft{
	font-size: 16px;
	color: #a3a3a3;
	font-weight: 700;
	height: 60px;
	width: 180px;
	padding: 0 10px;
	text-align: left;
}

.listCellRight{
	font-size: 16px;
	font-weight:900;
	height: 60px;
	width: 180px;
	padding: 0 10px;
	text-align: right;
}

#delButton {
	height: 32px;
	width: 150px;
	background-color: #FF4714;
	color: #FDFDFD;
	font-weight: 900;
	border: none;
	cursor: pointer;
	
}

#recButton {
	height: 32px;
	width: 150px;
	background-color: #FDFDFD;
	color: #FF4714;
	font-weight: 900;
	border: 2px solid #FF4714;
	cursor: pointer;
	margin: 5px;
	
}

</style>
<script type="text/javascript">
	function submitConfirm() {
		var delState = $("#del_state").val();
		if(delState==0) {
			location.href="/KH/pay/updateReviewDelState?del_state=" + $("#del_state").val() + "&expert_review_num=" + $("#exRewNum").val();
			window.close();	
			window.opener.location.reload(true);
		} else {
			location.href="/KH/pay/updateReviewDelState?del_state=" + $("#del_state").val() + "&expert_review_num=" + $("#exRewNum").val();
			window.close();	
			window.opener.location.reload(true);
		}
	}
</script>

</head>
<body>
	<div id="fullBody">
		<img	src="<%=request.getContextPath()%>/images/main/kh_adminPopup.png"
				width="400px" 
				height="400px">
	</div>
	<form action="/KH/pay/updateReviewDelState" id="reviewDetail">
		<input 	type="hidden"	name="del_state"			id="del_state"	value="${del_state }" 	 />
		<input 	type="hidden"	name="expert_review_num"	id="exRewNum"	value="${expertReviewDetail.expert_review_num }" />
	</form>
	<div id="reviewDetailDiv">
		
		<table>
			<tr>
				<td class="listCellLeft">
					전문가리뷰 번호 
				</td>
				<td class="listCellRight">
					${expertReviewDetail.expert_review_num }
				</td>
			</tr>
			<tr>
				<td class="listCellLeft">
					차량매물 번호
				</td>
				<td class="listCellRight">
					${expertReviewDetail.sell_num }
				</td>
			</tr>
			<tr>
				<td class="listCellLeft">
					리뷰 작성자ID
				</td>
				<td class="listCellRight">
					${expertReviewDetail.user_id }
				</td>
			</tr>
			<tr>
				<td class="listCellLeft">
					리뷰 작성자이름
				</td>
				<td class="listCellRight">
					${expert.user_name }
				</td>
			</tr>
			
			<tr>
				<td class="listCell" colspan="2">
				<c:set	var="delState"	value="${del_state}"/>
				<c:if test="${delState eq '0'}">
					<button	id="delButton" 	onclick="submitConfirm()">삭제</button>
				</c:if>
				<c:if test="${delState eq '1'}">
					<button	id="recButton"	onclick="submitConfirm()">복구</button>
				</c:if>
				</td>
			</tr>
		</table>	
	</div>
</body>
</html>