<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../header.jsp" %>
<title>Insert title here</title>
<style type="text/css">
body {
	font-family: 'Pretendard';
	margin: 0;
	padding: 0;
	box-sizing: border-box;

}

.error_Page_container{
	display: grid;
	grid-template-columns: minmax(auto, 1320px);
	justify-content: center;
	max-width: 100%;
	margin: 0px auto;
	background-color: #f7f7f7;
	height: auto;
}

.error_Page_content {
	background-color: #fdfdfd;
	box-shadow: 0 0 10px 5px rgb(0,0,0,0.06);
	text-align: center;
	margin: 40px 0 20px;
}

.error_Page_img {
	width: 100%;
	max-width: 350px;
	height: auto;
	margin: 80px 0 20px;
}

.error_Page_text1 {
	font-size: 40px;
	font-weight: 600;
	margin: 0 0 20px;
}

.error_Page_text2 {
	font-size: 20px;
	font-weight: 500;
	color: #777777;
	margin: 0 0 20px;
}

.error_Page_but{
	display: flex;
	justify-content: center;
}

.error_Page_but_back_a {
	color: #fdfdfd;
	text-decoration: none;
	background-color: #ff4714;
	padding: 20px 80px;
	margin: 0 0 80px;
	transition: background-color 0.3s ease;
}

.error_Page_but_back_a:hover{
	background-color: #323232;
}


error_Page_but_back_a:visited {
	color: #fdfdfd;
}

.error_Page_text3{
	text-align: center;
	margin: 0 0 80px;
}

.error_Page_text3_a{
	font-size: 20px;
	font-weight: 700;
	margin: 0 10px;
	color: #ff4714;
	text-decoration: underline;
}

.div_kakao {
    position: relative;
    z-index: 10;
    bottom: 185px;
}

.div_footer{
    z-index: 1;
}

</style>
</head>
<body>
	<div class="error_Page_container">
		<div class="error_Page_content">
			<img class="error_Page_img" alt="" src="<%=request.getContextPath()%>/images/main/우주_테두리.gif">
			<div class="error_Page_text1">문제가 있는 페이지 입니다.</div>
			<div class="error_Page_text2">잠시후에 다시 시도해보세요.</div>
			<div class="error_Page_but">
				<a class="error_Page_but_back_a" href="/">홈페이지로 이동</a>
			</div>
		</div>
		<div class="error_Page_text3">계속 문제가 일어나 도움이 필요하시면 <a class="error_Page_text3_a" href="/view_jw/csMain">고객지원</a>을 활용해주세요.</div>
	</div>
</body>
<div class="div_kakao"><%@ include file="../kakao.jsp"%></div>
<footer>
	
	<div class="div_footer"><%@ include file="../footer.jsp" %></div>
</footer>
</html>