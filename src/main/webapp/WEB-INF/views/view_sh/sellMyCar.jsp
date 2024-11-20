<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../header_white.jsp" %>
<!-- 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

	<style>
	
		@font-face {
	    font-family: 'Pretendard-Regular';
	    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
	    font-weight: 400;
	    font-style: normal;
		}
		
		body{
			font-family: 'Pretendard-Regular';
		    font-weight: 400;
		    font-style: normal;
		}
	
		.gray {
			background-color: #fafafa;
		}
		
		.gray h1 {
			margin-top: 50px;
			text-align: center;
			font-weight: bold;
		}
		
		form {
			display: grid;
            grid-template-columns: 1fr;
            grid-column-gap: 20px;
            grid-row-gap: 20px;
            width: 1020px;
            margin: 0 auto;
            background-color: #fff;
            padding: 150px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            text-align: left;
            margin-bottom: 50px;
		}
		
		.contract {
			margin: 10px auto 10px;
		    text-align: right;
		}
		
		.contract .requtxt{
			text-align: left;
			margin-bottom: 10px;
			
		}
		
		.img{
			display: block;
			margin: 0,auto;
			/* background-image: url('/images/main/sellMyCar/차량등록_box.png'); */
			margin-bottom: 50px;
		}
		
		.circle{
			margin-top: 50px;
			text-align:center;
		}
		
		#orange{
			margin-top:50px;
			display: inline;
			color:  #ff4714;
			font-weight: bold;
		}
		#black{
			margin-top:50px;
			display: inline;
			color:  #070707;
			font-weight: bold;
		}
		
		.contract .text {
			text-align: left;
		    height: 230px; 
		    border: 1px solid black; 
		    /* background-color: white; */
		    white-space: pre-line; 
		    overflow-y: scroll; 
		    margin: 0 auto 20px;
		    border: #e2e8ee 1px solid;
		}
		
		
		.contract .chk {
		    display: inline-block;
		    margin-bottom: 100px;
		}
		
		.text{
			margin-top: 5px;
			padding: 0px 30px;
			border: #e2e8ee 1px solid;	
			width: auto;
		}
		
		.butt {
		    display: flex; /* Flexbox를 사용하여 버튼들을 가로로 나란히 배치 */
		    justify-content: space-between; /* 버튼들 사이에 공간을 균등하게 배분 */
		    margin: 20px 0; /* 상하 여백 추가 */
		}
		
		.butt button {
		    background: none; /* 버튼 배경 제거 */
		    border: none; /* 버튼 테두리 제거 */
		    padding: 0; /* 버튼 패딩 제거 */
		}
		
		.contract .chk h5 {
		    display: inline;
		    color: #070707;
		    font-weight: bold;
		    margin-left: 5px;
		    margin-bottom: 50px;
		}
		
		.content {
			display: flex;
			flex-direction: column; /* 세로 방향으로 배치 */
			align-items: center; /* 수평 중앙 정렬 */
			justify-content: center; /* 수직 중앙 정렬 */
	        margin-bottom: 200px;
		}
		
		.join_step {
			display: flex;
			position: absolute;
			/* 플렉스 박스 레이아웃 사용 */
			top: 200px;
			justify-content: center;
			/* 가로 가운데 정렬 */
			list-style: none;
			/* 리스트 스타일 제거 */
			padding: 0;
			/* 기본 패딩 제거 */
			margin-bottom: 30px;
		}
		
		.join_step li {
			margin: 0 10px;
			/* 항목 간의 간격 설정 */
			position: relative;
			/* 텍스트 위치를 조정하기 위해 relative 유지 */
		}
		
		.join_step li img {
			width: 150px;
			/* 리스트 항목 내 이미지의 크기를 설정 */
		}
		
		.join_step li span {
			position: absolute;
			/* 텍스트를 절대 위치로 설정 */
			bottom: 0;
			left: 50%;
			/* 텍스트를 중앙 하단에 위치 */
			color: #666;
			/* 텍스트 색상 설정 */
			line-height: 1.462em;
			/* 텍스트 줄 간격 설정 */
			white-space: nowrap;
			/* 텍스트가 줄바꿈되지 않도록 설정 */
			transform: translate(-50%, 0);
			/* 텍스트를 중앙 정렬 */
		}

		#redirectButton {
			display: inline-block;
			width: 320px;
			height: 60px;
			border: solid #ff4714 1px;
			background-color: white;
			color: #ff4714;
			font-size: 16px;
			text-align: center;
			margin-right: 5%;
			line-height: 60px; /* height와 동일하게 설정 */
		}
		
		#nextButton{
			display: inline-block;
			width: 320px;
			height: 60px;
			border: solid #ff4714 2px;
			background-color: #ff4714;
			color: white;
			font-size: 16px;
			margin-left: 5%;
			text-align: center;
		}
			
			.divGroupButton {
				display: flex;
				margin-top: 50px;
				margin-bottom: 20px;
				text-align: center;
				align-items: center;
				justify-content: center;
			}
			
			input[type="checkbox"] {
				margin-right: 10px;
				accent-color: #ff4714;
			}
	</style>



			
		
