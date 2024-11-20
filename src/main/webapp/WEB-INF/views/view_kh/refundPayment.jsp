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
	$(function() {
		$("#inputRefundPassword").change(function() {
			var originValue	= $("#sendRefundPassword").val();
			var inputValue	= $("#inputRefundPassword").val();
						
			if(inputValue == originValue){
				$("#caption").css({"color" : "blue"});
				$("#caption").val("입력값이 일치합니다");
				$("#requestButton").prop("disabled", false);
			} else{
				$("#caption").val("입력값이 일치하지 않습니다");
				$("#caption").css({"color" : "red"});
			}
		});
	});
	
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


#refundPassword{
	position: absolute;
	top: 100px;
	left: 40px;

}



#refundPasswordDirection{
	font-size: 20px;
	font-weight: 700;
}

#inputRefundPassword {
	text-align: center;
	font-size: 32px;
	width: 320px;
	height: 50px;
	margin: 30px 0px;
}

#caption {
	text-align: center;
	border-width: 0px;
	font-size: 14px;
	outline: none;	
}

#requestButton {
	background-color: #FF4714;
	color: #FDFDFD;
	font-weight: 900;
	border: none;
	cursor: pointer;
	text-align: center;
	width: 150px;
	height: 40px;
	margin: 30px 0px;
}
</style>

</head>
<body>
	<div id="fullBody">
		<img	src="<%=request.getContextPath()%>/images/main/kh_adminPopup.png"
				width="400px" 
				height="400px">
	</div>
	
	<div id="refundPassword">
		<input 	type="hidden"		
				id="sendRefundPassword"
				value="${sendRefundPassword }" />
		<input 	type="hidden"		
				id="tid"
				value="${tid }" />
		<span id="refundPasswordDirection">
			환불비밀번호를 입력하세요
		</span>
						
		<input 	type="text"		
				id="inputRefundPassword"/>
		<br>		
		<input 	type="text" 
				id="caption" />	
		
		<br>
		<input	type="button"
				id="requestButton"
				onclick="requestButton()" 
				disabled="disabled"
				value="환불승인" />
		
	</div>
				
	<h5>환불비밀번호: ${sendRefundPassword }</h5>

</body>
</html>