<body>
<div class="gray">

	<div class="img">
		<div class="content">
			<h1>차량등록</h1>
			<ul class="join_step">
				<li><img src="<%=request.getContextPath()%>/images/sellMyCar/약관동의_선택.png"><span>약관동의</span></li>
				<li><img src="<%=request.getContextPath()%>/images/sellMyCar/차량등록_전.png"><span>차량정보 입력</span></li>
				<li><img src="<%=request.getContextPath()%>/images/sellMyCar/가입완료_전.png"><span>등록완료</span></li>
			</ul>
		</div>

		<form class="contract" action="/sellCarInfor">
			<div class="requtxt">
				<h4 id="orange">[필수]</h4><h4 id="black">약관동의</h4>
			</div>
            <div class="text">
            	가. 개인정보의 수집 및 이용 목적
 
                국가공간정보포털은 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 개인정보 보호법 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.
        
                나. 정보주체와 법정대리인의 권리ㆍ의무 및 행사방법
                ① 정보주체(만 14세 미만인 경우에는 법정대리인을 말함)는 언제든지 개인정보 열람·정정·삭제·처리정지 요구 등의 권리를 행사할 수 있습니다.
                ② 제1항에 따른 권리 행사는 개인정보보호법 시행규칙 별지 제8호 서식에 따라 작성 후 서면, 전자우편 등을 통하여 하실 수 있으며, 기관은 이에 대해 지체 없이 조치하겠습니다.
                ③ 제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다. 이 경우 개인정보 보호법 시행규칙 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다.
                ④ 개인정보 열람 및 처리정지 요구는 개인정보 보호법 제35조 제5항, 제37조 제2항에 의하여 정보주체의 권리가 제한 될 수 있습니다.
                ⑤ 개인정보의 정정 및 삭제 요구는 다른 법령에서 그 개인정보가 수집 대상으로 명시되어 있는 경우에는 그 삭제를 요구할 수 없습니다.
                ⑥ 정보주체 권리에 따른 열람의 요구, 정정ㆍ삭제의 요구, 처리정지의 요구 시 열람 등 요구를 한 자가 본인이거나 정당한 대리인인지를 확인합니다.
                
                다. 수집하는 개인정보의 항목
                국가공간정보포털 회원정보(필수): 이름, 이메일(아이디), 비밀번호
                
                라. 개인정보의 보유 및 이용기간
                국가공간정보포털은 법령에 따른 개인정보 보유ㆍ이용기간 또는 정보주체로부터 개인정보를 수집 시에 동의 받은 개인정보 보유ㆍ이용기간 내에서 개인정보를 처리ㆍ보유합니다.
                
                - 수집근거: 정보주체의 동의
                - 보존기간: 회원 탈퇴 요청 전까지(1년 경과 시 재동의)
                - 보존근거: 정보주체의 동의
                
                마. 동의 거부 권리 및 동의 거부에 따른 불이익
                위 개인정보의 수집 및 이용에 대한 동의를 거부할 수 있으나, 동의를 거부할 경우 회원 가입이 제한됩니다.
            </div>
            <div class="chk">
                <input type="checkbox" required="required"><h5> 동의합니다.</h5>
            </div>
            
            <div class="requtxt">
				<h4 id="orange">[필수]</h4><h4 id="black">약관동의</h4>
			</div>
            <div class="text">
            	가. 개인정보의 수집 및 이용 목적
 
                국가공간정보포털은 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 개인정보 보호법 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.
        
                나. 정보주체와 법정대리인의 권리ㆍ의무 및 행사방법
                ① 정보주체(만 14세 미만인 경우에는 법정대리인을 말함)는 언제든지 개인정보 열람·정정·삭제·처리정지 요구 등의 권리를 행사할 수 있습니다.
                ② 제1항에 따른 권리 행사는 개인정보보호법 시행규칙 별지 제8호 서식에 따라 작성 후 서면, 전자우편 등을 통하여 하실 수 있으며, 기관은 이에 대해 지체 없이 조치하겠습니다.
                ③ 제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다. 이 경우 개인정보 보호법 시행규칙 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다.
                ④ 개인정보 열람 및 처리정지 요구는 개인정보 보호법 제35조 제5항, 제37조 제2항에 의하여 정보주체의 권리가 제한 될 수 있습니다.
                ⑤ 개인정보의 정정 및 삭제 요구는 다른 법령에서 그 개인정보가 수집 대상으로 명시되어 있는 경우에는 그 삭제를 요구할 수 없습니다.
                ⑥ 정보주체 권리에 따른 열람의 요구, 정정ㆍ삭제의 요구, 처리정지의 요구 시 열람 등 요구를 한 자가 본인이거나 정당한 대리인인지를 확인합니다.
                
                다. 수집하는 개인정보의 항목
                국가공간정보포털 회원정보(필수): 이름, 이메일(아이디), 비밀번호
                
                라. 개인정보의 보유 및 이용기간
                국가공간정보포털은 법령에 따른 개인정보 보유ㆍ이용기간 또는 정보주체로부터 개인정보를 수집 시에 동의 받은 개인정보 보유ㆍ이용기간 내에서 개인정보를 처리ㆍ보유합니다.
                
                - 수집근거: 정보주체의 동의
                - 보존기간: 회원 탈퇴 요청 전까지(1년 경과 시 재동의)
                - 보존근거: 정보주체의 동의
                
                마. 동의 거부 권리 및 동의 거부에 따른 불이익
                위 개인정보의 수집 및 이용에 대한 동의를 거부할 수 있으나, 동의를 거부할 경우 회원 가입이 제한됩니다.
            </div>
            <div class="chk">
               	<input type="checkbox" required="required"><h5> 동의합니다.</h5>
            </div>
            
            <div class="divGroupButton">
	    		<a href="/">
		    		<div id="redirectButton">
		    			이전
		    		</div>
		    	</a>
	    		<button type="submit" id="nextButton">
	    			다음
	    		</button>
    		</div>
            
       </form>
	</div>
	<footer>
		<%@ include file="../footer.jsp" %>
	</footer>
</div>


</body>

</html>